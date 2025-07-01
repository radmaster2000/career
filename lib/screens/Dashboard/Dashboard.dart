import 'package:career/screens/courses_screen/mainScreen.dart';
import 'package:career/screens/homeScreen/homeScreen.dart';
import 'package:career/screens/quizScreen/quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../api/api_methods.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';
import '../../utils/custom_paint.dart';
import '../../widgets/navigationbar.dart';
import '../notes/notes.dart';
import '../liveScreens/liveCourses/liveScreen.dart';
import 'dashboardConroller.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {


  int selectBtn = 0;
  int _currentIndex=0;
  final List<Widget> _screens = [
     Livescreen(),    // Screen for "Live" tab
    MainScreen(), // Screen for "Courses" tab
      HomeScreen(),    // Screen for "Home" tab
    QuizScreen(),  // Screen for "Quiz" tab
    Container(
      color: Colors.red,
      child: Text("game screen"),
    ),    // Screen for "Games" tab
  ];

  getData()async{
    print("getdata called");
    //String email=getStringAsync("email")??"anand@gmail.com";
    String email="anand@gmail.com";
   final response=await getProfileData(email);
    if(response.statusCode==200 && response.data["message"]=="Profile retrive successfully"){
      debugPrint("profile data is ${response.data}");
      profileData=response.data['profile'];
          }
  }
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(

        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primary, // Active icon color (red)
        unselectedItemColor: AppColors.disabled, // Inactive icon color (light red)
        elevation: 0.0,
        items: [
          BottomNavigationBarItem(
            label: 'Live',
            icon: Icon(Icons.live_tv), // Color managed by selected/unselected
          ),
          BottomNavigationBarItem(
            label: 'Courses',
            icon: Icon(Icons.book),
          ),
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home), // Color managed by selected/unselected
          ),
          BottomNavigationBarItem(
            label: 'Quiz',
            icon: Icon(Icons.quiz),
          ),
          BottomNavigationBarItem(
            label: 'Games',
            icon: Icon(Icons.games),
          ),
        ],
      ),


      body: _screens[_currentIndex]
    );
  }
  AnimatedContainer navigationBar() {
    return AnimatedContainer(
      height: 70.0,
      duration: const Duration(milliseconds: 400),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(selectBtn == 0 ? 0.0 : 20.0),
          topRight:
          Radius.circular(selectBtn == navBtn.length - 1 ? 0.0 : 20.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < navBtn.length; i++)
            GestureDetector(
              onTap: () => setState(() => selectBtn = i),
              child: iconBtn(i),
            ),
        ],
      ),
    );
  }

  SizedBox iconBtn(int i) {
    bool isActive = selectBtn == i ? true : false;
    var height = isActive ? 60.0 : 0.0;
    var width = isActive ? 50.0 : 0.0;
    return SizedBox(
      width: 75.0,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: AnimatedContainer(
              height: height,
              width: width,
              duration: const Duration(milliseconds: 600),
              child: isActive
                  ? CustomPaint(
                painter: ButtonNotch(),
              )
                  : const SizedBox(),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              navBtn[i].imagePath,
              color: isActive ? AppColors.selectColor : black,
              scale: 2,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              navBtn[i].name,
              //: isActive ? bntText.copyWith(color: AppColors.selectColor) : bntText,
            ),
          )
        ],
      ),
    );
  }

}
class Model {
  final int id;
  final String imagePath;
  final String name;

  Model({
    required this.id,
    required this.imagePath,
    required this.name,
  });
}

List<Model> navBtn = [
  Model(id: 0, imagePath: logo, name: 'Home'),
  Model(id: 1, imagePath: googleImage, name: 'Search'),
  Model(id: 2, imagePath: logo, name: 'Like'),
  Model(id: 3, imagePath: googleImage, name: 'notification'),
  Model(id: 4, imagePath: logo, name: 'Profile'),
];