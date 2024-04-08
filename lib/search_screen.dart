// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchInFirebasePage extends StatefulWidget {
  const SearchInFirebasePage({super.key});

  @override
  State<SearchInFirebasePage> createState() => _SearchInFirebasePageState();
}

class _SearchInFirebasePageState extends State<SearchInFirebasePage> {
  String searchResult = '';
  bool isLoading = false;

  Future<void> searchTree() async {
    setState(() {
      isLoading = true;
    });

    // Get the label/classification result from your model
    String label = '_outputs![0]["label"].toString().substring(2)';
    print(label);

    // Perform the search in Firestore
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Trees').get();

    setState(() {
      isLoading = false;
    });

    if (querySnapshot.docs.isNotEmpty) {
      // Display the attributes of the matching tree
      setState(() {
        searchResult = querySnapshot.docs.first.data().toString();
      });
    } else {
      // Tree not found
      setState(() {
        searchResult = 'Tree not found.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLoading ? const CircularProgressIndicator() : const Text("data"),
    );
  }
}
