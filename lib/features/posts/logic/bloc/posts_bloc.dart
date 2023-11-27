import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:real_estaye_app/core/failures/failures.dart';
import 'package:real_estaye_app/features/posts/data/model/real_estate.dart';
import 'package:real_estaye_app/features/posts/domain/usecases/get_all_posts_usecase.dart';
import 'package:real_estaye_app/injection.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostEvent) {
        emit(LoadingTodoState());

        final failureOrPost = await GetAllTodoUsecases(getIt()).call();
        emit(_mapfilureorPostToState(failureOrPost));
      } else if (event is RefreshAllPostEvent) {
        emit(LoadingTodoState());

        final failureOrPost = await GetAllTodoUsecases(getIt()).call();
        emit(_mapfilureorPostToState(failureOrPost));
      }
    });
  }

  PostsState _mapfilureorPostToState(
      Either<Failure, Stream<List<RealEstateModel>>> either) {
      final result = either.fold(
        (l) => const ErrorTodosState(message: "Error Please Check your internet connection and try again later"),
        (r) => LoadedTodosState(realEstate: r),
      );
      return result;
    
  }
}
