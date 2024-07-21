import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listing_app/app/todos/bloc/my_todos_bloc/my_todos_bloc.dart';
import 'package:listing_app/app/todos/bloc/my_todos_bloc/my_todos_event.dart';
import 'package:listing_app/app/todos/bloc/my_todos_bloc/my_todos_state.dart';
import 'package:listing_app/app/todos/data/model/todo.dart';
import 'package:listing_app/app/todos/widgets/todos_tile.dart';
import 'package:listing_app/utils/toast_utils.dart';
import 'package:listing_app/widgets/custom_button.dart';
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
        child: RefreshIndicator(
          backgroundColor: theme.colorScheme.onPrimaryContainer,
          color: theme.colorScheme.onPrimary,
          onRefresh: () async {
            context.read<MyTodosBloc>().add(RefreshMyTodos());
          },
          child: BlocConsumer<MyTodosBloc, MyTodosState>(
            listener: (context, state) {
              if (state is MyTodosRefreshError) {
                ToastUtils.show(context, state.message, isSuccess: false);
              }
              if (state is MyTodosLoaded) {
                todos = state.todos;
                setState(() {});
              }
              if (state is MyTodosRefreshed) {
                todos = state.todos;
                setState(() {});
              }
              if (state is MyTodosDeleteError) {
                ToastUtils.show(context, state.message, isSuccess: false);
              }
              if (state is MyTodosUpdateError) {
                ToastUtils.show(context, state.message, isSuccess: false);
              }
              if (state is MyTodosAddError) {
                ToastUtils.show(context, state.message, isSuccess: false);
              }
              if (state is MyTodosUpdateSuccess) {
                setState(() {
                  todos = state.todos;
                });
                ToastUtils.show(context, 'Todo updated successfully');
              }
              if (state is MyTodosDeleteSuccess) {
                setState(() {
                  todos = state.todos;
                });
                ToastUtils.show(context, 'Todo deleted successfully');
              }
              if (state is MyTodosAddSuccess) {
                context.read<MyTodosBloc>().add(FetchMyTodos());
                ToastUtils.show(context, 'Todo added successfully');
              }
            },
            builder: (context, state) {
              if (state is MyTodosLoaded) {
                todos = state.todos;
              }
              if (state is MyTodosRefreshed) {
                todos = state.todos;
              }
              if (state is MyTodosInitial) {
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
              if (state is MyTodosLoading ||
                  state is MyTodosRefreshing ||
                  state is MyTodosUpdateLoading ||
                  state is MyTodosAddLoading ||
                  state is MyTodosDeleteLoading) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                      title: 'Add a new todo',
                      onPressed: () =>
                          Navigator.pushNamed(context, 'manage_todo').then(
                        (value) {
                          if (value != null) {
                            context.read<MyTodosBloc>().add(
                                  AddTodo(todo: value as Todo),
                                );
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];
                        return TodosTile(
                          title: todo.title ?? '',
                          isCompleted: todo.completed ?? false,
                          onToggle: () {
                            todo.completed =
                                todo.completed == true ? false : true;
                            context.read<MyTodosBloc>().add(
                                  UpdateTodo(
                                    todo: todo,
                                  ),
                                );
                          },
                          onEditTap: () => Navigator.pushNamed(
                            context,
                            'manage_todo',
                            arguments: todo,
                          ).then(
                            (value) {
                              if (value != null) {
                                todo.title = value.toString();
                                context
                                    .read<MyTodosBloc>()
                                    .add(UpdateTodo(todo: todo));
                              }
                            },
                          ),
                          onDeleteTap: () => context.read<MyTodosBloc>().add(
                                DeleteTodo(id: todo.id ?? 1),
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
      ),
    );
  }
}
