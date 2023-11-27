// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure({
    required this.message,
  });
}

class OfflineFailure extends Failure {
  const OfflineFailure({required super.message});

  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message});

  @override
  List<Object> get props => [];
}

class EmptycacheFailure extends Failure {
  const EmptycacheFailure({required super.message});

  @override
  List<Object> get props => [];
}

class WrongDataFailure extends Failure {
  const WrongDataFailure({required super.message});

  @override
  List<Object> get props => [];
}
