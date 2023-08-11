import 'package:flutter_test_task_ukr/Models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiServices {
  static Future<List<User>> getUsers() async {
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
}
