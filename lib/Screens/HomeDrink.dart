import 'package:login_with_signup/resources/repository.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:login_with_signup/models/drink_option.dart';
import 'package:login_with_signup/widgets/random_drink.dart';
import 'package:login_with_signup/widgets/list_drinks.dart';

import 'package:login_with_signup/widgets/random_drink.dart' as Random;
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

  int _selectedIndex = 0; ///starts in home
  // static const List<Widget> _pages = <Widget>[
  //   Icon(
  //     Icons.home_filled,
  //   ),
  //   Icon(
  //     Icons.local_drink,
  //   ),
  //   Icon(
  //     Icons.favorite,
  //   ),
  //   Icon(
  //     Icons.person,
  //   ),
  // ];

  Future<List<DrinkOption>> _getDrinkOptions() async {
    return Repository().getDrinkOptions(widget.search);
  }

  ///change icon in bottom tool bar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if(index == 1){ ///change screen depending on index
      Navigator.push(
        context,
        PageTransition(type: PageTransitionType.rightToLeft, child: CocktailDrinks(search: 'c=Cocktail', title: 'Cocktail')),
      );
    }
    else if(index == 2){ ///needs to be changed to Favorites
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => Random.DrinkRandom()));
    }
    else if(index == 3){ ///goes to settings
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => HomeForm()));
    }
  }

  @override

  Widget build(BuildContext context) {
    final title = 'MixDrink';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),

      body: ListView(
          children: <Map<String, String>>[

            {
              'title':'',
              'search':'i=Tequila',
              'image': 'assets/images/Dice.jpg'
            },
            {
              'title':'Cocktail',
              'search': 'c=Cocktail',
              'image': 'assets/cocktail.jpg'
            },
            {
              'title':'Random',
              'image': 'assets/random.jpg'
            },
          ].map((Map<String, String> item) {
            return Center(
              child: GestureDetector(
                onTap: () {
                  if (item['title'] == 'Random') {
                    Navigator.push(
                      context,
                      PageTransition(type: PageTransitionType.rightToLeft, child: DrinkRandom()),
                    );
                  } else {
                    Navigator.push(
                      context,
                      PageTransition(type: PageTransitionType.rightToLeft, child: ListDrinks(search: item['search'], title: item['title'])),
                    );
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      child: Image.asset(item['image'],
                          height: 120,
                          width: 120
                      ),
                      clipBehavior: Clip.antiAlias,
                    ),
                    Text(item['title'],  style: new TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),),
                  ],
                ),
              ),
            );
          }).toList()
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 20,
        iconSize: 30,
        backgroundColor: Colors.blueAccent,
        selectedIconTheme: IconThemeData(color: Colors.amberAccent, size: 30),
        selectedItemColor: Colors.amberAccent,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.local_drink), label: ('Cocktails')),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ('Favorites')),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ('Account')),
        ],
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
      ),
    );
  }
}