import 'package:flutter/material.dart';
import 'package:listing_app/constants/app_heights.dart';
import 'package:listing_app/constants/app_icons.dart';

class UserNavbar extends StatefulWidget {
  const UserNavbar({
    required this.index,
    required this.onTap,
    super.key,
  });

  final int index;
  final Function(int)? onTap;

  @override
  State<UserNavbar> createState() => _UserNavbarState();
}

class _UserNavbarState extends State<UserNavbar> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      clipBehavior: Clip.hardEdge,
      height: HeightManager.h73,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          topLeft: Radius.circular(24),
        ),
      ),
      child: BottomNavigationBar(
        elevation: 0,
        backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: theme.bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor: theme.bottomNavigationBarTheme.unselectedItemColor,
        currentIndex: widget.index,
        selectedLabelStyle: theme.bottomNavigationBarTheme.selectedLabelStyle,
        unselectedLabelStyle: theme.bottomNavigationBarTheme.unselectedLabelStyle,
        onTap: widget.onTap,
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(AppIcons.postIcon),
            ),
            label: 'Posts',
          ),
          
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(AppIcons.todosIcon),
            ),
            label: 'My Todos',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(AppIcons.albumIcon),
            ),
            label: 'Albums',
          ),
        ],
      ),
    );
  }
}