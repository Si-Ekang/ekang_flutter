import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class OfflineFailure extends Failure {
  const OfflineFailure(super.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class WeekPassFailure extends Failure {
  const WeekPassFailure(super.message);
}

class ExistedAccountFailure extends Failure {
  const ExistedAccountFailure(super.message);
}

class NoUserFailure extends Failure {
  const NoUserFailure(super.message);
}

class WrongPasswordFailure extends Failure {
  const WrongPasswordFailure(super.message);
}

class UnmatchedPassFailure extends Failure {
  const UnmatchedPassFailure(super.message);
}

class NotLoggedInFailure extends Failure {
  const NotLoggedInFailure(super.message);
}

class EmailVerifiedFailure extends Failure {
  const EmailVerifiedFailure(super.message);
}

class TooManyRequestsFailure extends Failure {
  const TooManyRequestsFailure(super.message);
}
