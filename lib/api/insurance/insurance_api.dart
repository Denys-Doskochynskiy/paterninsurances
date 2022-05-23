import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:paterninsurances/api/insurance/insurance_model.dart';

class InsuranceApi {
  Future createInsurance(Map<String, dynamic> data) {
    return http.post(
      Uri.parse('http://10.0.2.2:8000/insurances/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "country": data['country'] as String,
        "condition": data['condition'] as String,
        "price": data['price'] as String,
        "is_available": data['is_available'] as bool,
        "title": data['title'] as String,
        "reserved_by_user": data['reserved_by_user'] as String,
      }),
    );
  }

  Future<List<InsuranceModel>?> getInsurances() async {
    var response =
        await http.get(Uri.parse('http://10.0.2.2:8000/insurances/'));

    try {
      final dataCollection = jsonDecode(response.body);

      return (dataCollection as List)
          .map((json) => InsuranceModel.fromJson(json))
          .toList();
    } catch (error) {
      print(error);

      return null;
    }
  }

  Future updateInsurance(Map<String, dynamic> data, String insuranceId) {
    return http.put(
      Uri.parse('http://10.0.2.2:8000/insurances/$insuranceId/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "country": data['country'] as String,
        "condition": data['condition'] as String,
        "price": data['price'] as String,
        "title": data['title'] as String,
      }),
    );
  }

  Future deleteInsurance(String insuranceId) {
    return http
        .delete(Uri.parse('http://10.0.2.2:8000/insurances/$insuranceId/'));
  }
}
