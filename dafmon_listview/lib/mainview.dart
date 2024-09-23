import 'package:dafmon_listview/add_student.dart';
import 'package:dafmon_listview/api_service/student_repository_impl.dart';
import 'package:dafmon_listview/api_service/student_repository.dart';
import 'package:dafmon_listview/model/student_model.dart';
import 'package:dafmon_listview/update_student.dart';
import 'package:dafmon_listview/widget/custom_dropdown.dart';
import 'package:dafmon_listview/widget/custom_floating_button.dart';
import 'package:dafmon_listview/widget/custom_student_list.dart';
import 'package:flutter/material.dart';

class Mainview extends StatefulWidget {
  const Mainview({super.key});

  @override
  State createState() => _MainviewState();
}

class _MainviewState extends State<Mainview> {
  late Future<List<StudentModel>> futureStudents;
  String selectedYear = 'No Year Filter';
  final Map<String, int> yearMapping = {
    'First Year': 1,
    'Second Year': 2,
    'Third Year': 3,
    'Fourth Year': 4,
    'Fifth Year': 5,
  };

  final List<String> years = [
    'No Year Filter',
    'First Year',
    'Second Year',
    'Third Year',
    'Fourth Year',
    'Fifth Year'
  ];

  late StudentRepositoryImpl _studentRepositoryImpl;

  @override
  void initState() {
    super.initState();
    _studentRepositoryImpl = StudentRepositoryImpl();
    _updateStudents();
  }

  void _updateStudents() {
    if (_studentRepositoryImpl != null) {
      // Ensure the repository is initialized
      setState(() {
        if (selectedYear == 'No Year Filter') {
          futureStudents = _studentRepositoryImpl.getAllStudents();
        } else {
          futureStudents = _studentRepositoryImpl
              .getStudentsByYear(yearMapping[selectedYear]!.toString());
        }
      });
    } else {
      // Handle the case where _studentRepository is not initialized
      print('StudentRepository has not been initialized.');
    }
  }

  void _navigateToUpdateStudentScreen(StudentModel student) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateStudentScreen(
          student: student,
          onUpdate: _updateStudents,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Card(
              color: Colors.white,
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomDropdown(
                        selectedYear: selectedYear,
                        years: years,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedYear = newValue!;
                            _updateStudents();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: StudentList(
              futureStudents: futureStudents,
              onCardTap: _navigateToUpdateStudentScreen,
            ),
          ),
        ],
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddStudentScreen(
                      onAdd: _updateStudents,
                    )),
          );

          if (result == true) {
            _updateStudents();
          }
        },
      ),
    );
  }
}
