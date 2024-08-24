// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:dafmon_listview/api_service/api_helper.dart';
import 'package:dafmon_listview/widget/custom_dropdown.dart';
import 'package:dafmon_listview/widget/custom_switch.dart';
import 'package:dafmon_listview/widget/custom_textfield.dart';
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
              const SizedBox(height: 16),
              CustomTextField(
                controller: _firstNameController,
                labelText: 'First Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your first name';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _lastNameController,
                labelText: 'Last Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your last name';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _courseController,
                labelText: 'Course',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your course';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Card(
                  color: Colors.white,
                  elevation: 1,
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomDropdown(
                          selectedYear: _selectedYear,
                          years: _years,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedYear = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: CustomSwitch(
                  value: _enrolled,
                  onChanged: (bool value) {
                    setState(() {
                      _enrolled = value;
                    });
                  },
                  title: 'Enrolled',
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
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
                          widget.onUpdate();
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
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
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
