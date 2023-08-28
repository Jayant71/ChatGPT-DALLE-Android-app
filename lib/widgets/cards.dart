import 'package:contentgen/screens/idea_screen.dart';
import 'package:flutter/material.dart';

import '../screens/image_screen.dart';

class Cards extends StatelessWidget{
  const Cards({super.key, required this.text, required this.icon});

  final String text;
  final IconData icon;

  void onSelect(String text, BuildContext context) {
    if (text == 'Idea Generator') {
      Navigator.push(context,
          MaterialPageRoute(builder: (ctx) => const IdeaGenerationScreen()));
    } else if(text == 'Image Generator'){
      Navigator.push(context,
          MaterialPageRoute(builder: (ctx) => const ImageGenerationScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onSelect(text, context);
      },
      child: Card(
        color: const Color.fromARGB(255, 165, 174, 179),
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.fromLTRB(15,30,15,30),
          child: Row(
            children: [
              Icon(icon,size: 50),
              const SizedBox(width: 15,),
              Text(
                text,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20 ),),
            ],
          ),
        ),
      ),
    );
  }

}