import 'package:flutter/material.dart';

showDrawer(){
  Drawer(
    child: ListView(
      children: [
        ListTile(
          title: Text("Home"),
        ),
        ListTile(
          title: Text("Catalog"),
        ),
        ListTile(
          title: Text("About"),
        ),
        ListTile(
          title: Text("Account"),
        ),
      ],
    ),
  );
}