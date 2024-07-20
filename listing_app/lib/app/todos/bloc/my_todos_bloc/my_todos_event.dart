import 'package:equatable/equatable.dart';

abstract class MyTodosEvent extends Equatable {
  const MyTodosEvent();
}

class FetchMyTodos extends MyTodosEvent {
  @override
  List<Object> get props => [];
}

class RefreshMyTodos extends MyTodosEvent {
  @override
  List<Object> get props => [];
}