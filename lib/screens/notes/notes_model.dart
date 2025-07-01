class NotesModel {
  final String id;
  final String title;
  final String description;
  final String fileUrl;
  final UploadedBy uploadedBy;
  final List<String> tags;
  final DateTime createdAt;
  final int version;

  NotesModel({
    required this.id,
    required this.title,
    required this.description,
    required this.fileUrl,
    required this.uploadedBy,
    required this.tags,
    required this.createdAt,
    required this.version,
  });

  // Convert JSON to Document
  factory NotesModel.fromJson(Map<String, dynamic> json) {
    return NotesModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      fileUrl: json['file_url'] as String,
      uploadedBy: UploadedBy.fromJson(json['uploaded_by'] as Map<String, dynamic>),
      tags: (json['tags_covers'] as List).map((item) => item as String).toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      version: json['__v'] as int,
    );
  }

  // Convert Document to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'file_url': fileUrl,
      'uploaded_by': uploadedBy.toJson(),
      'tags_covers': tags,
      'createdAt': createdAt.toIso8601String(),
      '__v': version,
    };
  }

  // Helper for copying with modified fields
  NotesModel copyWith({
    String? id,
    String? title,
    String? description,
    String? fileUrl,
    UploadedBy? uploadedBy,
    List<String>? tags,
    DateTime? createdAt,
    int? version,
  }) {
    return NotesModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      fileUrl: fileUrl ?? this.fileUrl,
      uploadedBy: uploadedBy ?? this.uploadedBy,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      version: version ?? this.version,
    );
  }
}

class UploadedBy {
  final String id;
  final String name;
  final String email;

  UploadedBy({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UploadedBy.fromJson(Map<String, dynamic> json) {
    return UploadedBy(
      id: json['_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
    };
  }

  UploadedBy copyWith({
    String? id,
    String? name,
    String? email,
  }) {
    return UploadedBy(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}