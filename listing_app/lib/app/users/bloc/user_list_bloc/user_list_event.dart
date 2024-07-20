import 'package:equatable/equatable.dart';

abstract class UserListEvent extends Equatable {
  const UserListEvent();
}

class FetchUsers extends UserListEvent {
  @override
  List<Object> get props => [];
}

class RefreshUsers extends UserListEvent {
  @override
  List<Object> get props => [];
}