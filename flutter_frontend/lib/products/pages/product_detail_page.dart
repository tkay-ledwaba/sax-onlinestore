import 'package:flutter/material.dart';

import '../../common/style.dart';
import '../../widgets/custom_appbar.dart';
import '../models/product.dart';

class ProductDetailsPage extends StatefulWidget {

  final String selected_collection;
  final Product product;

  const ProductDetailsPage({super.key, required this.product, required this.selected_collection});
  

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: colorPrimary,
        appBar: CustomAppbar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17),
        child: Column(
          children: [
            Text(widget.selected_collection + ' > ' + widget.product.name)
          ],
        ),
      )
    );
  }
  
}