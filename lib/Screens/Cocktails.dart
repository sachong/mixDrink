import 'package:mixDrink/resources/repository.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:page_transition/page_transition.dart';
import 'package:mixDrink/models/drink_option.dart';
import 'package:mixDrink/Screens/DrinkDetails.dart';
//import 'package:login_with_signup/widgets/list_drinks.dart';
import 'Favorites.dart';
import 'HomeForm.dart';
import 'HomeDrink.dart';

///cocktail list screen
class CocktailDrinks extends StatefulWidget {
  final String search;
  final String title;
  CocktailDrinks({Key key, @required this.search, this.title}): super(key: key);
  _CocktailDrinksState createState() => _CocktailDrinksState();
}

class _CocktailDrinksState extends State<CocktailDrinks> {


  var input = "";

  TextEditingController fieldText = new TextEditingController();
  String getVal;

  /// deletes what is written in search box
  void clearText() {
    fieldText.clear();
  }

  Future<List<DrinkOption>> _getDrinkOptions() async {
    // print(widget.search);
    // print(Repository().getDrinkOptions(widget.search));
    return Repository().getDrinkOptions(widget.search);
  }

  int _selectedIndex = 1; ///starts on cocktail icon
  ///change icon in bottom tool bar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if(index == 0){ ///goes to settings
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => HomeDrink()));
    }
    else if(index == 2){ ///goes to Favorites
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => Favorites()));
    }
    else if(index == 3){ ///goes to settings
      Navigator.push(context,
        MaterialPageRoute(builder: (_) => HomeForm()));
    }
  }

  @override

  void initState() {
    super.initState();

    // Start listening to changes.
    fieldText.addListener;
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container( ///search box
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              controller: fieldText,
              onChanged: (text){
                fieldText.value = text as TextEditingValue;
              },
              textInputAction: TextInputAction.go,
              //content: Text(fieldText.text),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: (){
                      setState(() {
                        getVal = fieldText.text;
                      });
                      Navigator.push(
                        context,
                        PageTransition(type: PageTransitionType.rightToLeft, child: CocktailDrinks(search: "i=$getVal", title: "")),
                      );
                    }
                    //clearText,
                  ),
                  hintText: 'Search...',
                  border: InputBorder.none),
            ),
          ),
        ),
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
