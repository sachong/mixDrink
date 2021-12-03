class DrinkOption {

  String strDrink;
  String strDrinkThumb;
  String idDrink;
  List<String> ingredientList = [];
  List<String> amountList = [];

  DrinkOption({
    this.strDrink,
    this.strDrinkThumb,
    this.idDrink,
    this.ingredientList,
    this.amountList
  });

  factory DrinkOption.fromJson(Map<String, dynamic> json) {
    return DrinkOption(
      strDrink: json['strDrink'],
      strDrinkThumb: json['strDrinkThumb'],
      idDrink: json['idDrink'],
    );
  }

}