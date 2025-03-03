import 'dart:developer';

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
  final _formKey = GlobalKey<FormState>();

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
        title: const Text('Zarejestruj się'),
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(2.0), child: Divider()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Pole e-mail
              TextFormField(
                controller: emailTextController,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  labelStyle: TextStyle(fontSize: 13, color: Colors.black54),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Proszę podać adres e-mail';
                  } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
                      .hasMatch(value)) {
                    return 'Proszę podać prawidłowy adres e-mail';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: passwordTextController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'Hasło',
                  labelStyle: const TextStyle(fontSize: 13, color: Colors.black54),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _toggle();
                    },
                    child: Icon(_obscureText
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Proszę podać hasło';
                  } else if (value.length < 6) {
                    return 'Hasło musi mieć co najmniej 6 znaków';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      await createUserWithEmailAndPassword(auth).then((value) {
                        Navigator.pop(context);
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Proszę poprawić błędy w formularzu'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Zarejestruj się',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createUserWithEmailAndPassword(AuthService auth) async {
    final email = emailTextController.text.trim();
    final password = passwordTextController.text.trim();

    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      log('createUserWithEmailAndPassword error: $e');
    }
  }
}
