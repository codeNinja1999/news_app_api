import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => <dynamic>[];
}

class NetworkDisconnected extends Failure {
  final String message;
  NetworkDisconnected(this.message);

  @override
  String toString() => message;

  @override
  List<Object?> get props => [message];
}

class EmptyList extends Failure {
  final String message;
  EmptyList(this.message);

  @override
  String toString() => message;

  @override
  List<Object?> get props => [message];
}

class UnknownFailure extends Failure {

  final dynamic message;

  UnknownFailure(this.message);

  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "Exception";
    return "Exception: $message";
  }

  @override
  List<Object?> get props => [message];
}


class ServerFailure extends Failure {
  final String message;
  ServerFailure(this.message);

  @override
  String toString() => message;

  @override
  List<Object?> get props => [message];
}
