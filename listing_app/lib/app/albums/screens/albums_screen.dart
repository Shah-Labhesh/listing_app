import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listing_app/app/albums/bloc/albums_bloc.dart';
import 'package:listing_app/app/albums/bloc/albums_event.dart';
import 'package:listing_app/app/albums/bloc/albums_state.dart';
import 'package:listing_app/app/albums/data/model/album.dart';
import 'package:listing_app/app/albums/widgets/album_title.dart';
import 'package:listing_app/utils/toast_utils.dart';
import 'package:listing_app/widgets/top_bar.dart';

class AlbumsScreen extends StatefulWidget {
  const AlbumsScreen({super.key});

  @override
  State<AlbumsScreen> createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  List<Album> albums = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: TopBar(
          isBackButton: true,
          title: 'My Albums',
        ),
      ),
      body: RefreshIndicator(
        backgroundColor: theme.colorScheme.onPrimaryContainer,
        color: theme.colorScheme.onPrimary,
        onRefresh: () async {
          context.read<AlbumsBloc>().add(RefreshAlbums());
        },
        child: SafeArea(
          child: BlocConsumer<AlbumsBloc, AlbumsState>(
            listener: (context, state) {
              if (state is AlbumsRefreshError) {
                ToastUtils.show(context, state.message, isSuccess: false);
              }
              if (state is AlbumsLoaded) {
                setState(() {
                  albums = state.albums;
                });
              }
              if (state is AlbumsRefreshed) {
                setState(() {
                  albums = state.albums;
                });
              }
            },
            builder: (context, state) {
              if (state is AlbumsInitial) {
                context.read<AlbumsBloc>().add(FetchAlbums());
              }
              if (state is AlbumsLoaded) {
                albums = state.albums;
              }
              if (state is AlbumsRefreshed) {
                albums = state.albums;
              }
              if (state is AlbumsLoading || state is AlbumsRefreshing) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }
              if (state is AlbumsError) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.read<AlbumsBloc>().add(RefreshAlbums());
                        },
                        child: Icon(
                          // refresh
                          Icons.refresh,
                          size: 22,
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        state.message,
                        style: theme.textTheme.titleSmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }
              if (albums.isEmpty) {
                return Center(
                  child: Text(
                    'No Albums Found',
                    style: theme.textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return ListView.builder(
                itemCount: albums.length,
                itemBuilder: (context, index) {
                  final album = albums[index];
                  return AlbumTitle(album: album);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
