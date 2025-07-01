import 'package:career/screens/Dashboard/Dashboard.dart';
import 'package:career/screens/Dashboard/dashboardConroller.dart';
import 'package:career/screens/Login.dart';
import 'package:career/screens/SplashScrween.dart';
import 'package:career/screens/liveScreens/liveCourses/liveScreenController.dart';
import 'package:career/screens/loginScreen.dart';
import 'package:career/screens/notes/notes_controller.dart';
import 'package:career/screens/signUpScreen.dart';
import 'package:career/screens/teacher/course_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: "AIzaSyCrjvYKGxyMKEz_GRHTl_FqJeJbttwCnwc", appId: "1:747627310556:android:2dbff9c4e3a52b9cfe7319", messagingSenderId: "747627310556", projectId: "career-launcher-4a0e5")
  );
  Get.lazyPut(() => LiveScreenController());
  Get.lazyPut(() => DashboardController());
  Get.lazyPut(() => CourseController());
  Get.lazyPut(() => NotesController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'LexendMedium',

          ),
          home: child,
        );
      },
      child: SplashScreen(),
    );
  }
}

