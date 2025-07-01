import 'dart:io';

import 'package:career/screens/notes/notes_model.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

import '../../../api/api_methods.dart';
import '../../../models/course.dart';
import '../../api/api_routes.dart';


class NotesController extends GetxController {
  var isLoading = false.obs;
  final isUploading = false.obs;
  var notesList = RxList<NotesModel>();

  @override
  void onInit() {
    fetchNotes();
    super.onInit();
  }

  Future<void> fetchNotes() async {
    print("notes fetching");
    try {
      isLoading(true);
      final response = await getAllNotes();

      if (response.statusCode == 200) {
        List<dynamic> jsonData = response.data["notes"];
        print("course getting $response");
        for (final item in jsonData) {
          try {
            if (item != null && item is Map<String, dynamic>) {
              notesList.add(NotesModel.fromJson(item));
            } else {
              print("Skipping invalid item: $item");
            }
          } catch (e) {
            print("Error parsing item $item: $e");
          }
        }// Fallback to empty list if null
        print("productList is $notesList");
      } else {
        Get.snackbar('Error', 'Failed to fetch data');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
  Future<void> uploadNotes({
    required String title,
    required String description,
    required List<String> tagsCovers,
    required String mentorId,
    File? file,
  }) async {
    try {
      isLoading(true);

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(NotesUploadUrl),
      );

      // Add text fields
      request.fields['title'] = title;
      request.fields['description'] = description;
      request.fields['mentorId'] = mentorId;
      request.fields['tags_covers'] = tagsCovers.join(',');

      // Add file if exists
      if (file != null) {
        request.files.add(
          http.MultipartFile(
            'file',
            file.readAsBytes().asStream(),
            file.lengthSync(),
            filename: file.path.split('/').last,
          ),
        );
      }

      final response = await request.send();
      final responseData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Notes uploaded successfully');
      } else {
        Get.snackbar('Error', 'Failed to upload notes: $responseData');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}