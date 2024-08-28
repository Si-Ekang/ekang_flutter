part of 'authentication_bloc.dart';

/// This is the base class for different events that trigger authentication state changes.
abstract class AuthenticationEvent {
  const AuthenticationEvent();

  List<Object> get props => [];
}

class AuthenticationInitialEvent extends AuthenticationEvent {
  const AuthenticationInitialEvent();

  @override
  List<Object> get props => [];
}

/// This class represents an event where a user is attempting to sign up.
///
/// It takes two parameters, email and password, representing the credentials the user is using to sign up.
///
/// This class's instances will signal the Bloc that a user is trying to sign up, and the Bloc can respond by initiating the sign-up process and transitioning the authentication state accordingly.
class SignUpUser extends AuthenticationEvent {
  final String email;
  final String password;

  const SignUpUser(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class SignInWithGoogle extends AuthenticationEvent {

  const SignInWithGoogle();

  @override
  List<Object> get props => [];
}


class IsLoggedIn extends AuthenticationEvent {}

/// This class's instances will signal the Bloc that a user is trying to sign out. The bloc can respond by initiating the sign-out process and updating the authentication state accordingly.
class SignOut extends AuthenticationEvent {}
class Retry extends AuthenticationEvent {}
class ResetState extends AuthenticationEvent {}
