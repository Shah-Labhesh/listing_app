// ignore_for_file: public_member_api_docs, sort_constructors_first, use_super_parameters
import 'package:flutter/material.dart';

import 'package:listing_app/app/posts/data/model/post.dart';
import 'package:listing_app/constants/app_font_size.dart';
import 'package:listing_app/constants/app_width.dart';

class PostTile extends StatefulWidget {
  const PostTile({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          'post_detail',
          arguments: widget.post,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: 'Title: ',
                      style: theme.textTheme.titleLarge!.copyWith(
                        fontSize: FontSizeManager.f22,
                      ),
                    ),
                    TextSpan(
                      text: widget.post.title ?? '',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontSize: FontSizeManager.f18,
                      ),
                    ),
                  ])),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: 'Body: ',
                      style: theme.textTheme.bodyMedium!
                          .copyWith(fontSize: FontSizeManager.f16),
                    ),
                    TextSpan(
                      text: widget.post.body ?? '',
                      style: theme.textTheme.headlineSmall,
                    ),
                  ])),
                ],
              ),
            ),
            const SizedBox(width: WidthManager.w8),
            Text(
              'view more',
              style: theme.textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}
