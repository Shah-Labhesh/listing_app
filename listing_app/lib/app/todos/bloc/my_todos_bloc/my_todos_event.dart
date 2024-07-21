import 'package:equatable/equatable.dart';
import 'package:listing_app/app/todos/data/model/todo.dart';

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

// add todo
class AddTodo extends MyTodosEvent {
  final Todo todo;

  const AddTodo({required this.todo});

  @override
  List<Object> get props => [todo];
}

// update todo
class UpdateTodo extends MyTodosEvent {
  final Todo todo;

  const UpdateTodo({required this.todo});

  @override
  List<Object> get props => [todo];
}

// delete todo
class DeleteTodo extends MyTodosEvent {
  final int id;

  const DeleteTodo({required this.id});

  @override
  List<Object> get props => [id];
}
