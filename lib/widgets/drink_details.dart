import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:login_with_signup/models/drink.dart';
import 'package:login_with_signup/resources/repository.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.drinkName}'),
      ),
      body: FutureBuilder<Drink>(
        future: _getDrinkDetails(),
        builder: (context, snapshot) {
          //var ingredients = [[snapshot.data.ingredientList[0]], [snapshot.data.ingredientList[1]], [snapshot.data.ingredientList[2]]];
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
                flex: 3,
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
                //flex: 3,
              ),
              Expanded(
                child: new SingleChildScrollView(
                  child: new Column(
                    children: [
                      new Container(
                        child: new Text(
                          snapshot.data.ingredientList[0],
                          textAlign: TextAlign.justify,
                          style: new TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),

                      ),
                      new Container(

                        child: snapshot.data.ingredientList[1] != null ?
                        new Text(
                          snapshot.data.ingredientList[1],
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
                      new Container(
                        child: snapshot.data.ingredientList[2] != null ?
                        new Text(
                          snapshot.data.ingredientList[2],
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
                flex: 3,
              ),
            ],
          );
        },
      ),
    );
  }
}