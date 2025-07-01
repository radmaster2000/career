import 'dart:io';
import 'dart:typed_data';


import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart' as http;
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../widgets/inputTextWidget.dart';
import '../teacher/course_controller.dart';
import 'notes_controller.dart';

class NotesUpload extends StatefulWidget {
  @override
  State<NotesUpload> createState() => _NotesUploadState();
}

class _NotesUploadState extends State<NotesUpload> {
  NotesController notesController=Get.find();
  final _formKey = GlobalKey<FormState>();
  String mentor_id="682cc0bada1459dfb65ce454";
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  List<String> selectedOptions = [];
  File? _courseImage;
  bool _isChecked = false;
  Uint8List? _imageBytes;
  final ImagePicker _picker = ImagePicker();
  File? _selectedFile;
  final List<String> allOptions = [
    'Flutter',
    'Dart',
    'Firebase',
    'Android',
    'iOS',
    'Web'
  ];
  Future<File?> pickFileFromGallery(BuildContext context) async {
    try {
      // Skip permission check on Android 13+ (file picker handles it internally)
      if (Platform.isAndroid && await DeviceInfoPlugin().androidInfo.then((info) => info.version.sdkInt <= 32)) {
        final status = await Permission.manageExternalStorage.request();
        if (!status.isGranted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Allow file access in settings")),
          );
          return null;
        }
      }

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      return result?.files.first?.path != null ? File(result!.files.first.path!) : null;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
      return null;
    }
  }
  void _showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Image Source'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera, context);
            },
            child: Text('Camera'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery, context);
            },
            child: Text('Gallery'),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(ImageSource source, BuildContext context) async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        // Show loading indicator
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(child: CircularProgressIndicator()),
        );

        // Upload the file
        //final uploadResponse = await _uploadFile(File(pickedFile.path));

        // Hide loading indicator
        Navigator.pop(context);

        // Show result
        // if (uploadResponse.statusCode == 200) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text('Image uploaded successfully!')),
        //   );
        // } else {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text('Upload failed!')),
        //   );
        // }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  // Future<http.Response> _uploadFile(File file) async {
  //   // Create multipart request
  //   var request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse('https://your-server.com/upload'), // Replace with your endpoint
  //   );
  //
  //   // Add file to the request
  //   request.files.add(
  //     await http.MultipartFile.fromPath(
  //       'file', // This should match your server's expected parameter name
  //       file.path,
  //     ),
  //   );
  //
  //   // You can add additional fields if needed
  //   // request.fields['key'] = 'value';
  //
  //   // Send the request
  //   var response = await request.send();
  //
  //   // Get the response from the server
  //   return await http.Response.fromStream(response);
  // }
  // Future<void> _pickImage(ImageSource source) async {
  //   try {
  //     final pickedFile = await _picker.pickImage(source: source);
  //     if (pickedFile != null) {
  //       setState(() {
  //         _courseImage = File(pickedFile.path);
  //         _imageBytes = _courseImage!.readAsBytesSync() as Uint8List?;
  //       });
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to pick image: ${e.toString()}')),
  //     );
  //   }
  // }
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
        title: Text('Add Notes'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: ()async{
        _selectedFile= await pickFileFromGallery(context);
                },
                child: _courseImage == null ? _dummyImage : _selectedImage,
              ),
              SizedBox(
                height: 10.h,
              ),
              // Course Title
              // InputTextWidget(
              //     labelText: "Title",
              //     icon: Icons.person,
              //     //controller: first,
              //     obscureText: false,
              //     keyboardType: TextInputType.text),
              // SizedBox(
              //   height: 10.h,
              // ),
              InputTextWidget(
                  labelText: "Title",
                  icon: Icons.person,
                  controller: titleController,
                  obscureText: false,
                  keyboardType: TextInputType.text),
              SizedBox(
                height: 10.h,
              ),
              InputTextWidget(
                  labelText: "Course Description",
                  isDescription: true,
                  icon: Icons.description,
                  controller: descriptionController,
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

              // InputTextWidget(
              //     labelText: "First name",
              //     icon: Icons.person,
              //     //controller: first,
              //     obscureText: false,
              //     keyboardType: TextInputType.text),
              // SizedBox(
              //   height: 10.h,
              // ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: InputTextWidget(
              //           labelText: "Course Price",
              //           icon: null,
              //           //controller: first,
              //           obscureText: false,
              //           keyboardType: TextInputType.number),
              //     ),
              //     Expanded(
              //       child: InputTextWidget(
              //           labelText: "in hours",
              //           icon: null,
              //           //controller: first,
              //           obscureText: false,
              //           keyboardType: TextInputType.number),
              //     ),
              //   ],
              // ),
              SizedBox(
                height: 10.h,
              ),
              // Row(
              //   children: [
              //     Checkbox(
              //       value: _isChecked,
              //       onChanged: (bool? value) {
              //         setState(() {
              //           _isChecked = value ?? false;
              //         });
              //       },
              //     ),
              //     Expanded(
              //       child: GestureDetector(
              //           onTap: () {
              //             setState(() {
              //               _isChecked = !_isChecked;
              //             });
              //           },
              //           child: Text("Upcoming Course")
              //       ),
              //     ),
              //   ],
              // ),
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
        Obx(() => ElevatedButton(
          onPressed: notesController.isLoading.value
              ? null
              : () async {
            if (_formKey.currentState!.validate()) {
              if (_selectedFile == null) {
                Get.snackbar('Warning', 'Please select a file');
                return;
              }
              if (selectedOptions.isEmpty) {
                Get.snackbar('Warning', 'Please select at least one tag');
                return;
              }

              await notesController.uploadNotes(
                title: titleController.text,
                description: descriptionController.text,
                tagsCovers: selectedOptions,
                mentorId: mentor_id,
                file: _selectedFile,
              );
            }
          },
          child: notesController.isLoading.value
              ? CircularProgressIndicator(color: Colors.white)
              : Text('Upload Notes'),
        ),
        )],
          ),
        ),
      ),
    );
  }
}