import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:intl/intl.dart';
import 'package:netmarket_flutter/models/cart.dart';
import 'package:netmarket_flutter/services/auth_service.dart';
import 'package:netmarket_flutter/services/database_service.dart';
import 'package:netmarket_flutter/wrapper.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Intl.defaultLocale = 'pl_PL';
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FlutterLocalization localization = FlutterLocalization.instance;


  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => DatabaseService()),
        ChangeNotifierProvider(create: (_) => Cart()),
      ],
      child: MaterialApp(
        localizationsDelegates: localization.localizationsDelegates,
        supportedLocales: const [Locale('pl', 'PL')],

        title: 'NetMarket',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            centerTitle: true,
          ),
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: Colors.deepPurple,
            unselectedItemColor: Colors.black,
            backgroundColor: Colors.white,
            elevation: 8,
          ),
          useMaterial3: true,
        ),

        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey[900],
            foregroundColor: Colors.white,
          ),
          scaffoldBackgroundColor: Colors.grey[900],
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurpleAccent,
              foregroundColor: Colors.white,
            ),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Colors.deepPurple,
            unselectedItemColor: Colors.white,
            backgroundColor: Colors.grey[900],
          ),
          useMaterial3: true,
        ),

        // Automatyczne dopasowanie motywu do ustawień systemowych
        themeMode: ThemeMode.system,
        home: const Wrapper(),
      ),
    );
  }
}
