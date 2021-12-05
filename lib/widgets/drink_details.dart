import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:login_with_signup/models/drink.dart';
import 'package:login_with_signup/resources/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login_with_signup/DatabaseHandler/DbHelper.dart';
import 'package:login_with_signup/Model/UserModel.dart';

///Detailed view of cocktail with instructions and picture
///TO DO ADD INGREDIENTS AND AMOUNT
class DrinkDetails extends StatefulWidget {
  final String id;
  final String drinkName;
  DrinkDetails({Key key, @required this.id, this.drinkName}): super(key: key);
  _DrinkDetailsState createState() => _DrinkDetailsState();
}

class _DrinkDetailsState extends State<DrinkDetails> {


  Future<Drink> _getDrinkDetails() async {
    return Repository().getDrinkDetails(widget.id);
  }

  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  DbHelper dbHelper;
  String userId = '';
  String userName = '';
  String email = '';
  String password = '';

  bool toggle = false;

  @override

  void initState() {
    super.initState();
    getUserData();

    dbHelper = DbHelper();
  }

  Future<void> getUserData() async {
    final SharedPreferences sp = await _pref;
    userId = sp.getString("user_id");
    userName = sp.getString("user_name");
    email = sp.getString("email");
    password = sp.getString("password");
  }

  addToFav(){
    UserModel user = UserModel(userId, userName, email, password, widget.drinkName);
    print(widget.drinkName);
    dbHelper.saveData(user);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.drinkName}'),
      ),
      body: FutureBuilder<Drink>(
        future: _getDrinkDetails(),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: new ClipRRect(
                    borderRadius: new BorderRadius.circular(8.0),
                    child: new CachedNetworkImage(
                        imageUrl: snapshot.data.strDrinkThumb
                    ),
                  ),
                ),
                flex: 4,
              ),
              Expanded(
                child: new SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                    child: new Text(
                      snapshot.data.strInstructions,
                      textAlign: TextAlign.justify,
                      style: new TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                flex: 2,
              ),
              Expanded(
                child: new SingleChildScrollView(
                    child: new Column(
                      children: [
                        for (var i in snapshot.data.ingredientList)
                          new Container(
                            child: i != null ?
                            new Text(
                              i,
                              textAlign: TextAlign.justify,
                              style: new TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ) : new Text(
                              "",
                              textAlign: TextAlign.justify,
                              style: new TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                      ],
                    )
                ),
                flex: 2,
              ),
              Expanded(
                child: new SingleChildScrollView(
                    child: new Column(
                      children: [
                        for (var i in snapshot.data.amountList)
                          new Container(
                            child: i != null ?
                            new Text(
                              i,
                              textAlign: TextAlign.justify,
                              style: new TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ) : new Text(
                              "",
                              textAlign: TextAlign.justify,
                              style: new TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                      ],
                    )
                ),
                flex: 2,
              ),
              IconButton(
                  icon: toggle
                      ? Icon(Icons.favorite)
                      : Icon(
                    Icons.favorite_border,
                  ),
                  onPressed:()  {
                    addToFav();
                    setState(() {
                      // Here we changing the icon.
                      toggle = !toggle;
                    });
                  }
                  ),

            ],
          );
        },
      ),
    );
  }
}