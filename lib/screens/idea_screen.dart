import 'package:flutter/material.dart';
import '../apicallbacks/openai_call.dart';
import '../widgets/chat_messages.dart';

class IdeaGenerationScreen extends StatefulWidget {
  const IdeaGenerationScreen({super.key});

  @override
  State<IdeaGenerationScreen> createState() {
    return _IdeaGenerationScreenState();
  }
}

class _IdeaGenerationScreenState extends State<IdeaGenerationScreen> {
  late TextEditingController _controller;
  final List<ChatMessage> messageList = [];

  @override
  void initState() {
    super.initState();
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
      ChatMessage chat = ChatMessage(message: message, isMe: true);
      messageList.add(chat);
      _controller.clear();
    });

    final result = await callChatGPT(message);
    setState(() {
      if (result != null) {
        final content = result?.choices;
        ChatMessage resultChat =
            ChatMessage(message: content![0].message.content, isMe: false);
        messageList.add(resultChat);
      } else {
        ChatMessage resultChat =
            ChatMessage(message: "No response", isMe: false);
        messageList.add(resultChat);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 95, 100, 103),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 60, 63, 65),
        title: const Text(
          "Idea Generator",
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
          IconButton(
              onPressed: getModels,
              icon: Icon(
                Icons.get_app,
                color: Colors.white,
              )),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: messageList.isEmpty
                ? const Center(
                    child: Text(
                      "Your chats appear here",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        reverse: true,
                        itemCount: messageList.length,
                        itemBuilder: (ctx, index) {
                          return Align(
                            alignment: messageList.reversed.toList()[index].isMe
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              constraints:
                                  BoxConstraints(maxWidth: screenWidth / 1.5),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    messageList.reversed
                                        .toList()[index]
                                        .message,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
          ),
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
                        "Enter your queries",
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
