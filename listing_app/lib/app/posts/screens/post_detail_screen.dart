import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listing_app/app/posts/bloc/post_bloc/post_bloc.dart';
import 'package:listing_app/app/posts/bloc/post_bloc/post_event.dart';
import 'package:listing_app/app/posts/bloc/post_bloc/post_state.dart';
import 'package:listing_app/app/posts/data/model/comment.dart';
import 'package:listing_app/app/posts/data/model/post.dart';
import 'package:listing_app/constants/app_colors.dart';
import 'package:listing_app/constants/app_font_size.dart';
import 'package:listing_app/constants/app_heights.dart';
import 'package:listing_app/constants/app_width.dart';
import 'package:listing_app/utils/toast_utils.dart';
import 'package:listing_app/widgets/top_bar.dart';

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({super.key});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  List<Comment> comments = [];
  Post? post;

  bool isFirst = true;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final args = ModalRoute.of(context)!.settings.arguments as Post?;
    if (args != null && isFirst) {
      post = args;
      isFirst = false;
      context.read<PostBloc>().add(FetchPostDetail(postId: post!.id ?? 1));
    }
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: PreferredSize(preferredSize: const Size.fromHeight(HeightManager.h65), child: TopBar(title: 'Post Detail')),
      body: SafeArea(
        bottom: false,
        child: BlocConsumer<PostBloc, PostState>(
          listener: (context, state) {
            if (state is PostDetailError) {
              ToastUtils.show(context, state.message, isSuccess: false);
            }
            if (state is PostDetailLoaded) {
              setState(() {
                comments = state.comment;
              });
            }
          },
          builder: (context, state) {
            if (state is PostDetailLoaded) {
              comments = state.comment;
            }
            if (state is PostDetailLoading) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
            if (state is PostDetailError) {
              return Center(
                child: Text(state.message.toString()),
              );
            }
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(text: TextSpan(children: [
                        TextSpan(
                          text: 'Title: ',
                          style: theme.textTheme.titleLarge!.copyWith(
                            fontSize: FontSizeManager.f22,
                          ),
                        ),
                        TextSpan(
                          text: post?.title ?? '',
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontSize: FontSizeManager.f18,
                          ),
                        ),
                      ])),
                      const SizedBox(
                        height: 10,
                      ),
                      RichText(text: 
                      TextSpan(children: [
                        TextSpan(
                          text: 'Body: ',
                          style: theme.textTheme.bodyMedium!
                              .copyWith(fontSize: FontSizeManager.f16),
                        ),
                        TextSpan(
                          text: post?.body ?? '',
                          style: theme.textTheme.headlineSmall,
                        ),
                      ])),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final i = comments[index];
                      return Container(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: WidthManager.w50,
                              height: WidthManager.w50,
                              decoration: BoxDecoration(
                                color: AppColors
                                    .usernameColors[i.name.toString().toUpperCase()[0]],
                                borderRadius:
                                    BorderRadius.circular(WidthManager.w50),
                              ),
                              child: Center(
                                child: Text(
                                  i.name.toString().toUpperCase()[0],
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
                                    i.name ?? '',
                                    style: theme.textTheme.titleLarge,
                                  ),
                                  Text(
                                    i.email ?? '',
                                    style: theme.textTheme.labelSmall,
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
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Comment: ',
                                          style: theme.textTheme.bodyMedium!
                                              .copyWith(
                                                  fontSize:
                                                      FontSizeManager.f16),
                                        ),
                                        TextSpan(
                                          text: i.body.toString(),
                                          style: theme.textTheme.headlineSmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
