import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/models/productPojo.dart';
import 'package:flutter_course/scoped_models/AppModel.dart';
import 'package:flutter_course/screens/auth_screen.dart';
import 'package:flutter_course/screens/home_screen.dart';
import 'package:flutter_course/screens/manage_products_screen.dart';
import 'package:flutter_course/screens/onboarding_screen.dart';
import 'package:flutter_course/screens/product_detail.dart';
import 'package:scoped_model/scoped_model.dart';

main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: AppModel(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.deepPurple,
            accentColor: Colors.deepPurpleAccent,
          ),
          // Our App Routes
          routes: {
            '/home': (BuildContext context) => HomePage(),
            '/manageProduct': (BuildContext context) => ManageProductPage(),
            '/auth': (BuildContext context) => AuthPage()
          },

          // ignore: missing_return
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case "/products":
                var data = settings.arguments as ProductPoJo;
                if (data != null) {
                  return MaterialPageRoute<bool>(
                      builder: (BuildContext context) => ProductPage(data));
                }
                break;
              default:
                return MaterialPageRoute(
                    builder: (BuildContext context) =>
                        Scaffold(
                          body: Center(
                            child:
                            Text('No route defined for ${settings.name}'),
                          ),
                        ));
            }
          },
          home: OnBoarding()),
    );
  }
}
