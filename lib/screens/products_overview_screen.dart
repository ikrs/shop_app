import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
      ),
      // like listView, .builder renders only items that are on the screen
      body: ProductsGrid(),
    );
  }
}


