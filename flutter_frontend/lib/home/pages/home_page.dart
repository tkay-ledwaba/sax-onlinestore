
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:sax/common/style.dart';
import '../../collections/model/collection.dart';
import '../../common/common.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Client client = http.Client();
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

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: height/2,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/home_banner_01.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Padding(
              padding: EdgeInsets.only(top: 4, left: 16, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Best Selling",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                ),
                ElevatedButton(
                    onPressed: (){},
                    child: Text("View All"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black, // NEW
                  ),
                )
              ],
            )
          )



        ],
      ),

    );
  }
}

// Page Two
class PageTwo extends StatelessWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        color: Colors.green,
        child: const Text(
          'Green Page',
          style: TextStyle(fontSize: 50, color: Colors.white),
        ));
  }
}

// Page Three
class PageThree extends StatelessWidget {
  const PageThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        color: Colors.blue,
        child: const Text(
          'Blue Page',
          style: TextStyle(fontSize: 50, color: Colors.white),
        ));
  }
}