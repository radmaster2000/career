// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mentor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mentor _$MentorFromJson(Map<String, dynamic> json) => Mentor(
      id: json['_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      profile_picture: json['profile_picture'] == null
          ? null
          : ProfilePicture.fromJson(
              json['profile_picture'] as Map<String, dynamic>),
      bio: json['bio'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      version: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$MentorToJson(Mentor instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'profile_picture': instance.profile_picture,
      'bio': instance.bio,
      'createdAt': instance.createdAt.toIso8601String(),
      '__v': instance.version,
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
