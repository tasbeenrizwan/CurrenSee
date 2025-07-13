import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:currency_converter/Logic/controllers/home_controller.dart';
import 'package:currency_converter/Routes/routes.dart';
import 'package:currency_converter/Utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'Widgets/keyboard.dart';
import 'Widgets/two_currencies_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.BLACK_COLOR,
        appBar: AppBar(
          backgroundColor: AppColors.Tile_DARK_COLOR,
          title: const Text("Exchange Rate"),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: TwoCurrenciesWidget()),
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Data provided by fastforex.io, updated on ",
                  style:  TextStyle(
                    color: AppColors.GREY_COLOR,
                    fontSize: 10,
                  ),
                ),

                Text(
                  "${DateFormat('yyyy-MM-dd – hh:mm a').format(homeController.updatedDate.value)}",
                  style:  TextStyle(
                      color: AppColors.GREY_COLOR,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis
                  ),
                ),
              ],
            ),),
            const   SizedBox(height: 10),
            Expanded(
              child: CustomKeyboardScreen(),
            )
          ],
        ));
  }
}
