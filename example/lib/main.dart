import 'package:extension_utils/enum_utils.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Extension Utils Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Extension Utils Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  UserType user = UserType.admin;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user.when({
      UserType.admin: () => debugPrint('Admin'),
      UserType.user: () => debugPrint('User'),
      UserType.guest: () => debugPrint('Guest')
    });
    return const Scaffold(
      body: Center(child: Text('Example')),
    );
  }
}

enum UserType {
  admin,
  user,
  guest,
}

enum Color {
  red,
  green,
  blue,
}
