
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:netmarket_flutter/screens/home_screen.dart';
import 'package:netmarket_flutter/screens/login_screen.dart';
import 'package:netmarket_flutter/services/auth_service.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder(
      stream: authService.authStateChanges,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        log('snapshot: $snapshot');
        if (snapshot.hasData) {
          return HomePage();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
