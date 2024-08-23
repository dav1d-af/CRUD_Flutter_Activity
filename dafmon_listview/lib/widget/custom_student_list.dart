import 'package:dafmon_listview/widget/custom_student_card.dart';
import 'package:flutter/material.dart';
import 'package:dafmon_listview/model/student_model.dart';

class StudentList extends StatelessWidget {
  final Future<List<StudentModel>> futureStudents;

  const StudentList({super.key, required this.futureStudents});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<StudentModel>>(
      future: futureStudents,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No students found'));
        } else {
          final students = snapshot.data!;
          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              return StudentCard(student: student);
            },
          );
        }
      },
    );
  }

  String convertYear(int year) {
    switch (year) {
      case 1:
        return 'First';
      case 2:
        return 'Second';
      case 3:
        return 'Third';
      case 4:
        return 'Fourth';
      case 5:
        return 'Fifth';
      default:
        return 'Unknown';
    }
  }
}
