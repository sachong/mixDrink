import 'package:login_with_signup/DatabaseHandler/DbHelper.dart';
import 'package:login_with_signup/Model/UserModel.dart';
import 'package:login_with_signup/resources/repository.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:page_transition/page_transition.dart';
import 'package:login_with_signup/models/drink_option.dart';
import 'package:login_with_signup/widgets/drink_details.dart';
import 'package:login_with_signup/widgets/list_drinks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Cocktails.dart';
import 'HomeForm.dart';
import 'HomeDrink.dart';
import 'package:login_with_signup/widgets/random_drink.dart' as Random;

///cocktail list screen
class Favorites extends StatefulWidget {
  final String search;
  final String title;
  final String id;
  final String drinkName;
  Favorites({Key key, @required this.search, this.title, this.id, this.drinkName}): super(key: key);
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {

  int _selectedIndex = 2; ///starts on cocktail icon
  var input = "";

  TextEditingController fieldText = new TextEditingController();
  String getVal;

  /// deletes what is written in search box
  void clearText() {
    fieldText.clear();
  }

  Future<List<DrinkOption>> _getDrinkOptions() async {
    return Repository().getDrinkOptions(widget.search);
  }

  ///change icon in bottom tool bar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if(index == 0){ ///goes to settings
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => HomeDrink()));
    }
    else if(index == 1){ ///change screen depending on index
      Navigator.push(
        context,
        PageTransition(type: PageTransitionType.rightToLeft, child: CocktailDrinks(search: 'c=Cocktail', title: 'Cocktail')),
      );
    }
    else if(index == 3){ ///goes to settings
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => HomeForm()));
    }
  }

  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  DbHelper dbHelper;
  String userId = '';
  String userName = '';
  String email = '';
  String password = '';
  UserModel userModel;


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

  Future<void> getFavDrinks() async{
    await dbHelper.getLoginUser(userId, password).then((userData) {
      if (userData != null) {
        userModel = userData;
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: FutureBuilder<List<DrinkOption>>(
        future: _getDrinkOptions(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          return ListView(
            children: snapshot.data.map((drink) => ListTile(
              leading: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(drink.strDrinkThumb),
              ),
              title: Text(drink.strDrink),
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    //child: DrinkDetails(id: drink.idDrink, drinkName: drink.strDrink,),
                    child: DrinkDetails(id: drink.idDrink, drinkName: drink.strDrink,),
                  ),
                );
              },

            ))
                .toList(),
          );
        },
      ),

      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 20,
        iconSize: 30,
        backgroundColor: Colors.blueAccent,
        selectedIconTheme: IconThemeData(color: Colors.amberAccent, size: 30),
        selectedItemColor: Colors.amberAccent,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.local_drink), title: Text('Cocktails')),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), title: Text('Favorites')),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Account')),
        ],
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
      ),
    );
  }
}
