import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listing_app/app/albums/bloc/albums_event.dart';
import 'package:listing_app/app/albums/bloc/albums_state.dart';
import 'package:listing_app/app/albums/data/model/album.dart';
import 'package:listing_app/app/albums/data/model/photos.dart';
import 'package:listing_app/app/albums/data/repo/album_repo.dart';
import 'package:listing_app/utils/local_storage_utils.dart';

class AlbumsBloc extends Bloc<AlbumsEvent, AlbumsState> {
  AlbumsBloc() : super(AlbumsInitial()) {
    on<FetchAlbums>((event, emit) => _fetchAlbums(emit));
    on<RefreshAlbums>((event, emit) => _refreshAlbums(emit));
    on<FetchAlbumPhotos>((event, emit) => _fetchAlbumPhotos(event, emit));
  }

  final repo = AlbumRepo();

  Future<void> _fetchAlbums(Emitter<AlbumsState> emit) async {
    emit(AlbumsLoading());
    try {
      final data = await LocalStorageUtils.getAlbums();
      final userId = await LocalStorageUtils.getUserId();
      var userAlbums = data.where((e) => e.userId == userId).toList();
      if (userAlbums.isEmpty) {
        final response = await repo.fetchAlbums();
        if (response.statusCode == 200) {
          final albums = (response.data as List<dynamic>)
              .map<Album>((e) => Album.fromMap(e))
              .toList();
          userAlbums = albums.where((e) => e.userId == userId).toList();
          LocalStorageUtils.saveAlbums(albums);
          emit(AlbumsLoaded(albums: albums));
        } else {
          emit(const AlbumsError(
            error: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
        }
      } else {
        emit(AlbumsLoaded(albums: userAlbums));
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response == null) {
          emit(const AlbumsError(
            error: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
          return;
        }
        final statusCode = e.response!.statusCode;
        if (statusCode == 522) {
          emit(const AlbumsError(
            error: 'Connection timed out',
            message: 'Please check your internet connection and try again',
          ));
        } else if (statusCode! >= 500) {
          emit(const AlbumsError(
            error: 'Server error',
            message: 'Something went wrong. Please try again later',
          ));
        } else if (statusCode >= 401) {
          emit(const AlbumsError(
            error: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
        } else {
          emit(AlbumsError(
            error: 'Validation error',
            message: e.response!.data['message'],
          ));
        }
      } else {
        emit(const AlbumsError(
          error: 'Something went wrong',
          message: 'Please check your internet connection and try again',
        ));
      }
    }
  }

  void _refreshAlbums(Emitter<AlbumsState> emit) async {
    emit(AlbumsRefreshing());
    try {
      final data = await LocalStorageUtils.getAlbums();
      final userId = await LocalStorageUtils.getUserId();
      var userAlbums = data.where((e) => e.userId == userId).toList();
      if (data.isEmpty) {
        final response = await repo.fetchAlbums();
        if (response.statusCode == 200) {
          final albums = (response.data as List<dynamic>)
              .map<Album>((e) => Album.fromMap(e))
              .toList();
          userAlbums = albums.where((e) => e.userId == userId).toList();
          LocalStorageUtils.saveAlbums(albums);
          emit(AlbumsRefreshed(albums: userAlbums));
        } else {
          emit(const AlbumsRefreshError(
            error: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
        }
      } else {
        emit(AlbumsRefreshed(albums: userAlbums));
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response == null) {
          emit(const AlbumsRefreshError(
            error: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
          return;
        }
        final statusCode = e.response!.statusCode;
        if (statusCode == 522) {
          emit(const AlbumsRefreshError(
            error: 'Connection timed out',
            message: 'Please check your internet connection and try again',
          ));
        } else if (statusCode! >= 500) {
          emit(const AlbumsRefreshError(
            error: 'Server error',
            message: 'Something went wrong. Please try again later',
          ));
        } else if (statusCode >= 401) {
          emit(const AlbumsRefreshError(
            error: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
        } else {
          emit(AlbumsRefreshError(
            error: 'Validation error',
            message: e.response!.data['message'],
          ));
        }
      } else {
        emit(const AlbumsRefreshError(
          error: 'Something went wrong',
          message: 'Please check your internet connection and try again',
        ));
      }
    }
  }

  void _fetchAlbumPhotos(
      FetchAlbumPhotos event, Emitter<AlbumsState> emit) async {
    emit(AlbumPhotosLoading());
    try {
      final data = await LocalStorageUtils.getPhotos();
      final albumPhotos = data.where((e) => e.albumId == event.albumId).toList();
      if (albumPhotos.isEmpty) {
        final response = await repo.fetchAlbumPhotos();
        if (response.statusCode == 200) {
          final photos = (response.data as List<dynamic>)
              .map<Photos>((e) => Photos.fromMap(e))
              .toList();
          final albumPhotos = photos.where((e) => e.albumId == event.albumId).toList();
          LocalStorageUtils.savePhotos(photos);
          emit(AlbumPhotosLoaded(photos: albumPhotos));
        } else {
          emit(const AlbumPhotosError(
            error: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
        }
      } else {
        emit(AlbumPhotosLoaded(photos: albumPhotos));
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response == null) {
          emit(const AlbumPhotosError(
            error: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
          return;
        }
        final statusCode = e.response!.statusCode;
        if (statusCode == 522) {
          emit(const AlbumPhotosError(
            error: 'Connection timed out',
            message: 'Please check your internet connection and try again',
          ));
        } else if (statusCode! >= 500) {
          emit(const AlbumPhotosError(
            error: 'Server error',
            message: 'Something went wrong. Please try again later',
          ));
        } else if (statusCode >= 401) {
          emit(const AlbumPhotosError(
            error: 'Something went wrong',
            message: 'Please check your internet connection and try again',
          ));
        } else {
          emit(AlbumPhotosError(
            error: 'Validation error',
            message: e.response!.data['message'],
          ));
        }
      } else {
        emit(const AlbumPhotosError(
          error: 'Something went wrong',
          message: 'Please check your internet connection and try again',
        ));
      }
    }
  }
}
