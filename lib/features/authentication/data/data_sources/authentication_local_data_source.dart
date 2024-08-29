import 'package:dartz/dartz.dart';
import 'package:ekang_flutter/core/error/failures.dart';
import 'package:ekang_flutter/features/authentication/data/model/user_model.dart';
import 'package:fimber/fimber.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

//////////////////////////////////////
// Interface
//////////////////////////////////////
abstract class IAuthenticationLocalDataSource {
  /// This methods is used when a user is attempting to sign up.
  ///
  /// It takes two parameters, email and password, representing the credentials the user is using to sign up.
  Future<Either<Failure, UserModel?>> login({
    required String email,
    required String password,
  });

  /// This method is used when a user is attempting to sign in using Google Credential (google account directly).
  Future<Either<Failure, UserCredential>> signInWithCredential(
    OAuthCredential credential,
  );

  Future<bool> isLoggedIn();

  /// This method is used to sign out the user.
  Future<Either<Failure, bool>> signOut();
}

//////////////////////////////////////
// Implementation
//////////////////////////////////////
class AuthenticationLocalDataSource extends IAuthenticationLocalDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Either<Failure, UserModel?>> login(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      final User? firebaseUser = userCredential.user;

      if (null == firebaseUser) {
        return const Left(Failure("User credential is null"));
      }

      return Right(UserModel(
        id: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        displayName: firebaseUser.displayName ?? '',
      ));
    } on FirebaseAuthException catch (error, stacktrace) {
      if (kDebugMode) {
        Fimber.e(
            "login() | exception: $error (stacktrace: ${stacktrace.toString()})");
      }
      return Left(Failure(error.toString()));
    } on PlatformException catch (error, stacktrace) {
      if (kDebugMode) {
        Fimber.e(
            "login() | exception: $error (stacktrace: ${stacktrace.toString()})");
      }
      return Left(Failure(error.toString()));
    } catch (error, stacktrace) {
      if (kDebugMode) {
        Fimber.e(
            "login() | exception: $error (stacktrace: ${stacktrace.toString()})");
      }
      return const Left(Failure("Unexpected error please try again later"));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signInWithCredential(
      OAuthCredential credential) async {
    try {
      final result = await _firebaseAuth.signInWithCredential(credential);
      return Right(result);
    } on FirebaseAuthException catch (error, stacktrace) {
      if (kDebugMode) {
        Fimber.e(
            "signInWithCredential() | exception: $error (stacktrace: ${stacktrace.toString()})");
      }
      return Left(Failure(error.toString()));
    } on PlatformException catch (error, stacktrace) {
      if (kDebugMode) {
        Fimber.e(
            "signInWithCredential() | exception: $error (stacktrace: ${stacktrace.toString()})");
      }
      return Left(Failure(error.toString()));
    } catch (error, stacktrace) {
      if (kDebugMode) {
        Fimber.e(
            "signInWithCredential() | exception: $error (stacktrace: ${stacktrace.toString()})");
      }
      return const Left(Failure("Unexpected error please try again later"));
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      final result = await _firebaseAuth.currentUser;

      if (null == result) {
        return false;
      }

      return true;
    } catch (error, stacktrace) {
      if (kDebugMode) {
        Fimber.e(
            "isLoggedIn() | exception: $error (stacktrace: ${stacktrace.toString()})");
      }
      return false;
    }
  }

  @override
  Future<Either<Failure, bool>> signOut() async {
    Fimber.e("signOut()");

    try {
      final User? firebaseUser = _firebaseAuth.currentUser;

      if (firebaseUser != null) {
        await _firebaseAuth.signOut();
      }

      return const Right(true);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        Fimber.e(
            "signInWithCredential() | exception: $error (stacktrace: ${stacktrace.toString()})");
      }
      return const Left(Failure("Unexpected error please try again later"));
    }
  }
}
