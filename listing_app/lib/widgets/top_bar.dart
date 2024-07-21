// ignore_for_file: public_member_api_docs, sort_constructors_first, use_super_parameters
import 'package:flutter/material.dart';

import 'package:listing_app/constants/app_font_size.dart';
import 'package:listing_app/constants/app_heights.dart';
import 'package:listing_app/constants/app_width.dart';

class TopBar extends StatefulWidget {
  const TopBar({
    Key? key,
    required this.title,
    this.isBackButton = true,
    this.onBackButtonTap,
  }) : super(key: key);

  final String title;
  final bool isBackButton;
  final Function()? onBackButtonTap;
  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: WidthManager.w20,
        vertical: HeightManager.h16,
      ).copyWith(
        top: 24,
      ),
      decoration: BoxDecoration(
        color: theme.cardColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (widget.isBackButton)
            GestureDetector(
              onTap: widget.onBackButtonTap ?? () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                size: HeightManager.h24,
                color: theme.textTheme.titleLarge!.color,
              ),
            )
          else
            const SizedBox(width: 24),
          const SizedBox(width: 10),
          Expanded(
            child: Center(
              child: Text(
                widget.title,
                style: theme.textTheme.titleLarge!.copyWith(
                  fontSize: FontSizeManager.f20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 24),
        ],
      ),
    );
  }
}
