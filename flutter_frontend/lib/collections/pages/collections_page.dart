import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:sax/collections/model/collection.dart';
import 'package:sax/common/common.dart';
import 'package:sax/common/style.dart';
import 'package:sax/products/pages/products_page.dart';

class CollectionsPage extends StatefulWidget {

  @override
  State<CollectionsPage> createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {

  Client client = http.Client();

  @override
  void initState() {
    //getCollections();
    super.initState();
  }

  Future<List<Collection>> fetchCollection() async {
    final response = await http
        .get(Uri.parse(retrievedUrl));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      var responseData = json.decode(response.body);

      List<Collection> collections = [];

      for (var singleCollection in responseData){
          Collection collection = Collection(
              id: singleCollection['id'],
              title: singleCollection['title'],
              image: singleCollection['image'],
              description: singleCollection['description']
          );

          collections.add(collection);
      }

      return collections;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  gotoProductsPage(title, collection){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductsPage(title: title, collection: collection)),
    );
  }

  @override
  Widget build(BuildContext context) {

    // Full screen width and height
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: FutureBuilder(
        builder: (ctx, snapshot) {
          if (snapshot.hasData){

            final data = snapshot.data;

            print("Data"+ data.toString());

            return Container(
              height: height,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/home_background_02.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: height/2,
                      width: width/2,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CachedNetworkImage(imageUrl: data![0].image),
                      ),
                    ),
                    Container(
                      width: width/2,
                      child:  Padding(
                        padding: EdgeInsets.only(left: 72,right: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(data![0].description, textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: colorPrimaryDark,
                                  fontSize: 24
                              ),
                            ),

                            SizedBox(height: 72),
                            ElevatedButton(
                                onPressed: (){
                                  gotoProductsPage("Women Sneakers", data![0].title);
                                },
                                child: Text("Women Sneakers"),
                                style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                                minimumSize: const Size.fromHeight(50), // NEW
                              ),
                            ),
                            SizedBox(height: 8),
                            ElevatedButton(
                                child: Text("Men Sneakers"),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.black,
                                    minimumSize: const Size.fromHeight(50), // NEW
                                ),
                                onPressed: (){
                                  gotoProductsPage("Men Sneakers", data![0].title);
                                },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );





          }

          // Displaying LoadingSpinner to indicate waiting state
          return Center(
            child: CircularProgressIndicator(),
          );
        },

// Future that needs to be resolved
// inorder to display something on the Canvas
        future: fetchCollection(),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
