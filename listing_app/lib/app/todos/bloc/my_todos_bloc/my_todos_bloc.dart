import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listing_app/app/todos/bloc/my_todos_bloc/my_todos_event.dart';
import 'package:listing_app/app/todos/bloc/my_todos_bloc/my_todos_state.dart';
import 'package:listing_app/app/todos/data/model/todo.dart';
import 'package:listing_app/app/todos/data/repo/todos_repo.dart';
import 'package:listing_app/utils/local_storage_utils.dart';

class MyTodosBloc extends Bloc<MyTodosEvent, MyTodosState> {
  MyTodosBloc() : super(MyTodosInitial()) {
    on<FetchMyTodos>((event, emit) => _fetchMyTodos(emit));
    on<RefreshMyTodos>((event, emit) => _refreshMyTodos(emit));
    on<AddTodo>((event, emit) => _addTodo(event.todo, emit));
    on<UpdateTodo>((event, emit) => _updateTodo(event.todo, emit));
    on<DeleteTodo>((event, emit) => _deleteTodo(event.id, emit));
  }

  final repo = TodosRepo();

  Future<void> _fetchMyTodos(Emitter<MyTodosState> emit) async {
    emit(MyTodosLoading());
    try {
      final data = await LocalStorageUtils.getTodos();
      final userId = await LocalStorageUtils.getUserId();
      final userTodos = data.where((e) => e.userId == userId).toList();
      if (userTodos.isEmpty) {
        final response = await repo.getTodos();
        if (response.statusCode == 200) {
          final todos = (response.data as List<dynamic>)
              .map<Todo>((e) => Todo.fromMap(e))
              .toList();
          LocalStorageUtils.saveTodos(todos);
          final userTodos = todos.where((e) => e.userId == userId).toList();
          emit(MyTodosLoaded(todos: userTodos));
        } else {
          emit(const MyTodosError(
            error: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
        }
      } else {
        emit(MyTodosLoaded(todos: userTodos));
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
      final data = await LocalStorageUtils.getTodos();
      final userId = await LocalStorageUtils.getUserId();
      final userTodos = data.where((e) => e.userId == userId).toList();
      if (userTodos.isEmpty) {
        final response = await repo.getTodos();
        if (response.statusCode == 200) {
          final todos = (response.data as List<dynamic>)
              .map<Todo>((e) => Todo.fromMap(e))
              .toList();
          LocalStorageUtils.saveTodos(todos);
          final userTodos = todos.where((e) => e.userId == userId).toList();
          emit(MyTodosRefreshed(todos: userTodos));
        } else {
          emit(const MyTodosRefreshError(
            error: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
        }
      } else {
        emit(MyTodosRefreshed(todos: userTodos));
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

  void _addTodo(Todo todo, Emitter<MyTodosState> emit) async {
    emit(MyTodosAddLoading());
    try {
      final userId = await LocalStorageUtils.getUserId();
      final data = await LocalStorageUtils.getTodos();
      todo.id = data.isEmpty ? 1 : data.last.id! + 1;
      todo.userId = userId;
      final todos = [...data, todo];
      LocalStorageUtils.saveTodos(todos);
      emit(MyTodosAddSuccess(
          todos: todos.where((element) => element.userId == userId).toList()));
    } catch (e) {
      if (e is DioException) {
        if (e.response == null) {
          emit(const MyTodosAddError(
            error: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
          return;
        }
        final statusCode = e.response!.statusCode;
        if (statusCode == 522) {
          emit(const MyTodosAddError(
            error: 'Connection timed out',
            message: 'Please check your internet connection and try again',
          ));
        } else if (statusCode! >= 500) {
          emit(const MyTodosAddError(
            error: 'Server error',
            message: 'Something went wrong. Please try again later',
          ));
        } else if (statusCode >= 401) {
          emit(const MyTodosAddError(
            error: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
        } else {
          emit(MyTodosAddError(
            error: 'Validation error',
            message: e.response!.data['message'],
          ));
        }
      } else {
        emit(const MyTodosAddError(
          error: 'Something went wrong',
          message: 'Please check your internet connection and try again',
        ));
      }
    }
  }

  void _updateTodo(Todo todo, Emitter<MyTodosState> emit) async {
    emit(MyTodosUpdateLoading());
    try {
      final data = await LocalStorageUtils.getTodos();
      final userId = await LocalStorageUtils.getUserId();
      for (var i = 0; i < data.length; i++) {
        if (data[i].id == todo.id) {
          data[i] = todo;
          break;
        }
      }
      LocalStorageUtils.saveTodos(data);
      emit(MyTodosUpdateSuccess(todos: data.where((e) => userId == e.userId).toList()));
    } catch (e) {
      if (e is DioException) {
        if (e.response == null) {
          emit(const MyTodosUpdateError(
            error: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
          return;
        }
        final statusCode = e.response!.statusCode;
        if (statusCode == 522) {
          emit(const MyTodosUpdateError(
            error: 'Connection timed out',
            message: 'Please check your internet connection and try again',
          ));
        } else if (statusCode! >= 500) {
          emit(const MyTodosUpdateError(
            error: 'Server error',
            message: 'Something went wrong. Please try again later',
          ));
        } else if (statusCode >= 401) {
          emit(const MyTodosUpdateError(
            error: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
        } else {
          emit(MyTodosUpdateError(
            error: 'Validation error',
            message: e.response!.data['message'],
          ));
        }
      } else {
        emit(const MyTodosUpdateError(
          error: 'Something went wrong',
          message: 'Please check your internet connection and try again',
        ));
      }
    }
  }

  void _deleteTodo(int id, Emitter<MyTodosState> emit) async {
    emit(MyTodosDeleteLoading());
    try {
      final data = await LocalStorageUtils.getTodos();
      final userId = await LocalStorageUtils.getUserId();
      data.removeWhere((element) => element.id == id);
      final todos = data;
      LocalStorageUtils.saveTodos(todos);

      emit(MyTodosDeleteSuccess(
          todos: todos.where((element) => element.userId == userId).toList()));
    } catch (e) {
      if (e is DioException) {
        if (e.response == null) {
          emit(const MyTodosDeleteError(
            error: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
          return;
        }
        final statusCode = e.response!.statusCode;
        if (statusCode == 522) {
          emit(const MyTodosDeleteError(
            error: 'Connection timed out',
            message: 'Please check your internet connection and try again',
          ));
        } else if (statusCode! >= 500) {
          emit(const MyTodosDeleteError(
            error: 'Server error',
            message: 'Something went wrong. Please try again later',
          ));
        } else if (statusCode >= 401) {
          emit(const MyTodosDeleteError(
            error: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
        } else {
          emit(MyTodosDeleteError(
            error: 'Validation error',
            message: e.response!.data['message'],
          ));
        }
      } else {
        emit(const MyTodosDeleteError(
          error: 'Something went wrong',
          message: 'Please check your internet connection and try again',
        ));
      }
    }
  }
}
