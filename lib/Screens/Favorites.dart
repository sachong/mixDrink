
import 'package:mixDrink/models/drink_option.dart';
import 'package:mixDrink/DatabaseHandler/DbHelper.dart';
import 'package:mixDrink/DatabaseHandler/DbHelper.dart';
import 'package:mixDrink/Model/UserModel.dart';
import 'package:mixDrink/resources/repository.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:page_transition/page_transition.dart';
import 'package:mixDrink/models/drink_option.dart';
import 'package:mixDrink/Screens/DrinkDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:mixDrink/widgets/list_drinks.dart';
import 'Cocktails.dart';
import 'HomeForm.dart';
import 'HomeDrink.dart';

///cocktail list screen
class Favorites extends StatefulWidget {
  final String search;
  final String title;
  Favorites({Key key, this.search, this.title}): super(key: key);
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {


  var input = "";

  // TextEditingController fieldText = new TextEditingController();
  String getVal;

  /// deletes what is written in search box
  // void clearText() {
  //   fieldText.clear();
  // }

  Future<List<DrinkOption>> _getDrinkOptions() async {
    List<DrinkOption> temp = new List<DrinkOption>();
    print("test");
    Set<String> drinkNames = new Set();
    UserModel user = UserModel(userId, userName, email, password, '');
    var res = await dbHelper.getFavoriteDrink('sachong');
    // Repository().getDrinkOptions(widget.search);
    // print(res);

    for (var i in res) {
      drinkNames.add(i['drink_name']);
      // print(i['drink_name']);
    }

    print(drinkNames);
    for (var i in drinkNames){
      if(!i.isEmpty){
        print("this is i:");
        print(i);
        var lst = await Repository().getDrink(i);
        print("test3");
        print(lst[0]);
        temp.add(lst[0]);
        print("test");
      }
    }
    for (var i in temp){
      print(i.strDrink);
    }
    return temp;
  }

  int _selectedIndex = 2; ///starts on cocktail icon
  ///change icon in bottom tool bar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if(index == 0){ ///goes to settings
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => HomeDrink()));
    }
    else if(index == 1) {
      ///change screen depending on index
      Navigator.push(
        context,
        PageTransition(type: PageTransitionType.rightToLeft,
            child: CocktailDrinks(search: 'c=Cocktail', title: 'Cocktail')),
      );
    }
    // else if(index == 2) {
    //   ///change screen depending on index
    //   Navigator.push(
    //     context,
    //     PageTransition(type: PageTransitionType.rightToLeft,
    //         child: CocktailDrinks(search: 'c=Cocktail', title: 'Cocktail')),
    //   );
    // }

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

  var userKey;
  var res;


  @override

  void initState() {
    super.initState();
    userKey = getUserData();
    dbHelper = DbHelper();
    getFavDrinks();
    // print(res);
    // fieldText.addListener;
  }

  Future<String> getUserData() async {
    final SharedPreferences sp = await _pref;
    userId = sp.getString("user_id");
    userName = sp.getString("user_name");
    email = sp.getString("email");
    password = sp.getString("password");
    return userId;
  }

  Future<dynamic> getFavDrinks() async{
    UserModel user = UserModel(userId, userName, email, password, '');
    var res = await dbHelper.getFavoriteDrink('sachong');

    // print(res);
    return res;
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
