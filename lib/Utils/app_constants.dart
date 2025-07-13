import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class AppConstants {

  static const String apiUrl = "https://api.fastforex.io/";
  static const String apiKey = "d077f90f96-cd2f7ffe79-rkbo6l";
  static double mediaHeight(context) => MediaQuery.of(context).size.height;
  static double mediaWidth(context) => MediaQuery.of(context).size.width;
  static const double widgetsCurve = 5;
}
