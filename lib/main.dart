import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cach_helper.dart';
import 'firebase_options.dart';
import 'home_screen.dart';
import 'info_screen.dart';
import 'search_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  CachHelper.init();
  runApp(
    ChangeNotifierProvider(
      create: (_) => myImageProvider(),
      child: const TreeIdentificationApp(),
    )
  );
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
