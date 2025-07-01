import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/inputTextWidget.dart';
import 'course_controller.dart';

class AddCoursePage extends StatefulWidget {
  @override
  State<AddCoursePage> createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  CourseController courseController=Get.find();
  final _formKey = GlobalKey<FormState>();
  String mentor_id="682cc0bada1459dfb65ce454";
  List<String> selectedOptions = [];
  File? _courseImage;
  bool _isChecked = false;
  Uint8List? _imageBytes;
  final ImagePicker _picker = ImagePicker();
  final List<String> allOptions = [
    'Flutter',
    'Dart',
    'Firebase',
    'Android',
    'iOS',
    'Web'
  ];
  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Image Source'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
            child: Text('Camera'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
            child: Text('Gallery'),
          ),
        ],
      ),
    );
  }
  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _courseImage = File(pickedFile.path);
          _imageBytes = _courseImage!.readAsBytesSync();
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: ${e.toString()}')),
      );
    }
  }
  Widget get _dummyImage => Container(
    width: 150,
    height: 150,
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.image, size: 40, color: Colors.grey),
        SizedBox(height: 8),
        Text('No image selected', style: TextStyle(color: Colors.grey)),
      ],
    ),
  );

  // Selected image widget
  Widget get _selectedImage => Container(
    width: 150,
    height: 150,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      image: DecorationImage(
        image: FileImage(_courseImage!),
        fit: BoxFit.cover,
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Course'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: _showImageSourceDialog,
                child: _courseImage == null ? _dummyImage : _selectedImage,
              ),
              SizedBox(
                height: 10.h,
              ),
              // Course Title
              InputTextWidget(
                  labelText: "Course name",
                  icon: Icons.person,
                  //controller: first,
                  obscureText: false,
                  keyboardType: TextInputType.text),
              SizedBox(
                height: 10.h,
              ),
              InputTextWidget(
                  labelText: "First name",
                  icon: Icons.person,
                  //controller: first,
                  obscureText: false,
                  keyboardType: TextInputType.text),
              SizedBox(
                height: 10.h,
              ),
              InputTextWidget(
                  labelText: "Course Description",
                  isDescription: true,
                  icon: Icons.description,
                  //controller: first,
                  obscureText: false,
                  keyboardType: TextInputType.text),
              SizedBox(
                height: 10.h,
              ),
            Wrap(
              spacing: 8.0,
              children: allOptions.map((option) {
                return FilterChip(
                  label: Text(option),
                  selected: selectedOptions.contains(option),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        selectedOptions.add(option);
                      } else {
                        selectedOptions.remove(option);
                      }
                    });
                  },
                );
              }).toList(),
            ),
              SizedBox(
                height: 10.h,
              ),

              InputTextWidget(
                  labelText: "First name",
                  icon: Icons.person,
                  //controller: first,
                  obscureText: false,
                  keyboardType: TextInputType.text),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: InputTextWidget(
                        labelText: "Course Price",
                        icon: null,
                        //controller: first,
                        obscureText: false,
                        keyboardType: TextInputType.number),
                  ),
                  Expanded(
                    child: InputTextWidget(
                        labelText: "in hours",
                        icon: null,
                        //controller: first,
                        obscureText: false,
                        keyboardType: TextInputType.number),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
            Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value ?? false;
                    });
                  },
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isChecked = !_isChecked;
                      });
                    },
                    child: Text("Upcoming Course")
                  ),
                ),
              ],
            ),
              // TextFormField(
              //   decoration: InputDecoration(
              //     labelText: 'Course Title',
              //     border: OutlineInputBorder(),
              //   ),
              //   validator: (value) =>
              //   value!.isEmpty ? 'Please enter course title' : null,
              // ),
              //
              // SizedBox(height: 16),
              //
              // // Course Description
              // TextFormField(
              //   decoration: InputDecoration(
              //     labelText: 'Description',
              //     border: OutlineInputBorder(),
              //   ),
              //   maxLines: 4,
              //   validator: (value) =>
              //   value!.isEmpty ? 'Please enter description' : null,
              // ),
              //
              // SizedBox(height: 16),
              //
              // // Category Dropdown
              // DropdownButtonFormField<String>(
              //   items: ['Math', 'Science', 'History', 'Technology']
              //       .map((category) => DropdownMenuItem(
              //     value: category,
              //     child: Text(category),
              //   ))
              //       .toList(),
              //   onChanged: (value) {},
              //   decoration: InputDecoration(
              //     labelText: 'Category',
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              //
              // SizedBox(height: 16),
              //
              // // Course Duration
              // TextFormField(
              //   decoration: InputDecoration(
              //     labelText: 'Duration (e.g., 4 weeks)',
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              //
              // SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  var body={
                    "course_name": "hello",
                    "course_description": "hjdsfgjhdAn immersive, hands-on bootcamp that covers front-end and back-end technologies including HTML, CSS, JavaScript, Node.js, and MongoDB.",
                    "course_image": "binary_image_data_here",  // This will be a binary or base64 image string, for now, just a placeholder.
                    "mentor_id": "682cc0bada1459dfb65ce454",  // Replace with a valid mentor ID from your Mentor collection
                    "tags_covers": ["Web Development", "Full Stack", "Node.js", "MongoDB", "JavaScript"],
                    "course_price": 4999,
                    "isUpcoming": false,
                    "start_live_course_date": "2025-08-01T09:00:00Z",
                    "class_duration_time": "4 hours"
                  };
                  courseController.postCourseData(body);
                  // if (_formKey.currentState!.validate()) {
                  //   // Submit logic here
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(content: Text('Course added successfully')),
                  //   );
                  // }

                },
                child: Text('Add Course'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}