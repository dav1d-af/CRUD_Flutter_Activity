// repositories/student_repository.dart
import 'package:dafmon_listview/model/student_model.dart';

abstract class StudentRepository {
  Future<void> addStudent(StudentModel student);
  Future<void> updateStudent(String id, Map<String, dynamic> data);
  Future<void> deleteStudent(String id);
  Future<List<StudentModel>> getStudentsByYear(String year);
  Future<List<StudentModel>> getAllStudents();
}
