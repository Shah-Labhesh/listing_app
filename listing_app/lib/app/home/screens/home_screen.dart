import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listing_app/app/home/widgets/bottom_navbar.dart';
import 'package:listing_app/app/posts/bloc/post_bloc/post_bloc.dart';
import 'package:listing_app/app/posts/screens/post_screen.dart';
import 'package:listing_app/app/users/bloc/user_list_bloc/user_list_bloc.dart';
import 'package:listing_app/app/users/screens/user_list_screen.dart';
import 'package:listing_app/constants/app_font_size.dart';
import 'package:listing_app/constants/app_heights.dart';
import 'package:listing_app/constants/app_width.dart';
import 'package:listing_app/theme_setting/theme_changer.dart';
import 'package:provider/provider.dart';

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
    BlocProvider(
      create: (context) => PostBloc(),
      child: const PostScreen(),
    ),
    BlocProvider(
      create: (context) => UserListBloc(),
      child: const UserListScreen(),
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
    final setting = Provider.of<ThemeChanger>(context, listen: false);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          HeightManager.h65,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: WidthManager.w20,
            vertical: HeightManager.h20,
          ),
          decoration: BoxDecoration(
            color: theme.cardColor,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Listing App',
                  style: theme.textTheme.titleMedium!.copyWith(
                    fontSize: FontSizeManager.f20,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              Text(
                'Dark Mode',
                style: theme.textTheme.bodyMedium!.copyWith(
                  fontSize: FontSizeManager.f12,
                  letterSpacing: 0.5,
                ),
              ),
              CupertinoSwitch(
                trackColor: theme.colorScheme.secondaryContainer,
                value: setting.isDark(),
                onChanged: (value) {
                  setting.toggleTheme();
                },
              )
            ],
          ),
        ),
      ),
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
