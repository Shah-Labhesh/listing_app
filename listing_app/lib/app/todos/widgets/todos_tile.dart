// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:listing_app/constants/app_font_size.dart';

import 'package:listing_app/constants/app_heights.dart';
import 'package:listing_app/constants/app_width.dart';

class TodosTile extends StatefulWidget {
  const TodosTile({
    Key? key,
    required this.title,
    required this.isCompleted,
    required this.onToggle,
  }) : super(key: key);

  final String title;
  final bool isCompleted;
  final Function() onToggle;

  @override
  State<TodosTile> createState() => _TodosTileState();
}

class _TodosTileState extends State<TodosTile> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        vertical: HeightManager.h10,
        horizontal: WidthManager.w20,
      ).copyWith(bottom: 0),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: WidthManager.w20,
        vertical: HeightManager.h10,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.title,
              style: theme.textTheme.bodyMedium!.copyWith(
                fontSize: FontSizeManager.f20,
                decoration: widget.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: widget.onToggle,
            child: Container(
              alignment: Alignment.center,
              width: WidthManager.w20,
              height: HeightManager.h20,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: theme.colorScheme.inversePrimary,
                ),
              ),
              child: Container(
                width: WidthManager.w16,
                height: HeightManager.h16,
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: widget.isCompleted
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          
        ],
      ),
    );
  }
}