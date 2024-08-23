// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:dafmon_listview/model/student_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://localhost:3000/api';

  Future<void> sendData(Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/insertUser');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        print('Data sent successfully: ${response.body}');
      } else {
        print('Failed to send data: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<List<StudentModel>> fetchStudentsYear(String year) async {
    final url = Uri.parse('$baseUrl/listUsers?year=$year');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => StudentModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load students: ${response.reasonPhrase}');
    }
  }

  Future<List<StudentModel>> fetchAllStudents() async {
    final url = Uri.parse('$baseUrl/listAllUsers'); // No year parameter
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => StudentModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load all students: ${response.reasonPhrase}');
    }
  }
}
