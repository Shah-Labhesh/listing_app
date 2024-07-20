import 'package:equatable/equatable.dart';

abstract class AlbumsEvent extends Equatable {
  const AlbumsEvent();
}

class FetchAlbums extends AlbumsEvent {
  @override
  List<Object> get props => [];
}

class RefreshAlbums extends AlbumsEvent {
  @override
  List<Object> get props => [];
}

class FetchAlbumPhotos extends AlbumsEvent {
  final int albumId;

  const FetchAlbumPhotos({required this.albumId});

  @override
  List<Object> get props => [albumId];
}

