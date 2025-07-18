import 'package:career/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller.dart';
import '../question_model.dart';
import 'option.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key ?key,
    // it means we have to pass this
    @required this.question,
  }) : super(key: key);

  final Question ?question;

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Text(
            question!.question!,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: AppColors.black),
          ),
          SizedBox(height: 20 / 2),
          ...List.generate(
            question!.options!.length,
                (index) => Option(
              index: index,
              text: question!.options![index],
              press: () => _controller.checkAns(question!, index),
            ),
          ),
        ],
      ),
    );
  }
}