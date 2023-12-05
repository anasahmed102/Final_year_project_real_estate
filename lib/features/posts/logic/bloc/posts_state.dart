part of 'posts_bloc.dart';

@immutable
abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class LoadingPostsState extends PostsState {}

class ErrorPostsState extends PostsState {
  final String message;
  const ErrorPostsState({
    required this.message,
  });
}

class LoadedPostsState extends PostsState {
  final Stream<List<RealEstateModel>> realEstate;

  const LoadedPostsState({required this.realEstate});

  @override
  List<Object> get props => [realEstate];
}
