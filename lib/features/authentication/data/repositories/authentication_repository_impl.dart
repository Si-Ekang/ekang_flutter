import 'package:dartz/dartz.dart';
import 'package:ekang_flutter/core/error/failures.dart';
import 'package:ekang_flutter/features/authentication/data/model/user_model.dart';
import 'package:ekang_flutter/features/authentication/data/data_sources/authentication_local_data_source.dart';
import 'package:ekang_flutter/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepositoryImpl extends IAuthenticationRepository {
  final AuthenticationLocalDataSource _localDataSource;

  AuthenticationRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, UserModel?>> signUpUser({
    required String email,
    required String password,
  }) async =>
      await _localDataSource.login(
        email: email,
        password: password,
      );

  @override
  Future<Either<Failure, UserCredential>> signInWithCredential(
    OAuthCredential credential,
  ) async =>
      await _localDataSource.signInWithCredential(
        credential,
      );

  @override
  Future<bool> isLoggedIn() async => await _localDataSource.isLoggedIn();

  @override
  Future<Either<Failure, bool>> signOut() async =>
      await _localDataSource.signOut();
}
