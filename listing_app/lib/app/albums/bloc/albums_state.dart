import 'package:equatable/equatable.dart';
import 'package:listing_app/app/albums/data/model/album.dart';
import 'package:listing_app/app/albums/data/model/photos.dart';

abstract class AlbumsState extends Equatable {
  const AlbumsState();
}

class AlbumsInitial extends AlbumsState {
  @override
  List<Object> get props => [];
}

class AlbumsLoading extends AlbumsState {
  @override
  List<Object> get props => [];
}

class AlbumsLoaded extends AlbumsState {
  final List<Album> albums;

  const AlbumsLoaded({required this.albums});

  @override
  List<Object> get props => [albums];
}

class AlbumsError extends AlbumsState {
  final String error;
  final dynamic message;

  const AlbumsError({
    required this.error,
    required this.message,
  });

  @override
  List<Object> get props => [error, message];
}

class AlbumsRefreshing extends AlbumsState {
  @override
  List<Object> get props => [];
}

class AlbumsRefreshed extends AlbumsState {
  final List<Album> albums;

  const AlbumsRefreshed({required this.albums});

  @override
  List<Object> get props => [albums];
}

class AlbumsRefreshError extends AlbumsState {
  final String error;
  final dynamic message;

  const AlbumsRefreshError({
    required this.error,
    required this.message,
  });

  @override
  List<Object> get props => [error, message];
}

class AlbumPhotosLoading extends AlbumsState {
  @override
  List<Object> get props => [];
}

class AlbumPhotosLoaded extends AlbumsState {
  final List<Photos> photos;

  const AlbumPhotosLoaded({required this.photos});

  @override
  List<Object> get props => [photos];
}

class AlbumPhotosError extends AlbumsState {
  final String error;
  final dynamic message;

  const AlbumPhotosError({
    required this.error,
    required this.message,
  });

  @override
  List<Object> get props => [error, message];
} 