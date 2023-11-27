part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}
class GetAllPostEvent extends PostsEvent{}
class RefreshAllPostEvent extends PostsEvent {}
