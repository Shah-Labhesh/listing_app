import 'package:equatable/equatable.dart';

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