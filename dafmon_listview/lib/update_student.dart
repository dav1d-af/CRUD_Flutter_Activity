// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:dafmon_listview/api_service/api_helper.dart';
import 'package:flutter/material.dart';
import 'package:dafmon_listview/model/student_model.dart';

class UpdateStudentScreen extends StatefulWidget {
  final StudentModel student;
  final VoidCallback onUpdate;

  const UpdateStudentScreen({
    super.key,
    required this.student,
    required this.onUpdate,
  });

  @override
  // ignore: library_private_types_in_public_api
  _UpdateStudentScreenState createState() => _UpdateStudentScreenState();
}

class _UpdateStudentScreenState extends State<UpdateStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _courseController = TextEditingController();
  String _selectedYear = 'First Year';
  bool _enrolled = true;
  final _years = [
    'First Year',
    'Second Year',
    'Third Year',
    'Fourth Year',
    'Fifth Year'
  ];

  late ApiHelper _apiHelper;

  @override
  void initState() {
    1;
    super.initState();
    _apiHelper = ApiHelper();
    _firstNameController.text = widget.student.firstName;
    _lastNameController.text = widget.student.lastName;
    _courseController.text = widget.student.course;
    _selectedYear = yearToString(widget.student.year);
    _enrolled = widget.student.enrolled;
  }

  String yearToString(int year) {
    switch (year) {
      case 1:
        return 'First Year';
      case 2:
        return 'Second Year';
      case 3:
        return 'Third Year';
      case 4:
        return 'Fourth Year';
      case 5:
        return 'Fifth Year';
      default:
        return 'Unknown Year';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a first name' : null,
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a last name' : null,
              ),
              TextFormField(
                controller: _courseController,
                decoration: const InputDecoration(labelText: 'Course'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a course' : null,
              ),
              DropdownButtonFormField<String>(
                value: _selectedYear,
                items: _years.map((year) {
                  return DropdownMenuItem(
                    value: year,
                    child: Text(year),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedYear = value!),
              ),
              CheckboxListTile(
                title: const Text('Enrolled'),
                value: _enrolled,
                onChanged: (value) => setState(() => _enrolled = value!),
              ),
              ElevatedButton(
                onPressed: () async {
                  bool result = await _apiHelper.updateRecord(
                    student: widget.student,
                    formKey: _formKey,
                    firstNameController: _firstNameController,
                    lastNameController: _lastNameController,
                    courseController: _courseController,
                    selectedYear: _selectedYear,
                    years: _years,
                    enrolled: _enrolled,
                    context: context,
                  );
                  if (result) {
                    widget.onUpdate(); // Notify Mainview
                    Navigator.pop(context);
                  } else {
                    print('Failed to update student');
                  }
                },
                child: const Text(
                  'Update Record',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  bool result = await _apiHelper.deleteStudent(
                    studentId: widget.student.id!,
                    context: context,
                  );
                  if (result) {
                    widget.onUpdate();
                    Navigator.pop(context);
                  } else {
                    print('Failed to delete student');
                  }
                },
                child: const Text(
                  'Delete Record',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
