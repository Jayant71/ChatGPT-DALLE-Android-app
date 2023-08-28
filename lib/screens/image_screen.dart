import 'package:flutter/material.dart';
import '../apicallbacks/openai_call.dart';

class ImageGenerationScreen extends StatefulWidget {
  const ImageGenerationScreen({super.key});

  @override
  State<ImageGenerationScreen> createState() {
    return _ImageGenerationScreenState();
  }
}

class _ImageGenerationScreenState extends State<ImageGenerationScreen> {
  late TextEditingController _controller;
  String src = "";
  late String errorText = "Your image appear here" ;

  @override
  void initState() {
    super.initState();
    // errorText = "Your image appears here";
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onSubmitted(String message) async {
    if (message == null || message.trim().isEmpty) {
      return;
    }
    setState(() {
      _controller.clear();
    });

    final result = await generateImage(message);

    setState(() {
    if(result != null){
        src = result!.data[0].url.toString();
    } else {
      errorText = "Failed to generate";
    }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 95, 100, 103),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 60, 63, 65),
        title: const Text(
          "Image Generator",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(10),
            child: src.isEmpty
                ? Center(
                    child: Text(errorText),
                  )
                : Image.network(
                    src,
                    fit: BoxFit.fitWidth,
                  ),
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text(
                        "Enter image description",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    onSubmitted: onSubmitted,
                  ),
                ),
                Center(
                  child: IconButton(
                      onPressed: () {
                        onSubmitted(_controller.text);
                        FocusScope.of(context).unfocus();
                      },
                      icon: const Icon(
                        Icons.send,
                        size: 40,
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
