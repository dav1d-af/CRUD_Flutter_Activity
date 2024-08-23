import 'package:dafmon_listview/api_service/api_helper.dart';
import 'package:dafmon_listview/widget/custom_dropdown.dart';
import 'package:dafmon_listview/widget/custom_switch.dart';
import 'package:flutter/material.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiHelper _apiHelper = ApiHelper();

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student'),
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
              ElevatedButton(
                onPressed: () => _apiHelper.insertData(
                  formKey: _formKey,
                  firstNameController: _firstNameController,
                  lastNameController: _lastNameController,
                  courseController: _courseController,
                  selectedYear: _selectedYear,
                  years: _years,
                  enrolled: _enrolled,
                  context: context,
                ),
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
