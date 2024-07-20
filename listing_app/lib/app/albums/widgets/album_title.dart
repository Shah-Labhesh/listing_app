// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:listing_app/app/albums/data/model/album.dart';
import 'package:listing_app/constants/app_colors.dart';
import 'package:listing_app/constants/app_font_size.dart';
import 'package:listing_app/constants/app_heights.dart';
import 'package:listing_app/constants/app_width.dart';

class AlbumTitle extends StatefulWidget {
  const AlbumTitle({
    Key? key,
    this.url,
    required this.album,
    this.showViewMore = true,
    this.onTap,
  }) : super(key: key);

  final String? url;
  final Album album;
  final bool showViewMore;
  final Function()? onTap;
  @override
  State<AlbumTitle> createState() => _AlbumTitleState();
}

class _AlbumTitleState extends State<AlbumTitle> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final h = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: widget.onTap ?? () {
        Navigator.of(context).pushNamed(
          'album_photos',
          arguments: widget.album.id ?? 1,
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
        child: Column(
          children: [
            if (widget.url != null) ...[
              CachedNetworkImage(
                imageUrl: widget.url ?? '',
                fit: BoxFit.cover,
                imageBuilder: (context, imageProvider) => Container(
                  width: double.infinity,
                  height: h * 0.2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => const Center(
                  child: CupertinoActivityIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  color: AppColors.darkError,
                  size: HeightManager.h30,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Title: ',
                              style: theme.textTheme.titleLarge!.copyWith(
                                fontSize: FontSizeManager.f22,
                              ),
                            ),
                            TextSpan(
                              text: widget.album.title ?? '',
                              style: theme.textTheme.headlineSmall!.copyWith(
                                fontSize: FontSizeManager.f18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                if (widget.showViewMore) ...[
                  const SizedBox(width: WidthManager.w8),
                  Text(
                    'view more',
                    style: theme.textTheme.labelMedium,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
