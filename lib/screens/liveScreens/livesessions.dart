import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../dummy/categoriesDummy.dart';
import '../../dummy/videoCoursesDummy.dart';
import '../../widgets/subheader.dart';
import '../../widgets/videocousecard.dart';
import '../util_classes/videoCourses.dart';
import 'liveCourses/course_model.dart';
import 'liveCourses/liveScreenController.dart';
import 'liveCourses/liveScreenDetailPage.dart';

class LiveSessions extends StatefulWidget {
  const LiveSessions({super.key});

  @override
  State<LiveSessions> createState() => _LiveSessionsState();
}

class _LiveSessionsState extends State<LiveSessions> {
  final LiveScreenController liveController = Get.find();
  final categories = <Category>[];
  final newCourses = <VideoCourse>[];
  final popularCourses = <VideoCourse>[];
  Future<void> loadData() async {
    final now = DateTime.now();
     final categories = categoriesJSON.map((e) => Category.fromJson(e));
     final courses = videoCoursesJSON.map((e) => VideoCourse.fromJson(e));
    final newCourses = courses.where((e) => now.difference(e.createdAt).inDays < 17);
    final popularCourses = courses.where((e) => e.countStudents > 17000);

    this.categories
      ..clear()
      ..addAll(categories);
    this.newCourses
      ..clear()
      ..addAll(newCourses);
    this.popularCourses
      ..clear()
      ..addAll(popularCourses);
    print("popular course ${popularCourses.first.imageUrl}");
  }


  @override
  void initState() {
    // TODO: implement initState
    loadData();
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body: SingleChildScrollView(
    child: Column(
      children: [
        _PopularCoursesListView(
          popularCourses: liveController.productList,
        ),
      ],
    ),
  ),
    );
  }
}
class _PopularCoursesListView extends StatelessWidget {
  const _PopularCoursesListView({
    required this.popularCourses,
  });

  final List<Courses> popularCourses;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 23),
      child: Column(
        children: [
          SubHeader(
            title: 'Live Courses',
            onPressed: () {},
          ),
          const SizedBox(height: 20),
          Obx(() => ListView(
            primary: false,
            shrinkWrap: true,
            children: popularCourses
                .map(
                  (item) => VideoCourseCard(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CourseDetailPage(
                    bytes: item.course_image.data,
                    courseId: item.id,
                    courseName: item.course_name,

                  ),));
                },
                item: item,
                isTeacher: false,
              ),
            )
                .toList(),
          ),)
        ],
      ),
    );
  }
}