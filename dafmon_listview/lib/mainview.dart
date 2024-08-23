import 'package:dafmon_listview/add_student.dart';
import 'package:dafmon_listview/api_service/api_service.dart';
import 'package:dafmon_listview/model/student_model.dart';
import 'package:dafmon_listview/widget/custom_dropdown.dart';
import 'package:dafmon_listview/widget/custom_floating_button.dart';
import 'package:dafmon_listview/widget/custom_student_list.dart';
import 'package:flutter/material.dart';

class Mainview extends StatefulWidget {
  const Mainview({super.key});

  @override
  State createState() => _Mainviewstate();
}

class _Mainviewstate extends State<Mainview> {
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

  @override
  void initState() {
    super.initState();
    futureStudents = ApiService()
        .fetchStudentsYear(yearMapping[selectedYear]?.toString() ?? '');
  }

  void _updateStudents() {
    setState(() {
      if (selectedYear == 'No Year Filter') {
        futureStudents = ApiService().fetchAllStudents();
      } else {
        futureStudents = ApiService()
            .fetchStudentsYear(yearMapping[selectedYear]!.toString());
      }
    });
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
            child: StudentList(futureStudents: futureStudents),
          ),
        ],
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddStudentScreen()),
          );
        },
      ),
    );
  }
}
