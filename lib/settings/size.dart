import 'package:flutter/material.dart';

// Create a utility class for screen dimensions
class ScreenSize {
  static double width = 0;
  static double height = 0;

  static void init(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    width = mediaQuery.size.width;
    height = mediaQuery.size.height;
  }
}
class SizeConfig {
			static late MediaQueryData _mediaQueryData;
			static late double  screenWidth;
			static late double screenHeight;
			static late double blockSizeHorizontal;
			static late double blockSizeVertical;
			
			static late double _safeAreaHorizontal;
			static late double _safeAreaVertical;
			static late double safeBlockHorizontal;
			static late double safeBlockVertical;
			
			void init(BuildContext context) {
				_mediaQueryData = MediaQuery.of(context);
				screenWidth = _mediaQueryData.size.width;
				screenHeight = _mediaQueryData.size.height;
				blockSizeHorizontal = screenWidth / 100;
				blockSizeVertical = screenHeight / 100;
				
				_safeAreaHorizontal = _mediaQueryData.padding.left + 
					_mediaQueryData.padding.right;
				_safeAreaVertical = _mediaQueryData.padding.top +
					_mediaQueryData.padding.bottom;
				safeBlockHorizontal = (screenWidth -
					_safeAreaHorizontal) / 100;
				safeBlockVertical = (screenHeight -
					_safeAreaVertical) / 100;
			}
      static double getBlockSizeHorizontal(double percentage) {
        return blockSizeHorizontal * percentage;
      }
      static double getBlockSizeVertical(double percentage) {
        return blockSizeVertical * percentage;
      }
      static double getSafeBlockSizeHorizontal(double percentage) {
        return safeBlockHorizontal * percentage;
      }
      static double getSafeBlockSizeVertical(double percentage) {
        return safeBlockVertical * percentage;
      }
		}