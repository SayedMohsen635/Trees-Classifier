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
  String lable = '';
  @override
  void initState() {
    lable = CachHelper.getData(key: 'output');
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
              .where((element) => element['Name'] == lable)
              .toList();

          return d.isEmpty
              ? const Text('')
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: ${d[0]['Name']}'),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('Edible ${d[0]['Edible']}'),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('FruitFul ${d[0]['FruitFul']}'),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('Thorynplant ${d[0]['Thorynplant']}'),
                    ],
                  ),
                );
        }
      },
    ));
  }
}
