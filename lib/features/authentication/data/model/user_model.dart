import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? id;
  String? email;
  String? password;
  String? displayName;
  String? photoURL;
  String? token;

  UserModel({required this.id, required this.email, required this.displayName});

  UserModel.withPhotoUrl(
      {required this.id,
      required this.email,
      required this.displayName,
      required this.photoURL});
}

extension UserCredentialExtension on UserCredential {
  UserModel toUserModel() => UserModel(
        id: this.user!.uid,
        email: this.user!.email,
        displayName: this.user!.displayName,
      );

  UserModel toUserModelWithPhotoUrl() => UserModel.withPhotoUrl(
        id: this.user!.uid,
        email: this.user!.email,
        displayName: this.user!.displayName,
        photoURL: this.user!.photoURL,
      );
}
