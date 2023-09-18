import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suuitch/screens/home.dart';
import 'package:suuitch/screens/login.dart';
import 'package:suuitch/screens/register.dart';

//import 'package:suuitch/screens/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'register': (BuildContext context) => RegisterPage(),
          'home': (BuildContext context) => MainPage(),
        },
        home: MainPage(),

      ),
    );
  }
}
