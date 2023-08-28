import 'package:contentgen/screens/homepage.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';


void main() {
  OpenAI.apiKey = "Your_API_key";
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Media Content Generator',
      theme: ThemeData(useMaterial3: true),
      home: const HomePage(),);
    }
}
