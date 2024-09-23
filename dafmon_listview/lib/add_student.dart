// ignore_for_file: avoid_print

import 'package:dafmon_listview/api_service/student_repository_impl.dart';
import 'package:dafmon_listview/widget/custom_dropdown.dart';
import 'package:dafmon_listview/widget/custom_switch.dart';
import 'package:dafmon_listview/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:dafmon_listview/model/student_model.dart';

class AddStudentScreen extends StatefulWidget {
  final VoidCallback onAdd;

  const AddStudentScreen({super.key, required this.onAdd});

  @override
  State createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  late StudentRepositoryImpl _studentRepositoryImpl;
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
    _studentRepositoryImpl = StudentRepositoryImpl();
  }

  Future<void> _addStudent() async {
    if (_formKey.currentState?.validate() ?? false) {
      int year = _years.indexOf(_selectedYear) + 1;

      final student = StudentModel(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        course: _courseController.text,
        year: year,
        enrolled: _enrolled,
      );

      try {
        await _studentRepositoryImpl.addStudent(student);
        print('Student added successfully');
        widget.onAdd();

        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } catch (error) {
        print('Failed to add student: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addStudent,
                child: const Text(
                  'Add Student',
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
