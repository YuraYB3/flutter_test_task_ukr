import 'package:flutter/material.dart';
import 'package:flutter_test_task_ukr/Models/user_model.dart';
import 'package:flutter_test_task_ukr/Services/api_services.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key, required this.userID});
  final int userID;

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  late Future<User> userFuture;

  @override
  void initState() {
    super.initState();
    userFuture = _fetchUserData();
  }

  Future<User> _fetchUserData() async {
    try {
      var data = await ApiServices.getUser(widget.userID);
      return data;
    } catch (e) {
      throw Exception('Failed to fetch user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 245, 139, 139),
          title: FutureBuilder<User>(
            future: userFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('');
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text(
                    '${snapshot.data!.firstName} ${snapshot.data!.lastName}');
              }
            },
          ),
        ),
        body: FutureBuilder<User>(
          future: userFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 245, 139, 139),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                  child: Text(
                'ERROR ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ));
            } else {
              return Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 28.0, left: 20),
                        child: SizedBox(
                          height: 200,
                          width: 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              snapshot.data!.userAvatar,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${snapshot.data!.firstName} ${snapshot.data!.lastName} ',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Container(
                            height: 5,
                          ),
                          Text(
                            '${snapshot.data!.userEmail} ',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          Container(
                            height: 5,
                          ),
                          Text(
                            'ID: ${snapshot.data!.userID}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          Container(
                            height: 90,
                          )
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0, left: 20),
                    child: Row(
                      children: const [
                        Text(
                          'ABOUT USER:',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 36,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: const [
                              Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas. Vulputate odio ut enim blandit volutpat maecenas volutpat. Nisl suscipit adipiscing bibendum est ultricies integer quis. Pharetra diam sit amet nisl. Risus feugiat in ante metus dictum at. Ultricies mi quis hendrerit dolor magna. Tellus elementum sagittis vitae et. Praesent semper feugiat nibh sed. Pulvinar sapien et ligula ullamcorper malesuada proin libero. Tincidunt augue interdum velit euismod in pellentesque massa placerat. Aliquam purus sit amet luctus venenatis lectus magna fringilla urna.',
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 14.5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            }
          },
        ));
  }
}
