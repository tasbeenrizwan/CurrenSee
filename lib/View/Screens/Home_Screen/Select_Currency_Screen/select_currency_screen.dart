import 'package:currency_converter/Logic/controllers/home_controller.dart';
import 'package:currency_converter/Utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'Widgets/search_widget.dart';

class SelectCurrencyScreen extends StatelessWidget {
  SelectCurrencyScreen({Key? key}) : super(key: key);
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BLACK_COLOR,
      appBar: AppBar(
        title: const Text("Select Currency"),
        centerTitle: true,
        backgroundColor: AppColors.Tile_DARK_COLOR,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
            child: SearchTextField(),
          ),
        ),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: homeController.currenciesList.length,
        itemBuilder: (BuildContext context, int index) {
          return Obx(() {
            var country =
                "${homeController.currenciesList[index].currency[0].toLowerCase()}${homeController.currenciesList[index].currency[1].toLowerCase()}";
            if (homeController.searchKey.value.isEmpty) {
              return ListTile(
                onTap: () async {
                  Get.back();
                  if (homeController.firstCountrySelected.value) {
                    homeController.firstCountry.value =
                        homeController.currenciesList[index].country;
                    homeController.firstCurrency.value =
                        homeController.currenciesList[index].currency;
                  }
                  if (homeController.secondCountrySelected.value) {
                    homeController.secondCountry.value =
                        homeController.currenciesList[index].country;
                    homeController.secondCurrency.value =
                        homeController.currenciesList[index].currency;
                  }
                  homeController.firstCountrySelected(false);
                  homeController.secondCountrySelected(false);
                  await homeController.convertCurrencies();
                },
                tileColor: AppColors.BLACK_COLOR,
                leading: SizedBox(
                  height: 30,
                  width: 50,

                  child: SvgPicture.network(
                    "https://flagcdn.com/$country.svg",
                    fit: BoxFit.fill,
                    placeholderBuilder: (BuildContext context){
                      return Image.asset(
                        "assets/images/placeholder.jpg",
                        // fit: BoxFit.cover,
                        height: 30,
                        width: 50,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                title: Text(
                  homeController.currenciesList[index].country,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.WHITE_COLOR,
                  ),
                ),
                trailing: Text(
                  homeController.currenciesList[index].currency,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.WHITE_COLOR,
                  ),
                ),
              );
            } else {
              if (homeController.currenciesList[index].country
                      .toString()
                      .toLowerCase()
                      .startsWith(
                          homeController.searchKey.value.toLowerCase()) ||
                  homeController.currenciesList[index].currency
                      .toString()
                      .toLowerCase()
                      .startsWith(
                          homeController.searchKey.value.toLowerCase())) {
                return ListTile(
                  onTap: () async {
                    Get.back();
                    if (homeController.firstCountrySelected.value) {
                      homeController.firstCountry.value =
                          homeController.currenciesList[index].country;
                      homeController.firstCurrency.value =
                          homeController.currenciesList[index].currency;
                    }
                    if (homeController.secondCountrySelected.value) {
                      homeController.secondCountry.value =
                          homeController.currenciesList[index].country;
                      homeController.secondCurrency.value =
                          homeController.currenciesList[index].currency;
                    }
                    homeController.firstCountrySelected(false);
                    homeController.secondCountrySelected(false);
                    await homeController.convertCurrencies();
                  },
                  tileColor: AppColors.BLACK_COLOR,
                  leading: FadeInImage.assetNetwork(
                    placeholder: "assets/images/placeholder.jpg",
                    // fit: BoxFit.cover,
                    // height: 15,
                    width: 40,
                    fit: BoxFit.cover,
                    image: "https://flagcdn.com/w20/$country.png",
                    imageErrorBuilder: (c, o, s) => Image.asset(
                      "assets/images/placeholder.jpg",
                      // fit: BoxFit.cover,
                      height: 30,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    homeController.currenciesList[index].country,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.WHITE_COLOR,
                    ),
                  ),
                  trailing: Text(
                    homeController.currenciesList[index].currency,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.WHITE_COLOR,
                    ),
                  ),
                );
              }
              return Container();
            }
          });
        },
        // separatorBuilder: (context, index) {
        //   return Divider(
        //     color: AppColors.GREY_COLOR,
        //   );
        // },
      ),
    );
  }
}
