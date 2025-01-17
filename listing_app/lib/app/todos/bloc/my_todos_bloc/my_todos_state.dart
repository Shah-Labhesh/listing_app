// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:listing_app/app/todos/data/model/todo.dart';

abstract class MyTodosState extends Equatable {
  const MyTodosState();
}

class MyTodosInitial extends MyTodosState {
  @override
  List<Object> get props => [];
}

class MyTodosLoading extends MyTodosState {
  @override
  List<Object> get props => [];
}

class MyTodosLoaded extends MyTodosState {
  final List<Todo> todos;

  const MyTodosLoaded({required this.todos});

  @override
  List<Object> get props => [todos];
}

class MyTodosError extends MyTodosState {
  final String error;
  final dynamic message;

  const MyTodosError({
    required this.error,
    required this.message,
  });

  @override
  List<Object> get props => [error,message];
}

class MyTodosRefreshing extends MyTodosState {
  @override
  List<Object> get props => [];
}

class MyTodosRefreshed extends MyTodosState {
  final List<Todo> todos;

  const MyTodosRefreshed({required this.todos});

  @override
  List<Object> get props => [todos];
}

class MyTodosRefreshError extends MyTodosState {
  final String error;
  final dynamic message;

  const MyTodosRefreshError({
    required this.error,
    required this.message,
  });

  @override
  List<Object> get props => [error,message];
}

class MyTodosAddSuccess extends MyTodosState {
  final List<Todo> todos;

  const MyTodosAddSuccess({required this.todos});

  @override
  List<Object> get props => [todos];
}


class MyTodosUpdateSuccess extends MyTodosState {
  final List<Todo> todos;

  const MyTodosUpdateSuccess({required this.todos});

  @override
  List<Object> get props => [todos];
}

class MyTodosDeleteSuccess extends MyTodosState {
  final List<Todo> todos;

  const MyTodosDeleteSuccess({required this.todos});

  @override
  List<Object> get props => [todos];
}

class MyTodosAddError extends MyTodosState {
  final String error;
  final dynamic message;

  const MyTodosAddError({
    required this.error,
    required this.message,
  });

  @override
  List<Object> get props => [error,message];
}

class MyTodosUpdateError extends MyTodosState {
  final String error;
  final dynamic message;

  const MyTodosUpdateError({
    required this.error,
    required this.message,
  });

  @override
  List<Object> get props => [error,message];
}

class MyTodosDeleteError extends MyTodosState {
  final String error;
  final dynamic message;

  const MyTodosDeleteError({
    required this.error,
    required this.message,
  });

  @override
  List<Object> get props => [error,message];
}

class MyTodosAddLoading extends MyTodosState {
  @override
  List<Object> get props => [];
}

class MyTodosUpdateLoading extends MyTodosState {
  @override
  List<Object> get props => [];
}

class MyTodosDeleteLoading extends MyTodosState {
  @override
  List<Object> get props => [];
}
