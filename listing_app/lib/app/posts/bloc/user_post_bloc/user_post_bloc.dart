import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listing_app/app/posts/bloc/user_post_bloc/user_post_event.dart';
import 'package:listing_app/app/posts/bloc/user_post_bloc/user_post_state.dart';
import 'package:listing_app/app/posts/data/model/post.dart';
import 'package:listing_app/app/posts/data/repo/post_repo.dart';

class UserPostBloc extends Bloc<UserPostEvent, UserPostState> {
  UserPostBloc() : super(UserPostInitial()) {
    on<FetchUserPosts>((event, emit) => _fetchUserPosts(emit));
    on<RefreshUserPosts>((event, emit) => _refreshUserPosts(emit));
  }

  final repo = PostRepo();

  Future<void> _fetchUserPosts(Emitter<UserPostState> emit) async {
    emit(UserPostLoading());
    try {
      final response = await repo.getUserPosts();
      if (response.statusCode == 200) {
        final posts = (response.data as List<dynamic>).map<Post>((e) => Post.fromMap(e)).toList();
        emit(UserPostLoaded(posts: posts));
      } else {
        emit(const UserPostError(
          error: 'Something went wrong',
          message: 'Please check your internet connection and try again',
        ));
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response == null) {
          emit(const UserPostError(
            error: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
          return;
        }
        final statusCode = e.response!.statusCode;
        if (statusCode == 522) {
          emit(const UserPostError(
            error: 'Connection timed out',
            message: 'Please check your internet connection and try again',
          ));
        } else if (statusCode! >= 500) {
          emit(const UserPostError(
            error: 'Server error',
            message: 'Something went wrong. Please try again later',
          ));
        } else if (statusCode >= 401) {
          emit(const UserPostError(
            error: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
        } else {
          emit(UserPostError(
            error: 'Validation error',
            message: e.response!.data['message'],
          ));
        }
      } else {
        emit(const UserPostError(
          error: 'Something went wrong',
          message: 'Please check your internet connection and try again',
        ));
      }
    }
  }

  void _refreshUserPosts(Emitter<UserPostState> emit) async {
    emit(UserPostRefreshing());
    try {
      final response = await repo.getUserPosts();
      if (response.statusCode == 200) {
        final posts = (response.data as List<dynamic>).map<Post>((e) => Post.fromMap(e)).toList();
        emit(UserPostRefreshed(posts: posts));
      } else {
        emit(const UserPostRefreshError(
          error: 'Something went wrong',
          message: 'Please check your internet connection and try again',
        ));
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response == null) {
          emit(const UserPostRefreshError(
            error: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
          return;
        }
        final statusCode = e.response!.statusCode;
        if (statusCode == 522) {
          emit(const UserPostRefreshError(
            error: 'Connection timed out',
            message: 'Please check your internet connection and try again',
          ));
        } else if (statusCode! >= 500) {
          emit(const UserPostRefreshError(
            error: 'Server error',
            message: 'Something went wrong. Please try again later',
          ));
        } else if (statusCode >= 401) {
          emit(const UserPostRefreshError(
            error: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
        } else {
          emit(UserPostRefreshError(
            error: 'Validation error',
            message: e.response!.data['message'],
          ));
        }
      } else {
        emit(const UserPostRefreshError(
          error: 'Something went wrong',
          message: 'Please check your internet connection and try again',
        ));
      }
    }
  }
}