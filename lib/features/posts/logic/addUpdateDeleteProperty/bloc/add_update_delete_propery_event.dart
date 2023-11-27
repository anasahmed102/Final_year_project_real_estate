part of 'add_update_delete_propery_bloc.dart';

@immutable
abstract class AddUpdateDeleteProperyEvent extends Equatable {
  const AddUpdateDeleteProperyEvent();

  @override
  List<Object> get props => [];
}

class AddPropertyEvent extends AddUpdateDeleteProperyEvent {
  final RealEstateModel realEstateModel;

  const AddPropertyEvent({required this.realEstateModel});

  @override
  List<Object> get props => [realEstateModel];
}
