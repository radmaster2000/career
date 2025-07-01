import 'package:career/screens/quizScreen/quiz/quiz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _selectedColor = AppColors.primary;
  final _unselectedColor = Color(0xff5f6368);
  List tabViews=[
    //LiveSessions(),
    Quiz(),
    Container(
      child: Text("Games"),
    )
  ];
  final _tabs = [
    Tab(text: 'Quiz'),
    Tab(text: 'Tests'),
  ];
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize:Size.fromHeight(20) ,
          child: Container(
            height: kToolbarHeight - 8.0,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: TabBar(
              controller: _tabController,
              onTap: (value) {
                setState(() {

                });
              },
              //isScrollable: true,
              indicator: UnderlineTabIndicator(
    borderSide: BorderSide(
    width: 3.w,  // Thickness of the underline
    color: _selectedColor,
    ),
    insets: EdgeInsets.symmetric(horizontal: 50.w)),
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.black,
              tabs: _tabs,
            ),
          ),
        ),
      ),
      body:tabViews[_tabController.index] ,
    );
  }
}
