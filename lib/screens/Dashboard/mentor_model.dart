import 'dart:typed_data';
import 'package:json_annotation/json_annotation.dart';

part 'mentor_model.g.dart'; // Updated file name

@JsonSerializable()
class Mentor {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String email;
  final ProfilePicture? profile_picture;
  final String bio;
  final DateTime createdAt;
  @JsonKey(name: '__v')
  final int version;

  Mentor({
    required this.id,
    required this.name,
    required this.email,
    this.profile_picture,
    required this.bio,
    required this.createdAt,
    required this.version,
  });

  // JSON Serialization
  factory Mentor.fromJson(Map<String, dynamic> json) => _$MentorFromJson(json);
  Map<String, dynamic> toJson() => _$MentorToJson(this);

  bool get hasProfilePicture => profile_picture?.data?.isNotEmpty ?? false;
}

@JsonSerializable()
class ProfilePicture {
  final String type;
  final List<int> data;

  ProfilePicture({
    required this.type,
    required this.data,
  });

  Uint8List get bytes => Uint8List.fromList(data);

  factory ProfilePicture.fromJson(Map<String, dynamic> json) =>
      _$ProfilePictureFromJson(json);
  Map<String, dynamic> toJson() => _$ProfilePictureToJson(this);
}