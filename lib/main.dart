import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trees_project/firebase_options.dart';
import 'package:trees_project/home_screen.dart';
import 'package:trees_project/info_screen.dart';
import 'package:trees_project/search_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //         apiKey: "AIzaSyBMCx9L1mKIBGgkA2HYqRjAtNqwwDX6Jvw",
  //         appId: "1:186587038018:web:49e00e59f66664de3048db",
  //         messagingSenderId: "186587038018",
  //         projectId: "trees-app-841af"));
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const TreeIdentificationApp());
}

class TreeIdentificationApp extends StatefulWidget {
  const TreeIdentificationApp({super.key});

  @override
  State<TreeIdentificationApp> createState() => _TreeIdentificationAppState();
}

class _TreeIdentificationAppState extends State<TreeIdentificationApp> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.lightGreen,
            title: const Text(
              'Identification of Trees',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: selectedIndex == 0
              ? const SearchInFirebasePage()
              : selectedIndex == 1
                  ? const HomePage()
                  : const InfoPage(),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (val) {
              // if (val == 0) {
              //   _searchTree();
              // }
              setState(() {
                selectedIndex = val;
              });
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.info),
                label: 'Info',
              ),
            ],
            iconSize: 30,
            currentIndex: selectedIndex,
            backgroundColor: Colors.lightGreen,
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.black,
          )),
      debugShowCheckedModeBanner: false,
    );
  }
}
