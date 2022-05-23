import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:paterninsurances/api/user/user_model.dart';

class UserApi {
  Future createUser(Map<String, String> data) {
    return http.post(
      Uri.parse('http://10.0.2.2:8000/users/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': data["email"] as String,
        'first_name': data["first_name"] as String,
        'surname': data["surname"] as String,
        'phone_number': data["phone_number"] as String,
        'location': data["location"] as String,
      }),
    );
  }

  Future<UserModel?> getUser(String id) async {
    var response = await http.get(Uri.parse('http://10.0.2.2:8000/users/$id'));
    try {
      final dataCollection = jsonDecode(response.body);
      return UserModel.fromJson(dataCollection);
    } catch (error) {
      print(error);

      return null;
    }
  }
}
