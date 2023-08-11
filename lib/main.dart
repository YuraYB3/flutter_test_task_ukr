import 'package:flutter/material.dart';
import 'package:flutter_test_task_ukr/Models/user_model.dart';
import 'package:flutter_test_task_ukr/Services/api_services.dart';

import 'Views/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}
