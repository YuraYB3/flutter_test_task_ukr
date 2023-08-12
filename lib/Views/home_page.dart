import 'package:flutter/material.dart';
import 'package:flutter_test_task_ukr/Models/user_model.dart';
import 'package:flutter_test_task_ukr/Services/api_services.dart';

import '../Widgets/user_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Future<List<User>> _usersFuture = ApiServices.getUsers();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 139, 139),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 40.0, left: 15, right: 15, bottom: 40),
        child: FutureBuilder<List<User>>(
          future: _usersFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'ERROR \n SOMETHING WENT WRONG',
                  style: TextStyle(color: Colors.red, fontSize: 24),
                ),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            final users = snapshot.data!;
            saveUsers(users);
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return UserCard(user: user);
              },
            );
          },
        ),
      ),
    );
  }

  void saveUsers(List<User> users) async {
    try {
      await ApiServices.saveUsers(users);
      print('good');
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
