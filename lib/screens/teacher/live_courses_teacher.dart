import 'package:career/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../dummy/categoriesDummy.dart';
import '../../dummy/videoCoursesDummy.dart';
import '../../widgets/subheader.dart';
import '../../widgets/videocousecard.dart';
import '../liveScreens/liveCourses/course_model.dart';
import '../liveScreens/liveCourses/liveScreenController.dart';
import '../util_classes/videoCourses.dart';
import 'course_edit.dart';

class TeacherLiveCourses extends StatefulWidget {
  const TeacherLiveCourses({super.key});

  @override
  State<TeacherLiveCourses> createState() => _TeacherLiveCoursesState();
}

class _TeacherLiveCoursesState extends State<TeacherLiveCourses> {
  final LiveScreenController liveController = Get.find();
  final popularCourses = <VideoCourse>[];
  final categories = <Category>[];
  final newCourses = <VideoCourse>[];
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
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddCoursePage(),));
        },
        backgroundColor: AppColors.primary,
        child: Icon(Icons.add,color: AppColors.white,),
      ),
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
                onPressed: () {},
                item: item,
                isTeacher: true,
              ),
            )
                .toList(),
          ),)
        ],
      ),
    );
  }
}