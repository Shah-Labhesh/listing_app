import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:listing_app/app/posts/bloc/post_bloc/post_bloc.dart';
import 'package:listing_app/app/posts/bloc/post_bloc/post_event.dart';
import 'package:listing_app/app/posts/bloc/post_bloc/post_state.dart';
import 'package:listing_app/app/posts/data/model/post.dart';
import 'package:listing_app/app/posts/widgets/post_tile.dart';
import 'package:listing_app/utils/toast_utils.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

List<Post> posts = [];

class _PostScreenState extends State<PostScreen> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool isRefreshing = false;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: RefreshIndicator(
        backgroundColor: theme.colorScheme.onPrimaryContainer,
        color: theme.colorScheme.onPrimary,
        onRefresh: () async {
          context.read<PostBloc>().add(RefreshPosts());
          while (isRefreshing) {
            await Future.delayed(const Duration(milliseconds: 100));
          }
        },
        child: SafeArea(
          child: BlocConsumer<PostBloc, PostState>(
            listener: (context, state) {
              if (state is RefreshingPost) {
                setState(() {
                  isRefreshing = true;
                });
              } else if (state is PostRefreshError) {
                setState(() {
                  isRefreshing = false;
                });
                ToastUtils.show(context, state.message, isSuccess: false);
              } else if (state is PostLoaded) {
                setState(() {
                  posts = state.posts;
                });
              } else if (state is PostRefreshed) {
                setState(() {
                  posts = state.posts;
                  isRefreshing = false;
                });
              }
            },
            builder: (context, state) {
              if (state is PostLoaded) {
                posts = state.posts;
              } else if (state is PostRefreshed) {
                posts = state.posts;
              } else if (state is PostInitial) {
                context.read<PostBloc>().add(FetchPosts());
              } else if (state is PostLoading || state is RefreshingPost) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              } else if (state is PostError) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.read<PostBloc>().add(RefreshPosts());
                        },
                        child: Icon(
                          // refresh
                          Icons.refresh,
                          color: theme.snackBarTheme.closeIconColor,
                          size: 22,
                        ),
                      ),
                      Text(
                        state.message,
                        style: theme.textTheme.titleSmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }
              if (posts.isEmpty) {
                return Center(
                  child: Text(
                    'No posts found',
                    style: theme.textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                );
              }

              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return PostTile(post: post);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
