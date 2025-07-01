import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:career/utils/app_colors.dart';
import 'package:career/widgets/userInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:transparent_image/transparent_image.dart';

import '../screens/liveScreens/liveCourses/course_model.dart';
import '../screens/teacher/course_edit.dart';
import '../screens/util_classes/videoCourses.dart';
import '../utils/app_images.dart';
import '../utils/app_size.dart';
import 'dotcontainer.dart';
import 'package:image/image.dart' as img;

class VideoCourseCard extends StatefulWidget {
  final Courses item;
  final VoidCallback onPressed;
  final bool ?isTeacher;

  const VideoCourseCard({
    super.key,
    required this.item,
    required this.onPressed,
    required this.isTeacher
  });

  @override
  State<VideoCourseCard> createState() => _VideoCourseCardState();
}

class _VideoCourseCardState extends State<VideoCourseCard> {

  Widget _buildErrorWidget(double height, double width) => Container(
    width: width,
    height: height,
    color: Colors.grey[300],
    child: const Icon(Icons.broken_image),
  );


  Widget imageShow(Uint8List imageData){
    if (imageData == null || imageData!.isEmpty) {
      return _buildPlaceholder();
    }

    return Image.memory(
      imageData!,
      width: 100,
      height: 100,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return _buildPlaceholder();
      },
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (frame == null) {
          return _buildPlaceholder();
        }
        return child;
      },
    );
  }
  Widget _buildPlaceholder() {
    return Container(
        width: 100,
        height: 100,
        color: Colors.grey[300],
        child: const Icon(Icons.broken_image),
    );
  }

  @override
  Widget build(BuildContext context) {
    const radius = 20.0;
     print("item imageurl is ${widget.item.course_image.data}");
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: () => widget.onPressed(),
        borderRadius: BorderRadius.circular(radius),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radius),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300]!,
                blurRadius: 3,
              ),
            ],
          ),
          child: Stack(
            children: [Column(
              children: [
                Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors:[
                      AppColors.disabled,
                      Colors.transparent
                    ])
                  ),
                  //width: context.,
                  // child: CachedNetworkImage(
                  //   imageUrl: widget.item.imageUrl,
                  //   errorWidget: (context, url, error) => const SizedBox(),
                  //   imageBuilder: (context, assetProvider) {
                  //     return ClipRRect(
                  //       borderRadius: const BorderRadius.vertical(top: Radius.circular(radius)),
                  //       child: FadeInImage(
                  //         placeholder: AssetImage(widget.item.imageUrl),
                  //         image: assetProvider,
                  //         fit: BoxFit.cover,
                  //       ),
                  //     );
                  //   },
                  // ),
                  child: imageShow(Uint8List.fromList(widget.item.course_image.data!))
                ),
                Padding(
                  padding: const EdgeInsets.all(17.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.item.course_name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle(fontSize: 20, height: 1.2),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Flexible(
                            child: UserInfo(
                              onPressed: () {},
                              expanded: false,
                              title: widget.item.mentor.name,
                              avatarURL: Uint8List.fromList(widget.item.mentor.profile_picture.data!),
                            ),
                          ),
                          const DotContainer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Text(widget.item.course_price.toString(), style: TextStyle(fontSize: 15, height: 1.2)),
                          ),
                          const DotContainer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Text(
                              "${widget.item.class_duration_time}",
                              style: TextStyle(fontSize: 15, height: 1.2),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
              if(widget.isTeacher!)Positioned(
                  top: 1,
                  right: 1,
                  child: IconButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddCoursePage(),));
                  }, icon: Icon(Icons.more_vert_sharp))),
              if(!widget.isTeacher!)Positioned(
                top: 100 - (Responsive.height * 0.1)/2,
                left: 0,
                right: 0,
                child: Image.asset(play,height: Responsive.height*0.1,))],
          ),
        ),
      ),
    );
  }
}
