import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../screens/cart_screens.dart';
import '../widgets/app_drawer.dart';
import '../providers/products.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  // only this widget will controle showFavorite state and not Provider
  var _showOnlyFavorites = false;
  var _isInit = true;

  @override
  void initState() {
    // cant do this here becouse we dont have access to context
    //Provider.of<Products>(context).fetchAndSetProducts();

    // this will work but its a kind of a hack
    /* Future.delayed(Duration.zero).then((_) {
      Provider.of<Products>(context).fetchAndSetProducts();
    }); */
    super.initState();
  }

  // this runs after widget has been fully initilized
  @override
  void didChangeDependencies() {
    if (_isInit){
      Provider.of<Products>(context).fetchAndSetProducts();
      _isInit = false;
    }
    
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          // menu that opens up as overlay
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            // this gets passed to builder as ch argument and we do this 
            // when we dont want to rebuild specific child
            child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
            )
          ),
        ],
      ),
      drawer: AppDrawer(),
      // like listView, .builder renders only items that are on the screen
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}
