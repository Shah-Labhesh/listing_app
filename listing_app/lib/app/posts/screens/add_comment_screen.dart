import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:listing_app/app/posts/data/model/comment.dart';
import 'package:listing_app/widgets/custom_button.dart';
import 'package:listing_app/widgets/custom_field.dart';
import 'package:listing_app/widgets/top_bar.dart';

class AddCommentScreen extends StatefulWidget {
  const AddCommentScreen({super.key});

  @override
  State<AddCommentScreen> createState() => _AddCommentScreenState();
}

class _AddCommentScreenState extends State<AddCommentScreen> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController commemtController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: TopBar(title: 'Add Comment'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CustomField(
                  controller: nameController,
                  title: 'Name',
                  hintText: 'Enter name',
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'Name is required';
                    }
                    
                    if (RegExp(r'^[a-zA-Z]+([\s][a-zA-Z]+)*$').hasMatch(p0) == false) {
                      return 'Invalid name';
                    }
                    return null;
                  },
                ),
                CustomField(
                  controller: emailController,
                  title: 'Email',
                  hintText: 'Enter email',
                  validator:(p0){
                    if (p0!.isEmpty) {
                      return 'Email is required';
                    }
                    if (EmailValidator.validate(p0) == false) {
                      return 'Invalid email';
                    }
                    return null;
                  }
                ),
                CustomField(
                  controller: commemtController,
                  title: 'Comment',
                  hintText: 'Write your comment',
                  minLines: 5,
                  maxLines: 10,
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'Comment is required';
                    }
                    // len
                    if (p0.length < 10) {
                      return 'Comment must be at least 10 characters';
                    }
                    return null;
            
                  },
                ),
                CustomButton(
                  title: 'Save',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // save
                      Navigator.pop(
                        context,
                        Comment(
                          name: nameController.text,
                          email: emailController.text,
                          body: commemtController.text,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}