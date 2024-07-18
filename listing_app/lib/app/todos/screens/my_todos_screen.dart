import 'package:flutter/material.dart';

class MyTodosScreen extends StatefulWidget {
  const MyTodosScreen({super.key});

  @override
  State<MyTodosScreen> createState() => _MyTodosScreenState();
}

class _MyTodosScreenState extends State<MyTodosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('My Todos Screen'),
      ),
    );
  }
}