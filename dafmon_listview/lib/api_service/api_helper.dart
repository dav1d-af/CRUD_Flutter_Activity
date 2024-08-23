// lib/helpers/form_helpers.dart

import 'package:dafmon_listview/api_service/api_service.dart';
import 'package:dafmon_listview/model/student_model.dart';
import 'package:flutter/material.dart';

void submitForm({
  required GlobalKey<FormState> formKey,
  required TextEditingController firstNameController,
  required TextEditingController lastNameController,
  required TextEditingController courseController,
  required String selectedYear,
  required List<String> years,
  required bool enrolled,
  required BuildContext context,
}) {
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

    ApiService().sendData(data).then((_) {
      Navigator.pop(context);
    }).catchError((error) {
      print('Failed to send data: $error');
      Navigator.pop(context);
    });
  }
}
