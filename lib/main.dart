import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // required for provider

import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './screens/cart_screens.dart';
import './providers/orders.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';
import './providers/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // adding multiple proviuders
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        // with .value is the right approach if we use provider on something thats part of a list or a grid
        // so that now we can make sure Provider works even if we change data in the widget and with builder
        // function it will not work correctly
        // providing Products() to all child widgets of MaterialApp, so now all child widgets can set
        // up a listener that will trigger a rebuild only for listeners
        // builder: (context) => Products(),
        ChangeNotifierProxyProvider<Auth, Products>(
          // adding authToken for constructor call, also adding current items to new Products
          // object so that we dont loose them
          builder: (context, auth, previousProducts) => Products(
            auth.token,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      // adding consumer around MaterialApp to know what homescreen to show
      // based on if user is logged in or not
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'My Shop',
          theme: ThemeData(
            primaryColor: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
          routes: {
            ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
            CartScreen.routeName: (context) => CartScreen(),
            OrdersScreen.routeName: (context) => OrdersScreen(),
            UserProductsScreen.routeName: (context) => UserProductsScreen(),
            EditProductScreen.routeName: (context) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
