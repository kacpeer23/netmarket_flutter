import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:netmarket_flutter/services/auth_service.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
    final auth = Provider.of<AuthService>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Sign up'),
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
                labelText: 'E-mail',
                labelStyle: TextStyle(fontSize: 13, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordTextController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                  labelText: 'Password',
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
                      await createUserWithEmailAndPassword(auth).then((value) {
                        Navigator.pop(context);
                      });
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontSize: 14),
                    ))),
          ],
        ),
      ),
    );
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
