import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listing_app/app/albums/bloc/albums_bloc.dart';
import 'package:listing_app/app/albums/screens/albums_screen.dart';
import 'package:listing_app/app/posts/bloc/user_post_bloc/user_post_bloc.dart';
import 'package:listing_app/app/posts/screens/users_post_screen.dart';
import 'package:listing_app/app/todos/bloc/my_todos_bloc/my_todos_bloc.dart';
import 'package:listing_app/app/todos/screens/my_todos_screen.dart';
import 'package:listing_app/app/users/widgets/user_navbar.dart';
import 'package:listing_app/utils/local_storage_utils.dart';

class UserDasboard extends StatefulWidget {
  const UserDasboard({super.key});

  @override
  State<UserDasboard> createState() => _UserDasboardState();
}

class _UserDasboardState extends State<UserDasboard> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    BlocProvider(
      create: (context) => UserPostBloc(),
      child: const UsersPostScreen(),
    ),
    BlocProvider(
      create: (context) => MyTodosBloc(),
      child: const MyTodosScreen(),
    ),
    BlocProvider(
      create: (context) => AlbumsBloc(),
      child: const AlbumsScreen(),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        if (_selectedIndex == 0) {
          LocalStorageUtils.saveUserId(1);
          Navigator.of(context).pop();
          return;
        }
        _onItemTapped(0);
      },
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        extendBody: true,
        body: SafeArea(
          bottom: false,
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: UserNavbar(
          index: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
