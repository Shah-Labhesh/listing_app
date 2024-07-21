// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:listing_app/app/posts/data/model/comment.dart';
import 'package:listing_app/app/posts/data/model/post.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<Post> posts;
  const PostLoaded({required this.posts});

  @override
  List<Object> get props => [posts];
}

class PostError extends PostState {
  final String title;
  final dynamic message;
  const PostError({
    required this.title,
    required this.message,
  });

  @override
  List<Object> get props => [title, message];
}

class RefreshingPost extends PostState {}

class PostRefreshed extends PostState {
  final List<Post> posts;
  const PostRefreshed({required this.posts});

  @override
  List<Object> get props => [posts];
}

class PostRefreshError extends PostState {
  final String title;
  final dynamic message;
  const PostRefreshError({
    required this.title,
    required this.message,
  });

  @override
  List<Object> get props => [title, message];
}

class PostDetailLoading extends PostState {}

class PostDetailLoaded extends PostState {
  final List<Comment> comment;
  const PostDetailLoaded({required this.comment});

  @override
  List<Object> get props => [comment];
}

class PostDetailError extends PostState {
  final String title;
  final dynamic message;
  const PostDetailError({
    required this.title,
    required this.message,
  });

  @override
  List<Object> get props => [title, message];
}

// comment post
class CommmentingOnPost extends PostState {}

class CommentedOnPost extends PostState {
  final List<Comment> comment;
  const CommentedOnPost({required this.comment});

  @override
  List<Object> get props => [comment];
}

class FailedCommentingOnPost extends PostState {
  final String title;
  final dynamic message;
  const FailedCommentingOnPost({
    required this.title,
    required this.message,
  });

  @override
  List<Object> get props => [title, message];
}
