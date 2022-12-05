import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_mobx/screens/login_screen.dart';
import 'package:todo_mobx/stores/login_store.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<LoginStore>(
      create: (_) => LoginStore(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            iconTheme: IconThemeData(color: Colors.deepPurpleAccent),
            primaryColor: Colors.deepPurpleAccent,
            textSelectionTheme: const TextSelectionThemeData(
                cursorColor: Colors.deepPurpleAccent,
                selectionHandleColor: Colors.deepPurpleAccent),
            scaffoldBackgroundColor: Color.fromARGB(255, 29, 21, 51)),
        home: LoginScreen(),
      ),
    );
  }
}
