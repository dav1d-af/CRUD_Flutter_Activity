class StudentModel {
  final String? id; // Change to String
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

  // Convert the StudentModel to JSON for sending to the API
  Map<String, dynamic> toJson() {
    return {
      '_id': id, // Ensure this is included if needed
      'firstName': firstName,
      'lastName': lastName,
      'course': course,
      'year': year,
      'enrolled': enrolled,
    };
  }

  // Add a factory constructor to create a StudentModel from JSON if needed
  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['_id'] as String?,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      course: json['course'] as String,
      year: json['year'] as int,
      enrolled: json['enrolled'] as bool,
    );
  }
}
