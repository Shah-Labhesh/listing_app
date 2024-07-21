// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:listing_app/app/posts/data/model/comment.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class FetchPosts extends PostEvent {}

class RefreshPosts extends PostEvent {}

class FetchPostDetail extends PostEvent {
  final int postId;

  const FetchPostDetail({required this.postId});

  @override
  List<Object> get props => [postId];
}

class AddComment extends PostEvent {
  final int postId;
  final Comment comment;

  const AddComment({
    required this.postId,
    required this.comment,
  });

  @override
  List<Object> get props => [postId, comment];
}
