import 'package:flutter/material.dart';
import 'package:sax/collections/pages/collections_page.dart';
import 'package:sax/home/pages/home_page.dart';
import 'package:sax/main.dart';

import '../common/style.dart';

CustomAppbar(context){
  return AppBar(
    elevation: 0,
    backgroundColor: colorPrimary,
    foregroundColor: colorPrimaryDark,

    title: TextButton(
      onPressed: () {
          Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => ControllerPage()),
          );
        },
    child:Text("S A X",
      textAlign: TextAlign.left,
      style: TextStyle(
          fontSize: 24,
          color: colorPrimaryDark,
          fontWeight: FontWeight.bold
      ),
    ),),
    centerTitle: true,
    actions: [
      Padding(
        padding: EdgeInsets.only(right: 8),
        child: Icon(Icons.search),
      ),
      Padding(
        padding: EdgeInsets.only(right: 8),
        child: Icon(Icons.shopping_bag_outlined),
      ),
    ],
  );
}