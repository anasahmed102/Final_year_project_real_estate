import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:real_estaye_app/core/failures/failures.dart';
import 'package:real_estaye_app/features/posts/data/model/real_estate.dart';
import 'package:real_estaye_app/features/posts/domain/usecases/add_property_usecase.dart';
import 'package:real_estaye_app/injection.dart';

part 'add_update_delete_propery_event.dart';
part 'add_update_delete_propery_state.dart';

class AddUpdateDeleteProperyBloc
    extends Bloc<AddUpdateDeleteProperyEvent, AddUpdateDeleteProperyState> {
  AddUpdateDeleteProperyBloc() : super(AddUpdateDeleteProperyInitial()) {
    on<AddUpdateDeleteProperyEvent>((event, emit) async {
      if (event is AddPropertyEvent) {
        emit(PropertyLoadingState());
        final failureOrDone =
            await AddPropertyUsecases(getIt()).call(event.realEstateModel);
        emit(_eitherFailureOrDone(
            either: failureOrDone, successMessage: "Proerty Added Succesfuly"));
      }
    });
  }
  AddUpdateDeleteProperyState _eitherFailureOrDone(
      {required Either<Failure, void> either, required String successMessage}) {
    return either.fold(
      (failure) => PropertyErrorState(message: _mapFailureToMessage(failure)),
      (_) => PropertyMessageState(message: successMessage),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "";

      case OfflineFailure:
        return "";

      default:
        return 'Unexpected Error, Please try again later .';
    }
  }
}
