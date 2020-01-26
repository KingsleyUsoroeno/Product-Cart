import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/pages/auth_page.dart';
import 'package:flutter_course/pages/home_page.dart';
import 'package:flutter_course/pages/manage_products.dart';
import 'package:flutter_course/pages/onboarding.dart';
import 'package:flutter_course/pages/product_detail.dart';
import 'package:flutter_course/productPojo.dart';

main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  List<ProductPojo> _products = [];

  void _addProduct(ProductPojo products) {
    setState(() {
      _products.add(products);
    });
  }

  void updateProduct(int index, ProductPojo product) {
    setState(() {
      print("Product is ${_products[index]}");
      if (_products != null) {
        _products[index] = product;
      }
      print("Product is ${_products.toString()}");
    });
  }

  void _deleteProduct(int position) {
    setState(() {
      _products.removeAt(position);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.deepPurpleAccent,
        ),
        routes: {
          '/home': (BuildContext context) =>
              HomePage(_products, _deleteProduct),
          '/manageProduct': (BuildContext context) =>
              ManageProductPage(_addProduct, updateProduct, _products),
          '/auth': (BuildContext context) => AuthPage()
        },
        // ignore: missing_return
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case "/products":
              var data = settings.arguments as ProductPojo;
              if (data != null) {
                return MaterialPageRoute<bool>(
                    builder: (BuildContext context) => ProductPage(data));
              }
              break;
            default:
              return MaterialPageRoute(
                  builder: (BuildContext context) => Scaffold(
                        body: Center(
                          child: Text('No route defined for ${settings.name}'),
                        ),
                      ));
          }
        },
        home: OnBoarding());
  }
}
