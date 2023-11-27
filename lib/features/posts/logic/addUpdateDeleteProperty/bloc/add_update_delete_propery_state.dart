part of 'add_update_delete_propery_bloc.dart';

@immutable
abstract class AddUpdateDeleteProperyState extends Equatable {
  const AddUpdateDeleteProperyState();

  @override
  List<Object> get props => [];
}

final class AddUpdateDeleteProperyInitial extends AddUpdateDeleteProperyState {}
class PropertyLoadingState extends AddUpdateDeleteProperyState {}

class PropertyErrorState extends AddUpdateDeleteProperyState {
  final String message;

  const PropertyErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class PropertyMessageState extends AddUpdateDeleteProperyState {
  final String message;

  const PropertyMessageState({required this.message});

  @override
  List<Object> get props => [message];
}
