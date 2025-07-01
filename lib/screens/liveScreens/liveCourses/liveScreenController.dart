import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../api/api_methods.dart';
import '../../../models/course.dart';
import 'course_model.dart';

class LiveScreenController extends GetxController {
var isLoading = false.obs;
var productList = RxList<Courses>();

@override
void onInit() {
  fetchCourses();
  super.onInit();
}

Future<void> fetchCourses() async {
  print("course fetching");
  try {
    isLoading(true);
    final response = await getLiveCoursesData();

    if (response.statusCode == 200) {
      List<dynamic> jsonData = response.data["courses"];
      print("course getting $response");
      for (final item in jsonData) {
        try {
          if (item != null && item is Map<String, dynamic>) {
            productList.add(Courses.fromJson(item));
          } else {
            print("Skipping invalid item: $item");
          }
        } catch (e) {
          print("Error parsing item $item: $e");
        }
      }// Fallback to empty list if null
      print("productList is $productList");
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