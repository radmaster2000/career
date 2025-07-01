

import 'dart:typed_data';

import 'package:career/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwipableCardStackWidget extends StatefulWidget {
  final List<CardData> cardDataList;

  const SwipableCardStackWidget({Key? key, required this.cardDataList})
      : super(key: key);

  @override
  _SwipableCardStackWidgetState createState() =>
      _SwipableCardStackWidgetState();
}

class _SwipableCardStackWidgetState extends State<SwipableCardStackWidget> {
  int currentIndex = 0;
  PageController _pageController = PageController();
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _animateEntrance();
    });
  }

  void _animateEntrance() async {
    for (int i = 0; i < widget.cardDataList.length; i++) {
      await Future.delayed(const Duration(milliseconds: 300));
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextCard() {
    if (!_isAnimating) {
      _isAnimating = true;
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          currentIndex = (currentIndex + 1) % widget.cardDataList.length;
          _isAnimating = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("mentor List is ${widget.cardDataList}");
    return Column(
      children: [
        SizedBox(
          height: 200.h,
          child: GestureDetector(
            onPanUpdate: (details) {
              if (details.delta.dx > 0) {
                _nextCard();
              }
            },
            child: GestureDetector(
              onTap: () {
                // Navigate to the DetailPage with the selected card data

              },
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.cardDataList.length,
                itemBuilder: (context, index) {
                  return CardItem(
                    cardData: widget.cardDataList[index],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CardItem extends StatelessWidget {
  final CardData cardData;

  const CardItem({Key? key, required this.cardData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5, // Add a touch of depth to your cards
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Rounded corners for elegance
      ),
      color: AppColors.primaryColor, // Customize your card color
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.memory(
                 Uint8List.fromList(cardData.imagePath),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12), // Add some spacing
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cardData.subHeading,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.disabled,
                    fontWeight: FontWeight.bold, // Make it pop!
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  cardData.heading,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White text for contrast
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  cardData.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white70, // Slightly muted text color
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CardData {
  final List <int> imagePath;
  final String subHeading;
  final String heading;
  final String description;

  CardData({
    required this.imagePath,
    required this.subHeading,
    required this.heading,
    required this.description,
  });
}