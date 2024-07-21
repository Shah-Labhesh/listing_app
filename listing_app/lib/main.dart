// ignore_for_file: public_member_api_docs, sort_constructors_first, use_super_parameters
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listing_app/app/albums/bloc/albums_bloc.dart';
import 'package:listing_app/app/albums/screens/album_photos_screen.dart';
import 'package:listing_app/app/posts/bloc/post_bloc/post_bloc.dart';
import 'package:listing_app/app/posts/screens/add_comment_screen.dart';
import 'package:listing_app/app/posts/screens/post_detail_screen.dart';
import 'package:listing_app/app/todos/bloc/my_todos_bloc/my_todos_bloc.dart';
import 'package:listing_app/app/todos/screens/add_update_todo_screen.dart';
import 'package:listing_app/app/users/screens/user_dasboard.dart';
import 'package:provider/provider.dart';

import 'package:listing_app/app/home/screens/home_screen.dart';
import 'package:listing_app/theme_setting/app_theme.dart';
import 'package:listing_app/theme_setting/theme_changer.dart';
import 'package:listing_app/utils/local_storage_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isDark = await LocalStorageUtils.getThemeMode();
  runApp(MyApp(
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  const MyApp({
    Key? key,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeChanger(isDark),
      builder: (context, snapshot) {
        final setting = Provider.of<ThemeChanger>(context);
        return MaterialApp(
          title: 'Flutter Demo',
          theme: lightTheme,
          debugShowCheckedModeBanner: false,
          darkTheme: darkTheme,
          themeMode: setting.themeMode,
          initialRoute: '/',
          routes: {
            '/': (context) => const HomeScreen(),
            'user_dashboard': (context) => const UserDasboard(),
            'post_detail': (context) => BlocProvider(
                  create: (context) => PostBloc(),
                  child: const PostDetailScreen(),
                ),
            'album_photos': (context) => BlocProvider(
                  create: (context) => AlbumsBloc(),
                  child: const AlbumPhotosScreen(),
                ),
            'manage_todo': (context) => BlocProvider(
                  create: (context) => MyTodosBloc(),
                  child: const AddUpdateTodoScreen(),
                ),
            'post_comment': (context) => BlocProvider(
                  create: (context) => PostBloc(),
                  child: const AddCommentScreen(),
                ),
          },
        );
      },
    );
  }
}
