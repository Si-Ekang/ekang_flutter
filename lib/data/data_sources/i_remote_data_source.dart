import 'package:dartz/dartz.dart';
import 'package:ekang_flutter/core/error/failures.dart';
import 'package:ekang_flutter/features/authentication/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IRemoteDataSource {
  Future<Either<Failure, UserModel?>> login(
      {required String email, required String password});

  Future<Either<Failure, UserCredential>> signInWithCredential(
    OAuthCredential credential,
  );

  Future<void> updateToken(String? token);

  Future<void> isLoggedIn();

  Future<void> updateLoggedIn(bool isLoggedIn);

  Future<void> signOut();
}
