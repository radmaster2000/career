import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../utils/app_images.dart';
import '../../widgets/navigationbar.dart';
import '../../widgets/swipable_card.dart';
import '../Dashboard/dashboardConroller.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final  DashboardController dashBoardController = Get.find();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          _scaffoldKey.currentState?.openDrawer();
        }, icon: Icon(Icons.sort)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 20.h,
              backgroundImage: AssetImage(appProfileImg),
            ),
          )
        ],
      ),
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Back Header
            _buildWelcomeHeader(),
            SizedBox(height: 20),

            // Search Bar
            // _buildSearchBar(),
             SizedBox(height: 15.h),

            // Subjects Row
            Text('Enrolled Courses', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 15.h),
            SizedBox(
              height: 100.h,
              child: _buildSubjectChips(),
            ),
            SizedBox(height: 30),

            // Live Classes Section
            // Text('Performance Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            // SizedBox(height: 15),
            _buildLiveClassCard(
              title: 'Performance',
              instructor: 'Rikhav Sharma',
            ),
            SizedBox(height: 15.h),
            // _buildLiveClassCard(
            //   title: 'Virus Pandemic: Things you should know from History',
            //   instructor: 'Sweta Joshi',
            // ),
            //SizedBox(height: 15),
            // _buildLiveClassCard(
            //   title: 'Economics Reform',
            //   instructor: 'Rikhav Sr',
            // ),
            Text('Meet the Mentor', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 15.h),
            Obx(() => SwipableCardStackWidget(
                cardDataList: dashBoardController.mentorList.map((item) => CardData(
                  description:item.bio,
                  heading: item.email,
                  imagePath: item.profile_picture!.data,
                  subHeading: item.name,
                )).toList()


              // [
              //   CardData(
              //       imagePath: pic3,
              //       subHeading: 'UI UX Designer',
              //       heading: 'Keol Risen',
              //       description: '5 Years of Experience'),
              //   CardData(
              //       imagePath: pic2,
              //       subHeading: 'Penetration Expert',
              //       heading: 'Perter Panter',
              //       description: '3 Years of Experience'),
              //   CardData(
              //       imagePath: pic1,
              //       subHeading: 'Professional Photographer',
              //       heading: 'Tommy Styles',
              //       description: '2 Years of Experience'),
              //   CardData(
              //       imagePath: pic2,
              //       subHeading: 'Graphics Designer',
              //       heading: 'Kenny Parse',
              //       description: '3 Years of Experience'),
              //   CardData(
              //       imagePath: pic3,
              //       subHeading: 'React Developer',
              //       heading: 'Harry Parker',
              //       description: '3 Years of Experience'),
              //   CardData(
              //       imagePath: pic1,
              //       subHeading: 'Mongo-DB Expert',
              //       heading: 'Deneal Parker',
              //       description: '6 Years of Experience'),
              //   CardData(
              //       imagePath: pic2,
              //       subHeading: 'UI UX Designer',
              //       heading: 'Zore Kaido',
              //       description: '4 Years of Experience'),
              // ],
            ),)
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Welcome back,', style: TextStyle(fontSize: 16, color: Colors.grey)),
        Row(
          children: [
            Text('Partho Parekh', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),

          ],
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
      BoxShadow(
      color: Colors.grey.withOpacity(0.2),
      spreadRadius: 2,
      blurRadius: 5,
      offset: Offset(0, 3),
      )],
    ),
    child: TextField(
    decoration: InputDecoration(
    hintText: 'Q Search here',
    prefixIcon: Icon(Icons.search, color: Colors.grey),
    border: InputBorder.none,
    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
    ),
    ),
    );
  }

  Widget _buildSubjectChips() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
      return Container(
        height: 60.h,
          width: 90.w,
          margin: EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
      //color: Colors.red,
      borderRadius: BorderRadius.circular(20),
      image: DecorationImage(
        image: AssetImage(course)
      ),
      // // boxShadow: [
      // // BoxShadow(
      // // color: Colors.grey.withOpacity(0.3),
      // // blurRadius: 5,
      // // offset: Offset(0, 2),
      // // ),
      // ],
        
      ),
        //child: Image.asset(course),
      );
    },);
  }
  Widget _buildProgressCard(String title, String value, Color color) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Text(title),
              CircularPercentIndicator(radius: 30, percent: 0.75, progressColor: color),
              Text(value),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildLiveClassCard({required String title, required String instructor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 16),

        // Progress Summary (Row of Cards)
        Row(
          children: [
            _buildProgressCard("Completion", "75%", Colors.blue),
            _buildProgressCard("Avg. Score", "82%", Colors.green),
          ],
        ),

        // Time Spent Chart
        SizedBox(height: 20),
        //Text("Weekly Study Time", style: TextStyle(fontWeight: FontWeight.w500)),
        //Container(height: 150, child: BarChart(...)), // Replace with actual chart

        // Streak & Badges
        // SizedBox(height: 20),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     _buildStreakWidget(),
        //     _buildBadgeGrid(),
        //   ],
        // ),
      ],
    );
  }
}