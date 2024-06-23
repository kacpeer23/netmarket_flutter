import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:netmarket_flutter/auth.dart';

class HomePage extends StatelessWidget {
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
