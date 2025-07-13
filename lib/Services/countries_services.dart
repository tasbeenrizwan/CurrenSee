import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../Models/countries_model.dart';
import '../Utils/app_constants.dart';

class HomeServices {
  Future<CountriesModel> getCountries() async {
    var response = await http.get(
      Uri.parse(
          "${AppConstants.apiUrl}currencies?api_key=${AppConstants.apiKey}"),
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (response.statusCode == 200) {
      return countriesModelFromJson(jsonData);
    } else {
      return throw Exception("Failed to load Countries");
    }
  }

  Future convertCurrencies(
      String from, String to, String amount) async {
    var response = await http.get(
      Uri.parse(
          "${AppConstants.apiUrl}convert?from=$from&to=$to&amount=$amount&api_key=${AppConstants.apiKey}"),
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (response.statusCode == 200) {
      return decodedData;
    } else {
      return throw Exception("Failed to load Countries");
    }
  }
}
