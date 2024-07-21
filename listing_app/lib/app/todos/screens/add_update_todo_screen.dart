import 'package:flutter/material.dart';
import 'package:listing_app/app/todos/data/model/todo.dart';
import 'package:listing_app/widgets/custom_button.dart';
import 'package:listing_app/widgets/custom_field.dart';
import 'package:listing_app/widgets/top_bar.dart';

class AddUpdateTodoScreen extends StatefulWidget {
  const AddUpdateTodoScreen({super.key});

  @override
  State<AddUpdateTodoScreen> createState() => _AddUpdateTodoScreenState();
}

class _AddUpdateTodoScreenState extends State<AddUpdateTodoScreen> {
  String title = 'Add Todo';
  final TextEditingController titleController = TextEditingController();
  bool isFirst = true;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Todo?;
    if (args != null && isFirst) {
      title = 'Update Todo';
      isFirst = false;
      titleController.text = args.title ?? '';
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: TopBar(title: title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CustomField(
                controller: titleController,
                title: 'Title',
                hintText: 'Enter title',
              ),
              const SizedBox(height: 20),
              CustomButton(
                title: 'Save',
                onPressed: () {
                  if (titleController.text.isNotEmpty) {
                    if (args != null) {
                      Navigator.pop(context, titleController.text);
                    } else {
                      // pop
                      Navigator.pop(
                        context,
                        Todo(
                          title: titleController.text,
                          completed: false,
                        ),
                      );
                      // Navigator.pushNamed(
                      //   context,
                      //   'user_dashboard',
                      //   arguments: Todo(
                      //     title: titleController.text,
                      //     completed: false,
                      //   ),
                      // );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
