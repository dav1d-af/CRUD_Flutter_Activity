import 'package:dafmon_listview/api_service/api_service.dart';
import 'package:dafmon_listview/model/student_model.dart';
import 'package:flutter/material.dart';

class ApiHelper {
  Future<bool> insertData({
    required GlobalKey<FormState> formKey,
    required TextEditingController firstNameController,
    required TextEditingController lastNameController,
    required TextEditingController courseController,
    required String selectedYear,
    required List<String> years,
    required bool enrolled,
    required BuildContext context,
  }) async {
    if (formKey.currentState?.validate() ?? false) {
      int year = years.indexOf(selectedYear) + 1;

      final student = StudentModel(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        course: courseController.text,
        year: year,
        enrolled: enrolled,
      );

      Map<String, dynamic> data = {
        'firstName': student.firstName,
        'lastName': student.lastName,
        'course': student.course,
        'year': student.year,
        'enrolled': student.enrolled ? 1 : 0, // Convert boolean to 1/0
      };

      try {
        await ApiService().sendData(data);
        return true; // Indicate success
      } catch (error) {
        print('Failed to send data: $error');
        return false; // Indicate failure
      } finally {
        Navigator.pop(context, true);
      }
    }
    return false; // Form is not valid
  }

  Future<bool> updateRecord({
    required StudentModel student,
    required GlobalKey<FormState> formKey,
    required TextEditingController firstNameController,
    required TextEditingController lastNameController,
    required TextEditingController courseController,
    required String selectedYear,
    required List<String> years,
    required bool enrolled,
    required BuildContext context,
  }) async {
    if (formKey.currentState?.validate() ?? false) {
      int year = years.indexOf(selectedYear) + 1;

      final updatedStudent = StudentModel(
        id: student.id,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        course: courseController.text,
        year: year,
        enrolled: enrolled,
      );

      Map<String, dynamic> data = updatedStudent.toJson();

      try {
        await ApiService().updateStudent(updatedStudent.id!, data);
        Navigator.pop(context, true);
        return true;
      } catch (error) {
        print('Failed to update: $error');
        Navigator.pop(context, false);
        return false;
      }
    }
    return false;
  }

  Future<bool> deleteStudent({
    required int studentId,
    required BuildContext context,
  }) async {
    try {
      await ApiService().deleteStudent(studentId);
      return true; // Indicate success
    } catch (error) {
      print('Failed to delete student: $error');
      return false; // Indicate failure
    }
  }
}
