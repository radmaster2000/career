import 'package:json_annotation/json_annotation.dart';

part 'course_model.g.dart';

@JsonSerializable()
class Courses {
  final bool isUpcoming;
  final String id;
  final String course_name;
  final String course_description;
  final CourseImage course_image;
  final Mentor mentor;
  final List<String> tags_covers;
  final int course_price;
  final String start_live_course_date;
  final String class_duration_time;
  //final int v;

  Courses({
    required this.isUpcoming,
    required this.id,
    required this.course_name,
    required this.course_description,
    required this.course_image,
    required this.mentor,
    required this.tags_covers,
    required this.course_price,
    required this.start_live_course_date,
    required this.class_duration_time,
    //required this.v,
  });

  factory Courses.fromJson(Map<String, dynamic> json) => _$CoursesFromJson(json);
  Map<String, dynamic> toJson() => _$CoursesToJson(this);
}

@JsonSerializable()
class CourseImage {
  final String type;
  final List<int> data;

  CourseImage({required this.type, required this.data});

  factory CourseImage.fromJson(Map<String, dynamic> json) =>
      _$CourseImageFromJson(json);
  Map<String, dynamic> toJson() => _$CourseImageToJson(this);
}

@JsonSerializable()
class Mentor {
  final String id;
  final String name;
  final String email;
  final ProfilePicture profile_picture;
  final String bio;
  final DateTime createdAt;
  //final int v;

  Mentor({
    required this.id,
    required this.name,
    required this.email,
    required this.profile_picture,
    required this.bio,
    required this.createdAt,
    //required this.v,
  });

  factory Mentor.fromJson(Map<String, dynamic> json) => _$MentorFromJson(json);
  Map<String, dynamic> toJson() => _$MentorToJson(this);
}

@JsonSerializable()
class ProfilePicture {
  final String type;
  final List<int> data;

  ProfilePicture({required this.type, required this.data});

  factory ProfilePicture.fromJson(Map<String, dynamic> json) =>
      _$ProfilePictureFromJson(json);
  Map<String, dynamic> toJson() => _$ProfilePictureToJson(this);
}