import 'package:ekang_flutter/features/authentication/data/model/user_model.dart';
import 'package:ekang_flutter/features/authentication/domain/use_cases/authentication_use_case.dart';
import 'package:fimber/fimber.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

/// The AuthenticationBloc will handle the overall authentication state, from what happens when a user clicks a button to what shows on the screen.
///
/// It also interacts with the Firebase service we created directly.
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationUseCase useCase;

  AuthenticationBloc({
    required this.useCase,
  }) : super(AuthenticationInitialState()) {
    on<AuthenticationEvent>((event, emit) {});

    on<SignUpUser>(_signUp);
    on<SignInWithGoogle>(_signInWithGoogle);
    on<IsLoggedIn>(_isLoggedIn);
    on<SignOut>(_signOut);
    on<ResetState>(_resetState);
  }

  Future<void> _signUp(
    SignUpUser event,
    Emitter<AuthenticationState> emit,
  ) async {
    Fimber.d("_signUp()");

    emit(AuthenticationLoadingState(isLoading: true));
    try {
      final result = await useCase.signUpUser(
        email: event.email,
        password: event.password,
      );

      result.fold((failure) {
        emit(AuthenticationFailureState(failure.message));
      }, (user) {
        if (user != null) {
          emit(AuthenticationSuccessState(user));
        } else {
          emit(const AuthenticationFailureState('create user failed'));
        }
      });
    } catch (exception, stacktrace) {
      if (kDebugMode) {
        Fimber.e(
            "_signUp() | exception: $exception (stacktrace: ${stacktrace.toString()})");
      }
    }
    // emit(AuthenticationLoadingState(isLoading: false));
  }

  Future<void> _signInWithGoogle(
    SignInWithGoogle event,
    Emitter<AuthenticationState> emit,
  ) async {
    Fimber.d("_signInWithGoogle()");

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      emit(AuthenticationLoadingState(isLoading: true));
      final result = await useCase.signInWithCredential(credential);

      result.fold((failure) {
        emit(AuthenticationFailureState(failure.message));
      }, (user) {
        emit(AuthenticationSuccessState(user.toUserModel()));
      });
    } on FirebaseAuthException catch (error, stacktrace) {
      if (kDebugMode) {
        Fimber.e(
            "_signInWithGoogle() | exception: $error (stacktrace: ${stacktrace.toString()})");
      }
      emit(AuthenticationFailureState(error.message!));
    } on PlatformException catch (error, stacktrace) {
      if (kDebugMode) {
        Fimber.e(
            "_signInWithGoogle() | exception: $error (stacktrace: ${stacktrace.toString()})");
      }
      emit(AuthenticationFailureState(error.message!));
    } catch (error, stacktrace) {
      if (kDebugMode) {
        Fimber.e(
            "_signInWithGoogle() | exception: $error (stacktrace: ${stacktrace.toString()})");
      }
      emit(const AuthenticationFailureState(
          "Unexpected error please try again later"));
    }

    // emit(AuthenticationLoadingState(isLoading: false));
  }

  Future<void> _isLoggedIn(
    IsLoggedIn event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      final result = await useCase.isLoggedIn();
      Fimber.d("_isLoggedIn() | is user logged in: $result");
    } catch (exception, stacktrace) {
      if (kDebugMode) {
        Fimber.e(
            "_isLoggedIn() | exception: $exception (stacktrace: ${stacktrace.toString()})");
      }
    }
  }

  Future<void> _signOut(
    SignOut event,
    Emitter<AuthenticationState> emit,
  ) async {
    Fimber.e("_signOut()");

    emit(AuthenticationLoadingState(isLoading: true));
    try {
      await useCase.signOutUser();
    } catch (exception, stacktrace) {
      if (kDebugMode) {
        Fimber.e(
            "_signOut() | exception: $exception (stacktrace: ${stacktrace.toString()})");
      }
    }
    emit(AuthenticationLoadingState(isLoading: false));

    emit(AuthenticationInitialState());
  }

  void _resetState(
    ResetState event,
    Emitter<AuthenticationState> emit,
  ) {
    Fimber.e("_resetState()");

    emit(AuthenticationLoadingState(isLoading: true));
    emit(AuthenticationInitialState());
  }
}
