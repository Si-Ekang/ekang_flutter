import 'package:dartz/dartz.dart';
import 'package:ekang_flutter/core/error/failures.dart';
import 'package:ekang_flutter/data/data_sources/i_remote_data_source.dart';
import 'package:ekang_flutter/data/models/user_model.dart';
import 'package:fimber/fimber.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthenticationUseCase {
  final IRemoteDataSource repository;

  AuthenticationUseCase(this.repository);

  /*@override
  Future<Either<Failure, User>> call(NoParams params) {
    try {
      return Right(User());
    } catch (exception,stacktrace) {
      if (kDebugMode) {
        Fimber.e("getCatchRound() | exception: $exception (stacktrace: ${stacktrace.toString()})");
      }
      return Left(Failure('Failure: $exception'));
    }
  }*/
  Future<Either<Failure, UserModel?>> signUpUser({
    required String email,
    required String password,
  }) async {
    Fimber.d("login() | email: $email, password: $password");

    try {
      return await repository.login(email: email, password: password);
    } catch (exception, stacktrace) {
      if (kDebugMode) {
        Fimber.e(
            "login() | exception: $exception (stacktrace: ${stacktrace.toString()})");
      }
      return Left(Failure("Failure: ${exception.toString()}"));
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
}
