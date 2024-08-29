import 'package:dartz/dartz.dart';
import 'package:ekang_flutter/core/error/failures.dart';
import 'package:ekang_flutter/features/authentication/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Interface for the data implementation
abstract class IAuthenticationRepository {
  /// This methods is used when a user is attempting to sign up.
  ///
  /// It takes two parameters, email and password, representing the credentials the user is using to sign up.
  Future<Either<Failure, UserModel?>> signUpUser({
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
