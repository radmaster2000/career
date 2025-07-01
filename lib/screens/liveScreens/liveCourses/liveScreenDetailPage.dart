import 'dart:typed_data';

import 'package:career/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CourseDetailPage extends StatelessWidget {
  final Color primaryColor = const Color(0xFFF85C70);
  List<int> bytes;
  String courseName;
  String courseId;
  CourseDetailPage({required this.bytes,required this.courseName,required this.courseId});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Column(
        children: [
          // Top Image
          Hero(
            tag: '${courseName}${courseId}',
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius:  BorderRadius.circular(10),
                boxShadow: [
                    BoxShadow(
                      color:AppColors.divider.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                ],
              ),
              child: Image.memory(Uint8List.fromList(bytes)),
            )
          ),

          // Title & Info
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("UI/UX Design", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    Icon(Icons.bookmark_border, color: Colors.pink),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.play_circle_outline, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    const Text("6 lessons"),
                    const SizedBox(width: 16),
                    const Icon(Icons.access_time, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    const Text("10 hours"),
                    const SizedBox(width: 16),
                    const Icon(Icons.star, size: 16, color: Colors.amber),
                    const SizedBox(width: 4),
                    const Text("4.5"),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  "About Course",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: const [
                    Expanded(
                      child: Text(
                        "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to d...",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Text("Show more", style: TextStyle(color: Colors.pink)),
                  ],
                ),
              ],
            ),
          ),

          // Tab Section
          // DefaultTabController(
          //   length: 2,
          //   child: Column(
          //     children: [
          //       const TabBar(
          //         indicatorColor: Colors.pink,
          //         labelColor: Colors.black,
          //         unselectedLabelColor: Colors.grey,
          //         tabs: [
          //           Tab(text: "Lessons"),
          //           Tab(text: "Exercises"),
          //         ],
          //       ),
          //       SizedBox(
          //         height: 170,
          //         child: TabBarView(
          //           children: [
          //             // Lessons List
          //             ListView(
          //               padding: const EdgeInsets.all(16),
          //               children: [
          //                 lessonTile("Introduction to UI/UX Design", "45 minutes", "assets/lesson1.jpg"),
          //                 lessonTile("UI/UX Research", "55 minutes", "assets/lesson2.jpg"),
          //               ],
          //             ),
          //             const Center(child: Text("No Exercises Available")),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          //
          // Spacer and Price Button
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Price\n\$110.00",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Buy Now", style: TextStyle(fontSize: 16)),
                )
              ],
            ),
          )

        ],
      ),
    );
  }

  Widget lessonTile(String title, String duration, String imagePath) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade100,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.schedule, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(duration, style: const TextStyle(color: Colors.grey)),
                  ],
                )
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}