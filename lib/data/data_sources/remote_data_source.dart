import 'package:dartz/dartz.dart';
import 'package:ekang_flutter/data/data_sources/i_remote_data_source.dart';
import 'package:ekang_flutter/features/authentication/data/model/user_model.dart';
import 'package:fimber/fimber.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../core/error/failures.dart';

class RemoteDataSource extends IRemoteDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<void> isLoggedIn() {
    // TODO: implement isLoggedIn
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserModel?>> login({
    required String email,
    required String password,
  }) async {
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
  Future<void> signOut() async {
    final User? firebaseUser = _firebaseAuth.currentUser;

    if (firebaseUser != null) {
      await _firebaseAuth.signOut();
    }
  }

  @override
  Future<void> updateLoggedIn(bool isLoggedIn) {
    // TODO: implement updateLoggedIn
    throw UnimplementedError();
  }

  @override
  Future<void> updateToken(String? token) {
    // TODO: implement updateToken
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserCredential>> signInWithCredential(
    OAuthCredential credential,
  ) async {
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
}
