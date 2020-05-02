import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/models/productPojo.dart';
import 'package:flutter_course/provider_models/auth_model.dart';
import 'package:flutter_course/provider_models/cart_model.dart';
import 'package:flutter_course/provider_models/product_model.dart';
import 'package:flutter_course/screens/home_screen.dart';
import 'package:flutter_course/screens/login_screen.dart';
import 'package:flutter_course/screens/manage_products_screen.dart';
import 'package:flutter_course/screens/onboarding_screen.dart';
import 'package:flutter_course/screens/product_cart_screen.dart';
import 'package:flutter_course/screens/product_detail.dart';
import 'package:flutter_course/screens/register_screen.dart';
import 'package:provider/provider.dart';

import 'local/sharedpreferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Set default home.
  Widget _defaultHome = new OnBoardingScreen();

  final String hasOnBoarded = "has_on_boarded";

  bool hasUserOnBoarded = await SharedPreferenceHelper.getBoolean(hasOnBoarded);
  final firebaseUser = await FirebaseAuth.instance.currentUser();

  if (hasUserOnBoarded == true) {
    _defaultHome = RegisterScreen();
  }

  if (firebaseUser != null) {
    _defaultHome = HomeScreen();
  }

  // Run app!
  runApp(MyApp(homeWidget: _defaultHome));
}

class MyApp extends StatefulWidget {
  final Widget homeWidget;

  MyApp({this.homeWidget});

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthenticationViewModel()),
        ChangeNotifierProvider(create: (context) => CartViewModel()),
        ChangeNotifierProvider(create: (_) => ProductViewModel())
      ],
      child: MaterialApp(
          title: 'ProductCart',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.deepPurple,
            accentColor: Colors.deepPurpleAccent,
          ),
          // Our App Routes
          routes: {
            '/home': (BuildContext context) => HomeScreen(),
            '/manageProduct': (BuildContext context) => ManageProductPage(),
            '/register': (BuildContext context) => RegisterScreen(),
            '/login': (BuildContext context) => LoginScreen(),
            '/onboarding': (BuildContext context) => OnBoardingScreen(),
            '/cartScreen': (BuildContext context) => ProductCartScreen()
          },

          // ignore: missing_return
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case "/products":
                var data = settings.arguments as Product;
                if (data != null) {
                  return MaterialPageRoute<bool>(builder: (BuildContext context) => ProductPage(data));
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
          home: widget.homeWidget),
    );
  }
}
