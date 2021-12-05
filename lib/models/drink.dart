/// A drink
class Drink {

  String strDrink;
  String strDrinkThumb;
  String idDrink;
  String strInstructions;
  List<String> ingredientList = [];
  List<String> amountList = [];

  Drink({
    this.strDrink,
    this.strDrinkThumb,
    this.idDrink,
    this.strInstructions,
    this.ingredientList,
    this.amountList
  });

  Future<List<String>> getIngredient()async{
    List<String> temp = [];
    temp.add("ingredient1");
    temp.add("ingredient2");
    return temp;
  }

  factory Drink.fromJson(Map<String, dynamic> json) {
    // List<String> l = getIngredient();
    return Drink(
      strDrink: json['drinks'][0]['strDrink'],
      strDrinkThumb: json['drinks'][0]['strDrinkThumb'],
      idDrink: json['drinks'][0]['idDrink'],
      strInstructions: json['drinks'][0]['strInstructions'],
      ingredientList: [json['drinks'][0]['strIngredient1'], json['drinks'][0]['strIngredient2'],
        json['drinks'][0]['strIngredient3'], json['drinks'][0]['strIngredient4'], json['drinks'][0]['strIngredient5']
      ],
      // ingredientList: [json['drinks'][0]['strMeasure1']  + json['drinks'][0]['strIngredient1'],
      //   json['drinks'][0]['strMeasure2']  + json['drinks'][0]['strIngredient2'],
      //   json['drinks'][0]['strMeasure3']  + json['drinks'][0]['strIngredient3'],
      //   // json['drinks'][0]['strMeasure4']   + json['drinks'][0]['strIngredient4'],
      //   // json['drinks'][0]['strMeasure5']   + json['drinks'][0]['strIngredient5']
      // ],
      amountList: [json['drinks'][0]['strMeasure1'],json['drinks'][0]['strMeasure2'],json['drinks'][0]['strMeasure3'],
        json['drinks'][0]['strMeasure4'],json['drinks'][0]['strMeasure5']],
    );
  }

}