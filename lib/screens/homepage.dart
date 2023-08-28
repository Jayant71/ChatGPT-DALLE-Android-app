import 'package:flutter/material.dart';

import '../widgets/cards.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 95, 100, 103),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 60, 63, 65),
        title: const Text(
          "Social Media Content Generator",
          style: TextStyle(color: Colors.white),),
      ),
      body:  const Padding(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
        child: Column(
          children: [
            Cards(text: "Idea Generator", icon: Icons.text_fields,),
            Cards(text: "Image Generator", icon: Icons.image,),
          ],
        ),
      ),
    );
  }
}