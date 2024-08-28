import 'package:dartz/dartz.dart';
import 'package:ekang_flutter/core/error/failures.dart';
import 'package:ekang_flutter/core/usecases/use_case.dart';
import 'package:ekang_flutter/features/authentication/data/model/user_model.dart';
import 'package:ekang_flutter/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:fimber/fimber.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthenticationUseCase implements UseCase<UserModel, NoParams> {
  final IAuthenticationRepository repository;

  AuthenticationUseCase(this.repository);

  @override
  Future<Either<Failure, UserModel>> call(NoParams params) async {
    try {
      return Right(UserModel(id: "", email: "", displayName: ""));
    } catch (exception, stacktrace) {
      if (kDebugMode) {
        Fimber.e(
            "call() | exception: $exception (stacktrace: ${stacktrace.toString()})");
      }
      return Left(Failure('Failure: $exception'));
    }
  }

  Future<Either<Failure, UserModel?>> signUpUser({
    required String email,
    required String password,
  }) async {
    Fimber.d("login() | email: $email, password: $password");

    try {
      return await repository.signUpUser(email: email, password: password);
    } catch (exception, stacktrace) {
      if (kDebugMode) {
        Fimber.e(
            "login() | exception: $exception (stacktrace: ${stacktrace.toString()})");
      }
      return Left(Failure("Failure: ${exception.toString()}"));
    }
  }

  Future<Either<Failure, UserCredential>> signInWithCredential(
    OAuthCredential credential,
  ) async {
    Fimber.d("signInWithCredential() | credential: $credential");

    try {
      return await repository.signInWithCredential(credential);
    } catch (exception, stacktrace) {
      if (kDebugMode) {
        Fimber.e(
            "signInWithCredential() | exception: $exception (stacktrace: ${stacktrace.toString()})");
      }
      return Left(Failure("Failure: ${exception.toString()}"));
    }
  }

  Future<bool> isLoggedIn() async {
    Fimber.e("isLoggedIn()");

    try {
      final isLoggedIn = await repository.isLoggedIn();
      return isLoggedIn;
    } catch (exception, stacktrace) {
      if (kDebugMode) {
        Fimber.e(
            "isLoggedIn() | exception: $exception (stacktrace: ${stacktrace.toString()})");
      }
      return false;
    }
  }

  Future<void> signOutUser() async {
    Fimber.e("signOutUser()");

    try {
      await repository.signOut();
    } catch (exception, stacktrace) {
      if (kDebugMode) {
        Fimber.e(
            "signOutUser() | exception: $exception (stacktrace: ${stacktrace.toString()})");
      }
      return;
    }
  }
}
