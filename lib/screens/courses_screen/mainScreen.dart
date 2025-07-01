import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import '../notes/notes.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  final _selectedColor = AppColors.primary;
  final _unselectedColor = Color(0xff5f6368);
  List tabViews=[
    Notes(),
    Container(
      child: Text("Books"),
    )
  ];
  final _tabs = [
    Tab(text: 'Notes'),
    Tab(text: 'Books'),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
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
                  insets: EdgeInsets.symmetric(horizontal: 80.w)),
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
