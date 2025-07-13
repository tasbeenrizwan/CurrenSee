import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

import '../../../../Logic/controllers/home_controller.dart';
import '../../../../Routes/routes.dart';
import '../../../../Utils/app_colors.dart';

class TwoCurrenciesWidget extends StatelessWidget {
   TwoCurrenciesWidget({Key? key}) : super(key: key);
  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return EasyRefresh.custom(
      shrinkWrap: true,
      onRefresh: homeController.onRefreshHomePage,
      header: BallPulseHeader(
        color: AppColors.TEAL_COLOR,
        // backgroundColor: AppColors.BLACK_COLOR,
      ),
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              return Obx(
                    () {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: TextButton(
                                onPressed: () {
                                  homeController.firstCountrySelected(true);
                                  Get.toNamed(Routes.selectCurrencyScreen);
                                },
                                style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all(
                                        AppColors.WHITE_COLOR)),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        "${homeController.firstCountry} ${homeController.firstCurrency}",
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ),
                                    // SizedBox(width: 10),
                                    const Expanded(
                                      flex: 1,
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 20,
                                        color: AppColors.Tile_DARK_COLOR,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: TextButton(
                                  style: ButtonStyle(
                                      foregroundColor:
                                      MaterialStateProperty.all(
                                          homeController
                                              .firstValueSelected.value
                                              ? AppColors.TEAL_COLOR
                                              : AppColors.WHITE_COLOR)),
                                  onPressed: () {
                                    homeController.firstValueSelected(true);
                                    homeController.secondValueSelected(false);
                                  },
                                  child: ConditionalBuilder(
                                    condition: !homeController
                                        .firstValueIsLoading.value,
                                    builder: (context) => Text(
                                      homeController
                                          .firstValueController.value.text,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    fallback: (context) => const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: AppColors.WHITE_COLOR,
                                        strokeWidth: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: TextButton(
                                onPressed: () {
                                  homeController.secondCountrySelected(true);
                                  Get.toNamed(Routes.selectCurrencyScreen);
                                },
                                style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all(
                                        AppColors.WHITE_COLOR)),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        "${homeController.secondCountry} ${homeController.secondCurrency}",
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ),
                                    // SizedBox(width: 10),
                                    const Expanded(
                                      flex: 1,
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 20,
                                        color: AppColors.Tile_DARK_COLOR,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: TextButton(
                                  style: ButtonStyle(
                                      foregroundColor:
                                      MaterialStateProperty.all(
                                          homeController
                                              .secondValueSelected.value
                                              ? AppColors.TEAL_COLOR
                                              : AppColors.WHITE_COLOR)),
                                  onPressed: () {
                                    homeController.secondValueSelected(true);
                                    homeController.firstValueSelected(false);
                                  },
                                  child: ConditionalBuilder(
                                    condition: !homeController
                                        .secondValueIsLoading.value,
                                    builder: (context) => Text(
                                      homeController
                                          .secondValueController.value.text,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    fallback: (context) => const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: AppColors.WHITE_COLOR,
                                        strokeWidth: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }
}
