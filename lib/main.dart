import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // required for provider

import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // with .value is the right approach if we use provider on something thats part of a list or a grid
    // so that now we can make sure Provider works even if we change data in the widget and with builder 
    // function it will not work correctly
    return ChangeNotifierProvider.value(
      // providing Products() to all child widgets of MaterialApp, so now all child widgets can set
      // up a listener that will trigger a rebuild only for listeners
      value: Products(),
      // builder: (context) => Products(),
      child: MaterialApp(
        title: 'My Shop',
        theme: ThemeData(
          primaryColor: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen()
        },
      ),
    );
  }
}
