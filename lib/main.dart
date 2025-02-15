import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_supabase/bloc/auth_bloc.dart';
import 'package:learning_supabase/pages/login_page.dart';
import 'package:learning_supabase/pages/sign_up.dart';
import 'package:learning_supabase/secrets/secrets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Supabase.initialize(
    url: supabseUrl,
    anonKey: supabaseAnonKey,
  );
  runApp(MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.blueGrey.shade50,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
          headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all(Colors.blue), // Button color
            foregroundColor:
                WidgetStateProperty.all(Colors.white), // Text color
            shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            padding: WidgetStateProperty.all(
                EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
            textStyle: WidgetStateProperty.all(TextStyle(fontSize: 16)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          labelStyle: TextStyle(color: Colors.blueGrey.shade700),
          hintStyle: TextStyle(color: Colors.blueGrey.shade400),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.blue,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(Colors.blue),
            textStyle: WidgetStateProperty.all(TextStyle(fontSize: 16)),
            padding: WidgetStateProperty.all(
                EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
          ),
        ),
      ),
      home: BlocProvider(
        create: (context) => AuthBloc(),
        child: SignUpPage(),
      ),
    );
  }
}
