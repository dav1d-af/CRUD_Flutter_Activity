import 'dart:convert';
import 'package:dafmon_listview/api_service/student_repository.dart';
import 'package:dafmon_listview/model/student_model.dart';
import 'package:http/http.dart' as http;

class StudentRepositoryImpl implements StudentRepository {
  final String baseUrl = 'http://localhost:3000/api';

  @override
  Future<void> addStudent(StudentModel student) async {
    final url = Uri.parse('$baseUrl/insertUser');
    final data = student.toJson();

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to send data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Future<void> deleteStudent(int id) async {
    final url = Uri.parse('$baseUrl/deleteUser/$id');

    try {
      final response = await http.delete(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete student: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Future<List<StudentModel>> getAllStudents() async {
    final url = Uri.parse('$baseUrl/listAllUsers');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => StudentModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load all students: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Future<List<StudentModel>> getStudentsByYear(String year) async {
    final url = Uri.parse('$baseUrl/listUsers?year=$year');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => StudentModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load students: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Future<void> updateStudent(int id, Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/updateUser/$id');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        print('Student updated successfully: ${response.body}');
      } else {
        print('Failed to update student: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
