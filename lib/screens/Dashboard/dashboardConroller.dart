import 'package:career/screens/Dashboard/mentor_model.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../api/api_methods.dart';

class DashboardController extends GetxController {
var isLoading = false.obs;
var mentorList = <Mentor>[].obs;

@override
void onInit() {
  getAllMentors();
  super.onInit();
}

Future<void> getAllMentors() async {
  try {
    isLoading(true);
    final response = await getAllMentorsData();

    if (response.statusCode == 200) {
      List<dynamic> jsonData = response.data["mentors"];
      print("mentors getting $response");
      for (final item in jsonData) {
        try {
          if (item != null && item is Map<String, dynamic>) {
            mentorList.add(Mentor.fromJson(item));
          } else {
            print("Skipping invalid item: $item");
          }
        } catch (e) {
          print("Error parsing item $item: $e");
        }
      }// Fallback to empty list if null
      print("mentorList is $mentorList");
    } else {
      Get.snackbar('Error', 'Failed to fetch data');
    }
  } catch (e) {
    Get.snackbar('Error', e.toString());
  } finally {
    isLoading(false);
  }
}
}