import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listing_app/app/users/bloc/user_list_bloc/user_list_bloc.dart';
import 'package:listing_app/app/users/bloc/user_list_bloc/user_list_event.dart';
import 'package:listing_app/app/users/bloc/user_list_bloc/user_list_state.dart';
import 'package:listing_app/app/users/data/model/user.dart';
import 'package:listing_app/app/users/widgets/user_tile.dart';
import 'package:listing_app/utils/local_storage_utils.dart';
import 'package:listing_app/utils/toast_utils.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<User> users = [];
  int expandedUserId = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: theme.colorScheme.onPrimaryContainer,
          color: theme.colorScheme.onPrimary,
          onRefresh: () async {
            context.read<UserListBloc>().add(RefreshUsers());
          },
          child: BlocConsumer<UserListBloc, UserListState>(
            listener: (context, state) {
              if (state is UserListRefreshError) {
                ToastUtils.show(context, state.message, isSuccess: false);
              } else if (state is UserListRefresh) {
                setState(() {
                  users = state.users;
                });
              } else if (state is UserListLoaded) {
                setState(() {
                  users = state.users;
                });
              }
            },
            builder: (context, state) {
              if (state is UserListInitial) {
                context.read<UserListBloc>().add(FetchUsers());
              } else if (state is UserListLoading || state is UserRefreshing) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              } else if (state is UserListError) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.read<UserListBloc>().add(FetchUsers());
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
              if (state is UserListRefresh) {
                users = state.users;
              }
              if (state is UserListLoaded) {
                users = state.users;
              }
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return UserTile(
                    user: user,
                    isExpanded: user.id == expandedUserId,
                    onTileTap: () {
                      LocalStorageUtils.saveUserId(user.id!);
                      Navigator.pushNamed(context, 'user_dashboard');
                    },
                    onExpandTap: () {
                      if (expandedUserId == user.id) {
                        setState(() {
                          expandedUserId = 0;
                        });
                        return;
                      }
                      setState(() {
                        expandedUserId = user.id!;
                      });
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
