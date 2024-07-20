// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:listing_app/app/users/data/model/user.dart';

abstract class UserListState extends Equatable {
  const UserListState();
}

class UserListInitial extends UserListState {
  @override
  List<Object> get props => [];
}

class UserListLoading extends UserListState {
  @override
  List<Object> get props => [];
}

class UserListLoaded extends UserListState {
  final List<User> users;

  const UserListLoaded({required this.users});

  @override
  List<Object> get props => [users];
}

class UserListError extends UserListState {
  final String title;
  final dynamic message;

  const UserListError({
    required this.title,
    required this.message,
  });

  @override
  List<Object> get props => [title,message];
}

// refresh user
class UserRefreshing extends UserListState {
  @override
  List<Object> get props => [];
}

class UserListRefresh extends UserListState {
  final List<User> users;

  const UserListRefresh({required this.users});

  @override
  List<Object> get props => [users];
}

class UserListRefreshError extends UserListState {
  final String title;
  final dynamic message;

  const UserListRefreshError({
    required this.title,
    required this.message,
  });

  @override
  List<Object> get props => [title,message];
}