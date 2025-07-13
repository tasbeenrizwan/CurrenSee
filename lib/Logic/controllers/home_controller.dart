import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Models/countries_model.dart';
import '../../Services/countries_services.dart';
import '../../Utils/local_storage/local_storage.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  var firstValueIsLoading = false.obs;
  var secondValueIsLoading = false.obs;

  var currenciesList = <Currencies>[].obs;
  var firstCountry = 'Kuwait dinar'.obs;
  var firstCurrency = 'KWD'.obs;
  var secondCountry = 'Egyptian Pound'.obs;
  var secondCurrency = 'EGP'.obs;

  var firstValueController = TextEditingController().obs;
  var secondValueController = TextEditingController().obs;

  var firstCountrySelected = false.obs;
  var secondCountrySelected = false.obs;
  var firstValueSelected = true.obs;
  var secondValueSelected = false.obs;


  var updatedDate = DateTime.now().obs;

  @override
  void onInit() async {
    firstValueController.value.text = '1';
    await getCountries();
    await convertCurrencies();
    amount.value = '';
    super.onInit();
  }

  Future<void> onRefreshHomePage() async {
    await Future.delayed(const Duration(seconds: 1), () {
      convertCurrencies();
    });
  }

  getCountries() async {
    try {
      var countries = await HomeServices().getCountries();
      isLoading(true);
      if (countries.currencies!.isNotEmpty) {
        countries.currencies!
            .forEach((k, v) => currenciesList.add(Currencies(k, v)));
        print("${currenciesList.toString()}");
      }
    } finally {
      isLoading(false);
    }
  }

  convertCurrencies() async {
    try {
      if (firstValueSelected.value) {
        secondValueIsLoading(true);
      }
      if (secondValueSelected.value) {
        firstValueIsLoading(true);
      }
      var convert = await HomeServices().convertCurrencies(
          firstValueSelected.value ? firstCurrency.value : secondCurrency.value,
          firstValueSelected.value ? secondCurrency.value : firstCurrency.value,
          firstValueSelected.value
              ? firstValueController.value.text
              : secondValueController.value.text);
      isLoading(true);
      print("${convert}");
      if (firstValueSelected.value) {
        secondValueController.value.text =
            convert["result"][secondCurrency.value].toString();
        print("result 1 --> ${secondValueController.value.text}");
      }
      if (secondValueSelected.value) {
        firstValueController.value.text =
            convert["result"][firstCurrency.value].toString();
        print("result 2 --> ${firstValueController.value.text}");
      }
    } finally {
      isLoading(false);
      firstValueIsLoading(false);
      secondValueIsLoading(false);
      searchKey.value = '';
      updatedDate.value = DateTime.now();
    }
  }

  final keys = [
    ['1', '2', '3', 'C'],
    ['4', '5', '6', ''],
    ['7', '8', '9', ''],
    ['00', '0', ".", 'R'],
  ];
  var amount = ''.obs;

  onNumberPress(val) {
    if (val == '0' && amount.value.length == 1&&amount.value.contains("0")) {
      return;
    }
    if (val == '.' && amount.value.contains(".")) {
      return;
    }
    amount.value = amount.value + val;
    if (firstValueSelected.value) {
      firstValueController.value.clear();
      firstValueController.value.text = amount.value;
    } else {
      secondValueController.value.clear();
      secondValueController.value.text = amount.value;
    }
    convertCurrencies();
    if (kDebugMode) {
      print(amount.value);
    }
  }

  onBackspacePress() {
    try {
      firstValueIsLoading(true);
      secondValueIsLoading(true);
      if (amount.value.length == 1) {
        amount.value = '';
        firstValueController.value.text = "0";
        secondValueController.value.text = "0";
      }
      amount.value = amount.value.substring(0, amount.value.length - 1);
      if (firstValueSelected.value) {
        firstValueController.value.clear();
        firstValueController.value.text = amount.value;
      } else {
        secondValueController.value.clear();
        secondValueController.value.text = amount.value;
      }
      convertCurrencies();
      if (kDebugMode) {
        print(amount.value);
      }
    } finally {
      firstValueIsLoading(false);
      secondValueIsLoading(false);
    }
  }

  onClearPress() {
    try {
      firstValueIsLoading(true);
      secondValueIsLoading(true);
      amount.value = '';
      firstValueController.value.text = "0";
      secondValueController.value.text = "0";
      if (kDebugMode) {
        print("amount --> ${amount.value}");
        print("firstValueController --> ${firstValueController.value.text}");
        print("secondValueController --> ${secondValueController.value.text}");
      }
    } finally {
      firstValueIsLoading(false);
      secondValueIsLoading(false);
    }
  }

  var searchKey = ''.obs;
}
