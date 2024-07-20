import 'package:equatable/equatable.dart';

abstract class UserPostEvent extends Equatable {
  const UserPostEvent();
}

class FetchUserPosts extends UserPostEvent {
  @override
  List<Object> get props => [];
}

class RefreshUserPosts extends UserPostEvent {
  @override
  List<Object> get props => [];
}