import 'package:equatable/equatable.dart';
import 'package:listing_app/app/posts/data/model/post.dart';

abstract class UserPostState extends Equatable {
  const UserPostState();
}

class UserPostInitial extends UserPostState {
  @override
  List<Object> get props => [];
}

class UserPostLoading extends UserPostState {
  @override
  List<Object> get props => [];
}

class UserPostLoaded extends UserPostState {
  final List<Post> posts;

  const UserPostLoaded({required this.posts});

  @override
  List<Object> get props => [posts];
}

class UserPostError extends UserPostState {
  final String error;
  final dynamic message;

  const UserPostError({
    required this.error,
    required this.message,
  });

  @override
  List<Object> get props => [error, message];
}

class UserPostRefreshing extends UserPostState {
  @override
  List<Object> get props => [];
}

class UserPostRefreshed extends UserPostState {
  final List<Post> posts;

  const UserPostRefreshed({required this.posts});

  @override
  List<Object> get props => [posts];
}

class UserPostRefreshError extends UserPostState {
  final String error;
  final dynamic message;

  const UserPostRefreshError({
    required this.error,
    required this.message,
  });

  @override
  List<Object> get props => [error, message];
}

