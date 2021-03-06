import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


import 'AboutPage.dart';
import 'HomePage.dart';
import 'ChatPage.dart';
import 'ProfilePage.dart';
import 'StoriesPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return FlutterEasyLoading(child: Text("Error"));
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
           return MaterialApp(home: MyBottomNavigationBar());
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return FlutterEasyLoading(child: Text("Please wait.."));
      },
    );
    
   
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomePage(),
    ChatPage(),
    StoriesPage(),
    ProfilePage(),
    AboutPage()
  ];

  void _onItemTapped(int selectedIndex) {
    setState(() {
      _selectedIndex = selectedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(
              Icons.home,
            ),
          ),
          BottomNavigationBarItem(
            label: "Chat",
            icon: Icon(
              Icons.chat,
            ),
          ),
          BottomNavigationBarItem(
            label: "Stories",
            icon: Icon(
              Icons.question_answer,
            ),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(
              Icons.person,
            ),
          ),
          BottomNavigationBarItem(
            label: "About",
            icon: Icon(
              Icons.contact_support_outlined,
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}
