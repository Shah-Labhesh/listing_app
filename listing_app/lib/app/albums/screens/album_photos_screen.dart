import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listing_app/app/albums/bloc/albums_bloc.dart';
import 'package:listing_app/app/albums/bloc/albums_event.dart';
import 'package:listing_app/app/albums/bloc/albums_state.dart';
import 'package:listing_app/app/albums/data/model/album.dart';
import 'package:listing_app/app/albums/data/model/photos.dart';
import 'package:listing_app/app/albums/widgets/album_title.dart';
import 'package:listing_app/constants/app_heights.dart';
import 'package:listing_app/widgets/top_bar.dart';

class AlbumPhotosScreen extends StatefulWidget {
  const AlbumPhotosScreen({super.key});

  @override
  State<AlbumPhotosScreen> createState() => _AlbumPhotosScreenState();
}

class _AlbumPhotosScreenState extends State<AlbumPhotosScreen> {
  List<Photos> photos = [];

  bool isFirst = true;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final args = ModalRoute.of(context)!.settings.arguments as int?;
    if (args != null && isFirst) {
      isFirst = false;
      context.read<AlbumsBloc>().add(FetchAlbumPhotos(albumId: args));
    }
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(HeightManager.h65),
        child: TopBar(
          isBackButton: true,
          title: 'Album Photos',
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<AlbumsBloc, AlbumsState>(
          listener: (context, state) {
            if (state is AlbumPhotosLoaded) {
              photos = state.photos;
              setState(() {});
            }
          },
          builder: (context, state) {
            if (state is AlbumPhotosLoading) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
            if (state is AlbumPhotosLoaded) {
              photos = state.photos;
            }
            if (state is AlbumPhotosError) {
              return Center(
                child: Text(state.message),
              );
            }
            return ListView.builder(
              itemCount: photos.length,
              itemBuilder: (context, index) {
                final photo = photos[index];
                return AlbumTitle(
                  album: Album(
                    id: photo.id,
                    title: photo.title,
                  ),
                  url: photo.thumbnailUrl,
                  showViewMore: false,
                  onTap: () async {
                    await EasyLauncher.url(url: photo.url ?? '');
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
