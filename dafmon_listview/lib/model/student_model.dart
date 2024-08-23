class StudentModel {
  final int? id;
  final String firstName;
  final String lastName;
  final String course;
  final int year;
  final bool enrolled;

  StudentModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.course,
    required this.year,
    required this.enrolled,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'] as int?,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      course: json['course'] as String,
      year: json['year'] as int,
      enrolled: json['enrolled'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'course': course,
      'year': year,
      'enrolled': enrolled ? 1 : 0,
    };
  }
}
