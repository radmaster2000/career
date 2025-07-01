// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Courses _$CoursesFromJson(Map<String, dynamic> json) => Courses(
      isUpcoming: json['isUpcoming'] as bool,
      id: json['_id'] as String,
      course_name: json['course_name'] as String,
      course_description: json['course_description'] as String,
      course_image:
          CourseImage.fromJson(json['course_image'] as Map<String, dynamic>),
      mentor: Mentor.fromJson(json['mentor'] as Map<String, dynamic>),
      tags_covers: (json['tags_covers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      course_price: (json['course_price'] as num).toInt(),
      start_live_course_date: json['start_live_course_date'] as String,
      class_duration_time: json['class_duration_time'] as String,
    );

Map<String, dynamic> _$CoursesToJson(Courses instance) => <String, dynamic>{
      'isUpcoming': instance.isUpcoming,
      '_id': instance.id,
      'course_name': instance.course_name,
      'course_description': instance.course_description,
      'course_image': instance.course_image,
      'mentor': instance.mentor,
      'tags_covers': instance.tags_covers,
      'course_price': instance.course_price,
      'start_live_course_date': instance.start_live_course_date,
      'class_duration_time': instance.class_duration_time,
    };

CourseImage _$CourseImageFromJson(Map<String, dynamic> json) => CourseImage(
      type: json['type'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$CourseImageToJson(CourseImage instance) =>
    <String, dynamic>{
      'type': instance.type,
      'data': instance.data,
    };

Mentor _$MentorFromJson(Map<String, dynamic> json) => Mentor(
      id: json['_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      profile_picture: ProfilePicture.fromJson(
          json['profile_picture'] as Map<String, dynamic>),
      bio: json['bio'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$MentorToJson(Mentor instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'profile_picture': instance.profile_picture,
      'bio': instance.bio,
      'createdAt': instance.createdAt.toIso8601String(),
    };

ProfilePicture _$ProfilePictureFromJson(Map<String, dynamic> json) =>
    ProfilePicture(
      type: json['type'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$ProfilePictureToJson(ProfilePicture instance) =>
    <String, dynamic>{
      'type': instance.type,
      'data': instance.data,
    };
