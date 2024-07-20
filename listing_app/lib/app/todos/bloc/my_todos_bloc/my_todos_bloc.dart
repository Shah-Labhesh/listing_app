import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listing_app/app/todos/bloc/my_todos_bloc/my_todos_event.dart';
import 'package:listing_app/app/todos/bloc/my_todos_bloc/my_todos_state.dart';
import 'package:listing_app/app/todos/data/model/todo.dart';
import 'package:listing_app/app/todos/data/repo/todos_repo.dart';

class MyTodosBloc extends Bloc<MyTodosEvent, MyTodosState> {
  MyTodosBloc() : super(MyTodosInitial()) {
    on<FetchMyTodos>((event, emit) => _fetchMyTodos(emit));
    on<RefreshMyTodos>((event, emit) => _refreshMyTodos(emit));
  }

  final repo = TodosRepo();

  Future<void> _fetchMyTodos(Emitter<MyTodosState> emit) async {
    emit(MyTodosLoading());
    try {
      final response = await repo.getTodos();
      if (response.statusCode == 200) {
        final todos = (response.data as List<dynamic>).map<Todo>((e) => Todo.fromMap(e)).toList();
        emit(MyTodosLoaded(todos: todos));
      } else {
        emit(const MyTodosError(
          error: 'Something went wrong',
          message: 'Please check your internet connection and try again',
        ));
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response == null) {
          emit(const MyTodosError(
            error: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
          return;
        }
        final statusCode = e.response!.statusCode;
        if (statusCode == 522) {
          emit(const MyTodosError(
            error: 'Connection timed out',
            message: 'Please check your internet connection and try again',
          ));
        } else if (statusCode! >= 500) {
          emit(const MyTodosError(
            error: 'Server error',
            message: 'Something went wrong. Please try again later',
          ));
        } else if (statusCode >= 401) {
          emit(const MyTodosError(
            error: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
        } else {
          emit(MyTodosError(
            error: 'Validation error',
            message: e.response!.data['message'],
          ));
        }
      } else {
        emit(const MyTodosError(
          error: 'Something went wrong',
          message: 'Please check your internet connection and try again',
        ));
      }
    }
  }

  void _refreshMyTodos(Emitter<MyTodosState> emit) async {
    emit(MyTodosRefreshing());
    try {
      final response = await repo.getTodos();
      if (response.statusCode == 200) {
        final todos = (response.data as List<dynamic>).map<Todo>((e) => Todo.fromMap(e)).toList();
        emit(MyTodosRefreshed(todos: todos));
      } else {
        emit(const MyTodosRefreshError(
          error: 'Something went wrong',
          message: 'Please check your internet connection and try again',
        ));
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response == null) {
          emit(const MyTodosRefreshError(
            error: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
          return;
        }
        final statusCode = e.response!.statusCode;
        if (statusCode == 522) {
          emit(const MyTodosRefreshError(
            error: 'Connection timed out',
            message: 'Please check your internet connection and try again',
          ));
        } else if (statusCode! >= 500) {
          emit(const MyTodosRefreshError(
            error: 'Server error',
            message: 'Something went wrong. Please try again later',
          ));
        } else if (statusCode >= 401) {
          emit(const MyTodosRefreshError(
            error: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
        } else {
          emit(MyTodosRefreshError(
            error: 'Validation error',
            message: e.response!.data['message'],
          ));
        }
      } else {
        emit(const MyTodosRefreshError(
          error: 'Something went wrong',
          message: 'Please check your internet connection and try again',
        ));
      }
    }
  }

}