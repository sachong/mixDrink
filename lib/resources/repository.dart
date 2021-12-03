import 'dart:async';

import 'package:login_with_signup/resources/drink_api_provider.dart';
import 'package:login_with_signup/models/drink.dart';
import 'package:login_with_signup/models/drink_option.dart';

class Repository {

  final drinkApiProvider = DrinkApiProvider();

  Future<List<DrinkOption>> getDrinkOptions(String search){
    return drinkApiProvider.getDrinkOptions(search);
  }

  Future<Drink> getDrinkDetails(String id) {
    return drinkApiProvider.getDrinkDetails(id);
  }

  Future<Drink> getDrinkRandom() {
    return drinkApiProvider.getDrinkRandom();
  }

}