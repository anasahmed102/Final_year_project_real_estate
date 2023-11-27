part of 'posts_bloc.dart';

@immutable
abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}


 class PostsInitial extends PostsState {}
class LoadingTodoState extends PostsState {}

class ErrorTodosState extends PostsState {
  final String message;
  const ErrorTodosState({
    required this.message,
  });
}

class LoadedTodosState extends PostsState {
  final Stream<List<RealEstateModel>> realEstate;

  const LoadedTodosState({required this.realEstate});

  @override
  List<Object> get props => [realEstate];
}
