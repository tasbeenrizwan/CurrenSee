import 'package:currency_converter/Logic/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Utils/app_colors.dart';


class SearchTextField extends StatelessWidget {
  SearchTextField({Key? key}) : super(key: key);
  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      cursorColor: AppColors.MAIN_COLOR,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
          fillColor: AppColors.WHITE_COLOR,
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10)),
          hintText: 'Search',
          suffixIcon:  Icon(
            Icons.search,
            color: AppColors.GREY_COLOR,
          ),
          hintStyle:  TextStyle(
              color: AppColors.GREY_COLOR, fontSize: 13)),
      onChanged: (val) {
        homeController.searchKey.value = val;
      },
    );
  }
}
