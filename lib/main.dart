import 'package:flutter/material.dart';
import 'welcome_page.dart';
import 'connection_page.dart';
import 'login_page.dart';
import 'dance.dart';
import 'tunisia.dart';
import 'livestream.dart'; 
import 'mainpage.dart';
import 'feedback.dart';
import 'help.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hexaswift App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Set the initial route to WelcomePage
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomePage(), // WelcomePage as the initial route
        '/connection': (context) => ConnectionPage(), // Add route for ConnectionPage
        '/login': (context) =>LoginPage(),
        '/control': (context) => CameraApp (), 
        '/suggestion':(context)=>SuggestionsApp(),
        '/feedback': (context) => app(),
        '/help': (context) => HelpPage(),// Add route for ControlPage
        '/hexaswiftCanDance': (context) => HexaswiftCanDancePage(),
        '/hexaswiftExploreTunisia': (context) => HexaswiftExploreTunisiaPage(),
      },
    );
  }
}
