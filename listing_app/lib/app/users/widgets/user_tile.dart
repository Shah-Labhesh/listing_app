
// ignore_for_file: use_super_parameters

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:listing_app/app/users/data/model/user.dart';
import 'package:listing_app/constants/app_colors.dart';
import 'package:listing_app/constants/app_font_size.dart';
import 'package:listing_app/constants/app_heights.dart';
import 'package:listing_app/constants/app_width.dart';
import 'package:listing_app/utils/local_storage_utils.dart';

class UserTile extends StatefulWidget {
  const UserTile({
    Key? key,
    required this.user,
    required this.isExpanded,
    this.onTileTap,
    this.onExpandTap,
  }) : super(key: key);

  final User user;
  final bool isExpanded;
  final Function()? onTileTap;
  final Function()? onExpandTap;

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: widget.onTileTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: WidthManager.w20,
          vertical: WidthManager.w10,
        ),
        padding: const EdgeInsets.all(WidthManager.w10),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(WidthManager.w10),
        ),
        child: Row(
          crossAxisAlignment: widget.isExpanded
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            Container(
              width: WidthManager.w50,
              height: WidthManager.w50,
              decoration: BoxDecoration(
                color: AppColors
                    .usernameColors[widget.user.username.toString()[0]],
                borderRadius: BorderRadius.circular(WidthManager.w50),
              ),
              child: Center(
                child: Text(
                  widget.user.username.toString()[0],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Hoves-medium',
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: WidthManager.w10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user.name ?? '',
                    style: theme.textTheme.titleLarge,
                  ),
                  Text(
                    widget.user.email ?? '',
                    style: theme.textTheme.labelSmall,
                  ),
                  Text(
                    widget.user.phone ?? '',
                    style: theme.textTheme.titleMedium,
                  ),
                  AnimatedCrossFade(
                    firstChild: const SizedBox.shrink(),
                    secondChild: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: HeightManager.h10,
                        ),
                        Divider(
                          height: 1,
                          color: theme.dividerColor,
                        ),
                        const SizedBox(
                          height: HeightManager.h10,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Address: ',
                                style: theme.textTheme.bodyMedium!
                                    .copyWith(fontSize: FontSizeManager.f20),
                              ),
                              TextSpan(
                                text:
                                    "${widget.user.address!.street}, ${widget.user.address!.suite}, ${widget.user.address!.city}, ${widget.user.address!.zipcode}",
                                style: theme.textTheme.headlineMedium,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: HeightManager.h10,
                        ),
                        Divider(
                          height: 1,
                          color: theme.dividerColor,
                        ),
                        const SizedBox(
                          height: HeightManager.h10,
                        ),
                        Text(
                          'Company: ',
                          style: theme.textTheme.bodyMedium,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Name: ',
                                style: theme.textTheme.bodyMedium!
                                    .copyWith(fontSize: FontSizeManager.f16),
                              ),
                              TextSpan(
                                text: widget.user.company!.name,
                                style: theme.textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Catch Phrase: ',
                                style: theme.textTheme.bodyMedium!
                                    .copyWith(fontSize: FontSizeManager.f16),
                              ),
                              TextSpan(
                                text: widget.user.company!.catchPhrase,
                                style: theme.textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'BS: ',
                                style: theme.textTheme.bodyMedium!
                                    .copyWith(fontSize: FontSizeManager.f16),
                              ),
                              TextSpan(
                                text: widget.user.company!.bs,
                                style: theme.textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: HeightManager.h10,
                        ),
                        // view on map
                        GestureDetector(
                          onTap: () {
                      LocalStorageUtils.saveUserId(widget.user.id!);
                      Navigator.pushNamed(context, 'user_dashboard');
                          },
                          child: Container(
                            padding: const EdgeInsets.all(WidthManager.w10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: theme.scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(WidthManager.w10),
                            ),
                            child: Center(
                              child: Text(
                                'View more',
                                style: theme.textTheme.labelMedium,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    crossFadeState: widget.isExpanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 300),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: WidthManager.w10,
            ),
            GestureDetector(
              onTap: widget.onExpandTap,
              child: Container(
                padding: const EdgeInsets.all(WidthManager.w10),
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    widget.isExpanded
                        ? CupertinoIcons.chevron_up
                        : CupertinoIcons.chevron_down,
                    color: theme.textTheme.titleLarge!.color,
                    size: HeightManager.h24,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
