import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:netmarket_flutter/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthService auth = AuthService();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Logowanie'),
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(2.0), child: Divider()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: emailTextController,
              decoration: const InputDecoration(
                labelText: 'Adres e-mail',
                labelStyle: TextStyle(fontSize: 13, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordTextController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                  labelText: 'Hasło',
                  focusColor: Colors.blue,
                  labelStyle:
                      const TextStyle(fontSize: 13, color: Colors.black54),
                  suffixIcon: GestureDetector(
                      onTap: () {
                        _toggle();
                      },
                      child: Icon(_obscureText
                          ? Icons.visibility
                          : Icons.visibility_off))),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () async {
                      await signInWithEmailAndPassword(auth);
                    },
                    child: const Text(
                      'Zaloguj się',
                      style: TextStyle(fontSize: 14),
                    ))),
            const SizedBox(height: 10),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () async {
                      await createUserWithEmailAndPassword(auth);
                    },
                    style: ButtonStyle(
                        foregroundColor:
                            WidgetStateProperty.all<Color>(Colors.blueAccent),
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.white),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(color: Colors.blueAccent),
                          ),
                        )),
                    child: const Text(
                      'Zarejestruj się',
                      style: TextStyle(fontSize: 14),
                    ))),
          ],
        ),
      ),
    );
  }

  Future<void> signInWithEmailAndPassword(AuthService auth) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text);
    } on FirebaseAuthException catch (e) {
      print('signInWithEmailAndPassword error: $e, code: ${e.code}');
    }
  }

  Future<void> createUserWithEmailAndPassword(AuthService auth) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text);
    } on FirebaseAuthException catch (e) {
      print('createUserWithEmailAndPassword error: $e');
    }
  }
}
