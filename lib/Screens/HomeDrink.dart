import 'package:mixDrink/resources/repository.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:mixDrink/models/drink_option.dart';
import 'package:mixDrink/Screens/RandomDrink.dart';
import 'Favorites.dart';
import 'HomeForm.dart';
import 'Cocktails.dart';

///cocktail list screen
class HomeDrink extends StatefulWidget {
  final String search;
  final String title;
  HomeDrink({Key key, @required this.search, this.title}): super(key: key);
  _HomeDrinkState createState() => _HomeDrinkState();
}

class _HomeDrinkState extends State<HomeDrink> {

  int _selectedIndex = 0;

  ///starts in home
  Future<List<DrinkOption>> _getDrinkOptions() async {
    return Repository().getDrinkOptions(widget.search);
  }

  ///change icon in bottom tool bar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) {
      ///change screen depending on index
      Navigator.push(
        context,
        PageTransition(type: PageTransitionType.rightToLeft,
            child: CocktailDrinks(search: 'c=Cocktail', title: 'Cocktail')),
      );
    }
    else if (index == 2) {
      ///needs to be changed to Favorites
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => Favorites()));
    }
    else if (index == 3) {
      ///goes to settings
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => HomeForm()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Welcome to MixDrink';

    return Scaffold(
      appBar: AppBar(
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 30.0),
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 40.0),
            ),
            SizedBox(height: 30.0),
            Image.asset('assets/images/mixdrink.png',
              height: 250.0,
              width: 250.0,
            ),
            GestureDetector(
              child: new Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Image.asset('assets/images/Dice.png',
                    height: 150,
                    width: 150
                ),
                clipBehavior: Clip.antiAlias,
              ),
              onTap: () {
                Navigator.push(
                      context,
                      PageTransition(type: PageTransitionType.rightToLeft, child: DrinkRandom()),
                    );
              },
            ),
            Text("Random",  style: new TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),),

          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 20,
        iconSize: 30,
        backgroundColor: Colors.blueAccent,
        selectedIconTheme: IconThemeData(color: Colors.amberAccent, size: 30),
        selectedItemColor: Colors.amberAccent,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled), label: ('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_drink), label: ('Cocktails')),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: ('Favorites')),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ('Account')),
        ],
        currentIndex: _selectedIndex,
        //New
        onTap: _onItemTapped,
      ),
    );
  }
}