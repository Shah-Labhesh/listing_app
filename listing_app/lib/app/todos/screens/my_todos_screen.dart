import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listing_app/app/todos/bloc/my_todos_bloc/my_todos_bloc.dart';
import 'package:listing_app/app/todos/bloc/my_todos_bloc/my_todos_event.dart';
import 'package:listing_app/app/todos/bloc/my_todos_bloc/my_todos_state.dart';
import 'package:listing_app/app/todos/data/model/todo.dart';
import 'package:listing_app/app/todos/widgets/todos_tile.dart';
import 'package:listing_app/utils/toast_utils.dart';
import 'package:listing_app/widgets/top_bar.dart';

class MyTodosScreen extends StatefulWidget {
  const MyTodosScreen({super.key});

  @override
  State<MyTodosScreen> createState() => _MyTodosScreenState();
}

class _MyTodosScreenState extends State<MyTodosScreen> {
  List<Todo> todos = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: TopBar(
          isBackButton: false,
          title: 'My Todos',
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<MyTodosBloc, MyTodosState>(
          listener: (context, state) {
            if (state is MyTodosError) {
              ToastUtils.show(context, state.message, isSuccess: false);
            }
          },
          builder: (context, state) {
            if (state is MyTodosLoaded) {
              todos = state.todos;
            }
            if (state is MyTodosInitial){
              context.read<MyTodosBloc>().add(FetchMyTodos());
            }
            if (state is MyTodosError) {
              return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.read<MyTodosBloc>().add(RefreshMyTodos());
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
            if (state is MyTodosLoading) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return TodosTile(
                  title: todo.title ?? '',
                  isCompleted: todo.completed ?? false,
                  onToggle: () {
                    setState(() {
                      todos[index].completed = !todos[index].completed!;
                    });
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
