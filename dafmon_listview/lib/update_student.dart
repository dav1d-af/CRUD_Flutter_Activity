// ignore_for_file: avoid_print

import 'package:dafmon_listview/api_service/api_helper.dart';
import 'package:dafmon_listview/model/student_model.dart';
import 'package:dafmon_listview/widget/custom_switch.dart';
import 'package:dafmon_listview/widget/custom_dropdown.dart';
import 'package:flutter/material.dart';

class UpdateStudentScreen extends StatefulWidget {
  final StudentModel student;

  const UpdateStudentScreen({super.key, required this.student});

  @override
  State createState() => _UpdateStudentScreenState();
}

class _UpdateStudentScreenState extends State<UpdateStudentScreen> {
  final _apiHelper = ApiHelper();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  String _selectedYear = 'First Year';
  final List<String> _years = [
    'First Year',
    'Second Year',
    'Third Year',
    'Fourth Year',
    'Fifth Year'
  ];
  bool _enrolled = false;

  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.student.firstName;
    _lastNameController.text = widget.student.lastName;
    _courseController.text = widget.student.course;
    _selectedYear = _years[widget.student.year - 1];
    _enrolled = widget.student.enrolled;
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
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your first name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your last name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _courseController,
                decoration: const InputDecoration(
                  labelText: 'Course',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your course';
                  }
                  return null;
                },
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
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 5.0), // Add padding around the Row
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center items horizontally
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0), // Add padding between buttons
                      child: ElevatedButton(
                        onPressed: () {
                          _apiHelper.updateRecord(
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
                        },
                        child: const Text(
                          'Update Record',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0), // Add padding between buttons
                      child: ElevatedButton(
                        onPressed: () {
                          _apiHelper.deleteStudent(
                            studentId: widget.student.id!,
                            context: context,
                          );
                        },
                        child: const Text(
                          'Delete Record',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
