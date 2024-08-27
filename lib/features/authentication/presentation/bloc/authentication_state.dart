part of 'authentication_bloc.dart';

/// The AuthenticationState class is responsible for the authentication process's different states. As we will see in the code, there are initial, loading, success, and failure states to ensure we know what happens during the authentication process.
///
/// The AuthenticationState is the base class for different states where the authentication process can be at any time.
///
/// It contains a method props that returns a list of objects. This method is used for equality checking when comparing instances of this class.
abstract class AuthenticationState {
  const AuthenticationState();

  List<Object> get props => [];
}

/// AuthenticationInitialState represents the initial state of the authentication process.
class AuthenticationInitialState extends AuthenticationState {}

/// AuthenticationLoadingState represents a state where the authentication process is in progress, and the UI might show a loading indicator.
///
/// It takes a boolean parameter, isLoading, to indicate whether or not the authentication process is currently loading.
class AuthenticationLoadingState extends AuthenticationState {
  final bool isLoading;

  AuthenticationLoadingState({required this.isLoading});
}

/// AuthenticationSuccessState represents a state where the authentication process has been completed.
///
/// It includes a user property of type UserModel representing the authenticated user.
class AuthenticationSuccessState extends AuthenticationState {
  final UserModel user;

  const AuthenticationSuccessState(this.user);

  @override
  List<Object> get props => [user];
}

/// AuthenticationFailureState represents a state where the authentication process has failed.
///
/// It includes an error message property containing information about the failure.
class AuthenticationFailureState extends AuthenticationState {
  final String errorMessage;

  const AuthenticationFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
