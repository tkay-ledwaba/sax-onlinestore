import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:sax/common/style.dart';
import 'package:sax/home/pages/home_page.dart';
import 'package:sax/widgets/drawer.dart';

import 'collections/pages/collections_page.dart';
import 'widgets/custom_appbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SAX Official Site',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: ControllerPage(),
    );
  }
}

class ControllerPage extends StatefulWidget {
  const ControllerPage({Key? key}) : super(key: key);

  @override
  State<ControllerPage> createState() => _ControllerPageState();
}


final scaffoldKey = GlobalKey<ScaffoldState>();

class _ControllerPageState extends State<ControllerPage> {
  // declare and initialize the page controller
  final PageController _pageController = PageController(initialPage: 0);

  // the index of the current page
  int _activePage = 0;

  // this list holds all the pages
  // all of them are constructed in the very end of this file for readability
  final List<Widget> _pages = [
    HomePage(),
    CollectionsPage(),
    const PageThree()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(context),
      body: Stack(
        children: [
          // the page view
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _activePage = page;
              });
            },
            itemCount: _pages.length,
            itemBuilder: (BuildContext context, int index) {
              return _pages[index % _pages.length];
            },
          ),

        ],
      ),
      bottomSheet: Container(
        height: 32,
        width: double.infinity,
        color: colorPrimaryDark,
        child: Column(
          children: [
            SizedBox(height: 8),
            Container(
              color: Colors.black54,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                    _pages.length,
                        (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: () {
                          _pageController.animateToPage(index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        },
                        child: CircleAvatar(
                          radius: 8,
                          // check if a dot is connected to the current page
                          // if true, give it a different color
                          backgroundColor: _activePage == index
                              ? colorPrimary
                              : Colors.grey,
                        ),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

