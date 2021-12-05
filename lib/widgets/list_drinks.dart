// import 'package:login_with_signup/resources/repository.dart';
// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:login_with_signup/models/drink_option.dart';
// import 'package:login_with_signup/Screens/DrinkDetails.dart';
//
// import 'package:login_with_signup/widgets/RandomDrink.dart' as Random;
///NOT NECESSARY
// ///cocktail list screen
// class ListDrinks extends StatefulWidget {
//   final String search;
//   final String title;
//   ListDrinks({Key key, @required this.search, this.title}): super(key: key);
//   _ListDrinksState createState() => _ListDrinksState();
// }
//
// class _ListDrinksState extends State<ListDrinks> {
//
//   int _selectedIndex = 1; ///starts on cocktail icon
//
//   final fieldText = TextEditingController();
// /// deletes what is written in search box
//   void clearText() {
//     fieldText.clear();
//   }
//
//   Future<List<DrinkOption>> _getDrinkOptions() async {
//     return Repository().getDrinkOptions(widget.search);
//   }
//
//   ///change icon in bottom tool bar
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     if(index == 3){ ///change screen depending on index
//       Navigator.push(context,
//         MaterialPageRoute(builder: (_) => Random.DrinkRandom()));
//     }
//   }
//
//   @override
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Container( ///search box
//           width: double.infinity,
//           height: 40,
//           decoration: BoxDecoration(
//               color: Colors.white, borderRadius: BorderRadius.circular(5)),
//           child: Center(
//             child: TextField(
//               decoration: InputDecoration(
//                   prefixIcon: Icon(Icons.search),
//                   suffixIcon: IconButton(
//                     icon: Icon(Icons.clear),
//                     onPressed: clearText,
//                   ),
//                   hintText: 'Search...',
//                   border: InputBorder.none),
//               controller: fieldText,
//             ),
//           ),
//         ),
//       ),
//       body: FutureBuilder<List<DrinkOption>>(
//         future: _getDrinkOptions(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
//           return ListView(
//             children: snapshot.data.map((drink) => ListTile(
//                   leading: CircleAvatar(
//                     backgroundImage: CachedNetworkImageProvider(drink.strDrinkThumb),
//                   ),
//                   title: Text(drink.strDrink),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       PageTransition(
//                         type: PageTransitionType.rightToLeft,
//                         child: DrinkDetails(id: drink.idDrink, drinkName: drink.strDrink,),
//                       ),
//                     );
//                 },
//
//                 ))
//             .toList(),
//           );
//         },
//       ),
//
//       bottomNavigationBar: BottomNavigationBar(
//         selectedFontSize: 20,
//         iconSize: 30,
//         backgroundColor: Colors.blueAccent,
//         selectedIconTheme: IconThemeData(color: Colors.amberAccent, size: 30),
//         selectedItemColor: Colors.amberAccent,
//         type: BottomNavigationBarType.fixed,
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(icon: Icon(Icons.home_filled), title: Text('Home')),
//           BottomNavigationBarItem(icon: Icon(Icons.local_drink), title: Text('Cocktails')),
//           BottomNavigationBarItem(icon: Icon(Icons.favorite), title: Text('Favorites')),
//           BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Account')),
//         ],
//         currentIndex: _selectedIndex, //New
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
