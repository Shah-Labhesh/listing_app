import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listing_app/app/posts/bloc/user_post_bloc/user_post_bloc.dart';
import 'package:listing_app/app/posts/bloc/user_post_bloc/user_post_event.dart';
import 'package:listing_app/app/posts/bloc/user_post_bloc/user_post_state.dart';
import 'package:listing_app/app/posts/data/model/post.dart';
import 'package:listing_app/app/posts/widgets/post_tile.dart';
import 'package:listing_app/utils/toast_utils.dart';
import 'package:listing_app/widgets/top_bar.dart';

class UsersPostScreen extends StatefulWidget {
  const UsersPostScreen({super.key});

  @override
  State<UsersPostScreen> createState() => _UsersPostScreenState();
}

class _UsersPostScreenState extends State<UsersPostScreen> {
  List<Post> posts = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: TopBar(
          isBackButton: false,
          title: 'My Posts',
        ),
      ),
      body: RefreshIndicator(
        backgroundColor: theme.colorScheme.onPrimaryContainer,
        color: theme.colorScheme.onPrimary,
        onRefresh: () async {
          context.read<UserPostBloc>().add(RefreshUserPosts());
        },
        child: SafeArea(
          child: BlocConsumer<UserPostBloc, UserPostState>(
            listener: (context, state) {
              if (state is UserPostRefreshError) {
                // Show error message
                ToastUtils.show(context, state.message, isSuccess: false);
              }
              if (state is UserPostLoaded) {
                posts = state.posts;
                setState(() {});
              }
              if (state is UserPostRefreshed) {
                posts = state.posts;
                setState(() {});
              }
            },
            builder: (context, state) {
              if (state is UserPostInitial) {
                context.read<UserPostBloc>().add(FetchUserPosts());
              }
              if (state is UserPostLoaded) {
                posts = state.posts;
              }
              if (state is UserPostRefreshed) {
                posts = state.posts;
              }
              if (state is UserPostLoading || state is UserPostRefreshing) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }
              if (state is UserPostError) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.read<UserPostBloc>().add(RefreshUserPosts());
                        },
                        child: Icon(
                          // refresh
                          Icons.refresh,
                          color: theme.snackBarTheme.closeIconColor,
                          size: 22,
                        ),
                      ),
                      Text(state.message),
                    ],
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
