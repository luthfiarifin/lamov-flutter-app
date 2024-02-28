import 'package:equatable/equatable.dart';

abstract class BaseException extends Equatable implements Exception {
  final String? message;

  const BaseException(this.message);

  @override
  List<Object?> get props => [message];
}

class RemoteException extends BaseException {
  final int? status;

  const RemoteException({String? message, this.status}) : super(message);

  @override
  List<Object?> get props => super.props..add(status);
}

class LocalException extends BaseException {
  const LocalException({String? message}) : super(message);
}
