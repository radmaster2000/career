import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;
  static late double mediumSizeHorizontal;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    mediumSizeHorizontal=screenWidth/2;

    _safeAreaHorizontal = _mediaQueryData.padding.left +
        _mediaQueryData.padding.right;
    _safeAreaVertical = _mediaQueryData.padding.top +
        _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }

  // Quick access to common media query properties
  static double get screenAspectRatio => _mediaQueryData.size.aspectRatio;
  static double get pixelRatio => _mediaQueryData.devicePixelRatio;
  static bool get isPortrait => _mediaQueryData.orientation == Orientation.portrait;
  static bool get isLandscape => _mediaQueryData.orientation == Orientation.landscape;
  static EdgeInsets get padding => _mediaQueryData.padding;
  static double get textScaleFactor => _mediaQueryData.textScaleFactor;
}
class Responsive {
  // Initialize in your root widget's build method
  static late MediaQueryData _mediaQuery;
  static late double width;
  static late double height;
  static late double blockSize;
  static late double textScaleFactor;

  static void init(BuildContext context) {
    _mediaQuery = MediaQuery.of(context);
    width = _mediaQuery.size.width;
    height = _mediaQuery.size.height;
    blockSize = width / 100;
    textScaleFactor = _mediaQuery.textScaleFactor;
  }

  // Percentage of screen width
  static double wp(double percentage) {
    return width * percentage / 100;
  }

  // Percentage of screen height
  static double hp(double percentage) {
    return height * percentage / 100;
  }

  // Get responsive font size
  static double sp(double fontSize) {
    return fontSize * (width / 3) / 100;
  }

  // Device type detection
  static bool get isMobile => width < 600;
  static bool get isTablet => width >= 600 && width < 1024;
  static bool get isDesktop => width >= 1024;

  // Breakpoint helpers
  static bool get isSmallPhone => width < 375;
  static bool get isMediumPhone => width >= 375 && width < 414;
  static bool get isLargePhone => width >= 414 && width < 600;
  static bool get isSmallTablet => width >= 600 && width < 768;
  static bool get isLargeTablet => width >= 768 && width < 1024;
}
class FontSizes {
  static double get extraSmall => 8.0 * SizeConfig.blockSizeHorizontal;
  static double get small => 14.0 * SizeConfig.blockSizeHorizontal;
  static double get medium => 16.0 * SizeConfig.blockSizeHorizontal;
  static double get large => 18.0 * SizeConfig.blockSizeHorizontal;
  static double get extraLarge => 20.0 * SizeConfig.blockSizeHorizontal;
  static double get headlineSmall => 24.0 * SizeConfig.blockSizeHorizontal;
  static double get headlineMedium => 28.0 * SizeConfig.blockSizeHorizontal;
  static double get headlineLarge => 32.0 * SizeConfig.blockSizeHorizontal;
}
class Spacing {
  static double extraSmall = 2.0;
  static double small = 8.0;
  static double medium = 16.0;
  static double large = 24.0;
  static double extraLarge = 32.0;

  static EdgeInsets get allExtraSmall => EdgeInsets.all(extraSmall * SizeConfig.blockSizeHorizontal);
  static EdgeInsets get allSmall => EdgeInsets.all(small * SizeConfig.blockSizeHorizontal);
  static EdgeInsets get allMedium => EdgeInsets.all(medium * SizeConfig.blockSizeHorizontal);
  static EdgeInsets get allLarge => EdgeInsets.all(large * SizeConfig.blockSizeHorizontal);
  static EdgeInsets get allExtraLarge => EdgeInsets.all(extraLarge * SizeConfig.blockSizeHorizontal);

  static EdgeInsets symmetric({
    double horizontal = 0,
    double vertical = 0,
  }) {
    return EdgeInsets.symmetric(
      horizontal: horizontal * SizeConfig.blockSizeHorizontal,
      vertical: vertical * SizeConfig.blockSizeVertical,
    );
  }
}