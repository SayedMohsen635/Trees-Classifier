// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'cach_helper.dart';

class SearchInFirebasePage extends StatefulWidget {
  const SearchInFirebasePage({super.key});

  @override
  State<SearchInFirebasePage> createState() => _SearchInFirebasePageState();
}

class _SearchInFirebasePageState extends State<SearchInFirebasePage> {
  String label = '';
  @override
  void initState() {
    label = CachHelper.getData(key: 'output');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: StreamBuilder(
      stream: FirebaseFirestore.instance.collection('trees').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('something went wrong');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          var d = snapshot.data!.docs
              .where((element) => element['Name'] == label)
              .toList();

          return d.isEmpty
              ? const Text('')
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: ${d[0]['Name']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.green)),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('Edible: ${d[0]['Edible']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.green)),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('FruitFul: ${d[0]['FruitFul']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.green)),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('Thorynplant: ${d[0]['Thorynplant']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.green)),
                    ],
                  ),
                );
        }
      },
    ));
  }
}
