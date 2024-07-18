import 'package:flutter/material.dart';
import 'package:listing_app/app/albums/screens/albums_screen.dart';
import 'package:listing_app/app/home/widgets/bottom_navbar.dart';
import 'package:listing_app/app/posts/screens/post_screen.dart';
import 'package:listing_app/app/todos/screens/my_todos_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0;
  Future<bool>? loggedInStatus;

  @override
  void initState() {
    super.initState();
  }

  static final List<Widget> _widgetOptions = <Widget>[
    PostScreen(),
    MyTodosScreen(),
    AlbumsScreen(),
    // 
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavCustom(
          index: _selectedIndex,
          onTap: _onItemTapped,
        ),
    );
  }
}