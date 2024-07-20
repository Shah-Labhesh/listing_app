import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listing_app/app/posts/bloc/post_bloc/post_event.dart';
import 'package:listing_app/app/posts/bloc/post_bloc/post_state.dart';
import 'package:listing_app/app/posts/data/model/comment.dart';
import 'package:listing_app/app/posts/data/model/post.dart';
import 'package:listing_app/app/posts/data/repo/post_repo.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<FetchPosts>((event, emit) => _fetchPosts(emit));
    on<RefreshPosts>((event, emit) => _refreshPosts(emit));
    on<FetchPostDetail>((event, emit) => _fetchPostDetail(emit, event));
  }

  final repo = PostRepo();

  void _fetchPosts(Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      final response = await repo.getPosts();
      if (response.statusCode == 200) {
        emit(PostLoaded(posts: (response.data as List<dynamic>).map<Post>((e) => Post.fromMap(e as Map<String, dynamic>)).toList()));
      } else {
        emit(const PostError(
          title: 'Something went wrong',
          message: 'Please check your internet connection and try again',
        ));
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response == null) {
          emit(const PostError(
            title: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
          return;
        }
        final statusCode = e.response!.statusCode;
        if (statusCode == 522) {
          emit(const PostError(
            title: 'Connection timed out',
            message: 'Please check your internet connection and try again',
          ));
        } else if (statusCode! >= 500) {
          emit(const PostError(
            title: 'Server error',
            message: 'Something went wrong. Please try again later',
          ));
        } else if (statusCode >= 401) {
          emit(const PostError(
            title: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
        } else {
          emit(PostError(
            title: 'Validation error',
            message: e.response!.data['message'],
          ));
        }
      } else {
        emit(const PostError(
          title: 'Something went wrong',
          message: 'Please check your internet connection and try again',
        ));
      }
    }
  }

  void _refreshPosts(Emitter<PostState> emit) async {
    emit(RefreshingPost());
    try {
      final response = await repo.getPosts();
      if (response.statusCode == 200) {
        emit(PostLoaded(posts: (response.data as List<dynamic>).map<Post>((e) => Post.fromMap(e as Map<String, dynamic>)).toList()));
      } else {
        emit(const PostError(
          title: 'Something went wrong',
          message: 'Please check your internet connection and try again',
        ));
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response == null) {
          emit(const PostError(
            title: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
          return;
        }
        final statusCode = e.response!.statusCode;
        if (statusCode == 522) {
          emit(const PostError(
            title: 'Connection timed out',
            message: 'Please check your internet connection and try again',
          ));
        } else if (statusCode! >= 500) {
          emit(const PostError(
            title: 'Server error',
            message: 'Something went wrong. Please try again later',
          ));
        } else if (statusCode >= 401) {
          emit(const PostError(
            title: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
        } else {
          emit(PostError(
            title: 'Validation error',
            message: e.response!.data['message'],
          ));
        }
      } else {
        print(e);
        emit(const PostError(
          title: 'Something went wrong',
          message: 'Please check your internet connection and try again',
        ));
      }
    }
  }

  void _fetchPostDetail(Emitter<PostState> emit, FetchPostDetail event) async {
    emit(PostDetailLoading());
    try {
      final response = await repo.getPostComment(event.postId);
      if (response.statusCode == 200) {
        emit(PostDetailLoaded(comment: (response.data as List<dynamic>).map<Comment>((e) => Comment.fromMap(e as Map<String, dynamic>)).toList()));
      } else {
        emit(const PostDetailError(
          title: 'Something went wrong',
          message: 'Please check your internet connection and try again',
        ));
      }
    } catch (e) {
      if (e is DioException) {
        print(e);
        if (e.response == null) {
          emit(const PostDetailError(
            title: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
          return;
        }
        final statusCode = e.response!.statusCode;
        if (statusCode == 522) {
          emit(const PostDetailError(
            title: 'Connection timed out',
            message: 'Please check your internet connection and try again',
          ));
        } else if (statusCode! >= 500) {
          emit(const PostDetailError(
            title: 'Server error',
            message: 'Something went wrong. Please try again later',
          ));
        } else if (statusCode >= 401) {
          emit(const PostDetailError(
            title: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
        } else {
          emit(PostDetailError(
            title: 'Validation error',
            message: e.response!.data['message'],
          ));
        }
      } else {
        print(e);
        emit(const PostDetailError(
          title: 'Something went wrong',
          message: 'Please check your internet connection and try again',
        ));
      }
    }
  }
}