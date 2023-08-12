import 'package:connectivity/connectivity.dart';
import 'package:flutter_test_task_ukr/Models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  static const String _keyUserList = 'userList';

  static Future<List<User>> getUsers() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      return _getUsersFromStorage();
    } else {
      return _getUsersFromInternet();
    }
  }

  static Future<List<User>> _getUsersFromInternet() async {
    Uri apiUrl = Uri.parse('https://reqres.in/api/users?page=2');
    http.Response response = await http.get(apiUrl);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      List<dynamic> userData = responseData['data'];
      List<User> users = userData.map((taskData) {
        return User.fromJson(taskData);
      }).toList();
      return users;
    } else {
      throw Exception(
          'Failed to fetch users. Status code: ${response.statusCode}');
    }
  }

  static Future<List<User>> _getUsersFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userListJson = prefs.getString(_keyUserList);
    if (userListJson != null) {
      final userList = (json.decode(userListJson) as List<dynamic>)
          .map((userJson) => User.fromJson(userJson))
          .toList();
      return userList;
    }
    return [];
  }

  static Future<User> getUser(int userID) async {
    late User user;
    final response =
        await http.get(Uri.parse('https://reqres.in/api/users/$userID'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      user = User.fromJson(data['data']);
      return user;
    } else {
      throw Exception('Failed to load user data');
    }
  }

  static Future<void> saveUsers(List<User> users) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userListJson =
        json.encode(users.map((user) => user.toJson()).toList());
    await prefs.setString(_keyUserList, userListJson);
  }
}
