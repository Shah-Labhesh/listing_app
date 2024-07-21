import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listing_app/app/users/bloc/user_list_bloc/user_list_event.dart';
import 'package:listing_app/app/users/bloc/user_list_bloc/user_list_state.dart';
import 'package:listing_app/app/users/data/model/user.dart';
import 'package:listing_app/app/users/data/repo/user_repo.dart';
import 'package:listing_app/utils/local_storage_utils.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  UserListBloc() : super(UserListInitial()) {
    on<FetchUsers>((event, emit) => _fetchUsers(emit));
    on<RefreshUsers>((event, emit) => _refreshUsers(emit));
  }

  final repo = UserRepo();

  Future<void> _fetchUsers(Emitter<UserListState> emit) async {
    emit(UserListLoading());
    try {
      final data = await LocalStorageUtils.getUsers();
      if (data.isEmpty) {
        final response = await repo.getUsers();
        if (response.statusCode == 200) {
          final users = (response.data as List<dynamic>).map<User>((e) => User.fromMap(e)).toList();
          LocalStorageUtils.saveUsers(users);
          emit(UserListLoaded(users: users));
        } else {
          emit(const UserListError(
            title: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
        }
      } else {
        emit(UserListLoaded(users: data));
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response == null) {
          emit(const UserListError(
            title: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
          return;
        }
        final statusCode = e.response!.statusCode;
        if (statusCode == 522) {
          emit(const UserListError(
            title: 'Connection timed out',
            message: 'Please check your internet connection and try again',
          ));
        } else if (statusCode! >= 500) {
          emit(const UserListError(
            title: 'Server error',
            message: 'Something went wrong. Please try again later',
          ));
        } else if (statusCode >= 401) {
          emit(const UserListError(
            title: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
        } else {
          emit(UserListError(
            title: 'Validation error',
            message: e.response!.data['message'],
          ));
        }
      } else {
        emit(const UserListError(
          title: 'Something went wrong',
          message: 'Please check your internet connection and try again',
        ));
      }
    }
  }

  void _refreshUsers(Emitter<UserListState> emit) async {
    emit(UserRefreshing());
    try {
      final data = await LocalStorageUtils.getUsers();
      if (data.isEmpty) {
        final response = await repo.getUsers();
        if (response.statusCode == 200) {
          final users = (response.data as List<dynamic>).map<User>((e) => User.fromMap(e)).toList();
          LocalStorageUtils.saveUsers(users);
          emit(UserListRefresh(users: users));
        } else {
          emit(const UserListRefreshError(
            title: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
        }
      } else {
        emit(UserListRefresh(users: data));
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response == null) {
          emit(const UserListRefreshError(
            title: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
          return;
        }
        final statusCode = e.response!.statusCode;
        if (statusCode == 522) {
          emit(const UserListRefreshError(
            title: 'Connection timed out',
            message: 'Please check your internet connection and try again',
          ));
        } else if (statusCode! >= 500) {
          emit(const UserListRefreshError(
            title: 'Server error',
            message: 'Something went wrong. Please try again later',
          ));
        } else if (statusCode >= 401) {
          emit(const UserListRefreshError(
            title: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
        } else {
          emit(UserListRefreshError(
            title: 'Validation error',
            message: e.response!.data['message'],
          ));
        }
      } else {
        emit(const UserListRefreshError(
          title: 'Something went wrong',
          message: 'Please check your internet connection and try again',
        ));
      }
    }
  }
}