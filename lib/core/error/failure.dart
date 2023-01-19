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

  @override
  List<Object?> get props => [];
}


class ServerFailure extends Failure {
  final String message;
  ServerFailure(this.message);

  @override
  String toString() => message;

  @override
  List<Object?> get props => [message];
}
