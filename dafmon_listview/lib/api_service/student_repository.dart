// repositories/student_repository.dart
import 'package:dafmon_listview/api_service/api_service.dart';
import 'package:dafmon_listview/model/student_model.dart';

class StudentRepository {
  final ApiService apiService;

  StudentRepository({required this.apiService});

  Future<void> addStudent(StudentModel student) async {
    await apiService.sendData(student);
  }

Future<void> updateStudent(StudentModel student) async {
    if (student.id != null) {
      final data = student.toJson();
      await apiService.updateStudent(student.id!, data);
    } else {
      throw ArgumentError('Student ID cannot be null for update');
    }
  }
  Future<void> deleteStudent(int id) async {
    await apiService.deleteStudent(id);
  }

  Future<List<StudentModel>> getStudentsByYear(String year) async {
    return await apiService.fetchStudentsYear(year);
  }

  Future<List<StudentModel>> getAllStudents() async {
    return await apiService.fetchAllStudents();
  }
}
