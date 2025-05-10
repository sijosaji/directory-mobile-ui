// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/LoginScreen.dart';
import 'providers/UserMetadataProvider.dart';  //

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserMetadataProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
