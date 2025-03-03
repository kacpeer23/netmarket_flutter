import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:netmarket_flutter/screens/sign_up_screen.dart';
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
  final _formKey = GlobalKey<FormState>(); // Klucz formularza do walidacji

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthService auth = AuthService();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Zaloguj się'),
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(2.0), child: Divider()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey, // Przypisanie klucza formularza
          child: Column(
            children: [
              TextFormField(
                controller: emailTextController,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  labelStyle: TextStyle(fontSize: 13),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Proszę podać adres e-mail';
                  }
                  String pattern =
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                  RegExp regExp = RegExp(pattern);
                  if (!regExp.hasMatch(value)) {
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
                    labelStyle: const TextStyle(
                      fontSize: 13,
                    ),
                    suffixIcon: GestureDetector(
                        onTap: () {
                          _toggle();
                        },
                        child: Icon(_obscureText
                            ? Icons.visibility
                            : Icons.visibility_off))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Proszę podać hasło';
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
                        if (_formKey.currentState!.validate()) {
                          await signInWithEmailAndPassword(auth);
                        }
                      },
                      child: const Text(
                        'Zaloguj się',
                        style: TextStyle(fontSize: 14),
                      ))),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Nie masz konta?'),
                  TextButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()));
                      },
                      child: const Text(
                        'Zarejestruj się',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ))
                ],
              ),
              TextButton(
                onPressed: () {
                  _showForgotPasswordDialog(context, auth);
                },
                child: const Text(
                  'Zapomniałeś hasła?',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
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
      log('signInWithEmailAndPassword error: $e, code: ${e.code}');
    }
  }

  Future<void> createUserWithEmailAndPassword(AuthService auth) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text);
    } on FirebaseAuthException catch (e) {
      log('createUserWithEmailAndPassword error: $e');
    }
  }

  void _showForgotPasswordDialog(
      BuildContext context, AuthService authService) {
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Zresetuj hasło'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Wprowadź swój email, aby zresetować hasło.',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Anuluj'),
            ),
            ElevatedButton(
              onPressed: () {
                final email = emailController.text.trim();
                if (email.isNotEmpty) {
                  authService.sendPasswordResetEmail(email);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'E-mail z linkiem do zresetowania hasła został wysłany. Sprawdź swoją skrzynkę pocztową.'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Wprowadź prawidłowy adres e-mail'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Wyślij kod resetujący'),
            ),
          ],
        );
      },
    );
  }
}
