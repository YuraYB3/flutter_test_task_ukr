import 'package:flutter/material.dart';
import 'package:flutter_test_task_ukr/Models/user_model.dart';
import 'package:flutter_test_task_ukr/Services/api_services.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 90,
        width: 150,
        child: GestureDetector(
            child: Card(
          color: Colors.white,
          borderOnForeground: true,
          elevation: 10,
          shadowColor: Colors.redAccent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(user.userAvatar),
                ),
                Container(
                  width: 25,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${user.firstName} ${user.lastName}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      user.userEmail,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                )
              ],
            ),
          ),
        )));
  }
}
