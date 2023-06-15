import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:sax/common/style.dart';
import 'package:sax/widgets/bottom_sheet.dart';
import 'package:sax/widgets/custom_appbar.dart';
import 'package:sax/widgets/drawer.dart';

import '../../common/common.dart';
import '../models/product.dart';
import 'product_detail_page.dart';

class ProductsPage extends StatefulWidget {

  final String title;
  final String collection;
  const ProductsPage({super.key, required this.title, required this.collection});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {

  Client client = http.Client();

  Future<List<Product>> fetchProducts() async {
    final response = await http
        .get(Uri.parse(productsUrl));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      var responseData = json.decode(response.body);

      List<Product> products = [];

      for (var singleProduct in responseData){
        Product product = Product(
            price: singleProduct['price'],
            name: singleProduct['name'],
            image: singleProduct['image'],
            product_type: singleProduct['product_type']
        );

        products.add(product);
      }

      return products;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: colorPrimary,
      appBar: CustomAppbar(context),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
            Text(widget.title,
              //textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 16),
          FutureBuilder(
            builder: (ctx, snapshot) {
              if (snapshot.hasData){

                final data = snapshot.data;

                print("Data"+ data.toString());

                return GestureDetector(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: colorPrimaryDark,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 180,
                            width: 180,
                            child: CachedNetworkImage(imageUrl: data![0].image),
                          ),
                          Text(data![0].name, textAlign: TextAlign.end,
                            style: TextStyle(
                                color: colorPrimaryDark,
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                            ),
                          ),

                          Text("R"+data![0].price.toString(), textAlign: TextAlign.end,
                            style: TextStyle(
                                color: colorPrimaryDark,
                                fontSize: 12
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductDetailsPage(product: data![0], selected_collection: widget.title,)),
                    );
                  },
                );

              }

              // Displaying LoadingSpinner to indicate waiting state
              return Center(
                child: CircularProgressIndicator(),
              );
            },

// Future that needs to be resolved
// inorder to display something on the Canvas
            future: fetchProducts(),
          ), //
          ],
        )
      ),
      bottomSheet: CustomBottomsheet(),

    );
  }
}

