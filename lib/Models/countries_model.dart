// To parse this JSON data, do
//
//     final countriesModel = countriesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CountriesModel countriesModelFromJson(String str) => CountriesModel.fromJson(json.decode(str));

String countriesModelToJson(CountriesModel data) => json.encode(data.toJson());

class CountriesModel {
  CountriesModel({
     this.currencies,
     this.ms,
  });

  Map<String, String>? currencies;
  int? ms;

  factory CountriesModel.fromJson(Map<String, dynamic> json) => CountriesModel(
    currencies: Map.from(json["currencies"]).map((k, v) => MapEntry<String, String>(k, v)),
    ms: json["ms"],
  );

  Map<String, dynamic> toJson() => {
    "currencies": Map.from(currencies!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "ms": ms,
  };
}

class Currencies {
  String currency;
  String country;

  Currencies(this.currency, this.country);

  @override
  String toString() {
    return '[{ ${this.currency}, ${this.country} }]';
  }
}
