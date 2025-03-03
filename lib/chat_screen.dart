import 'package:flutter/material.dart';
import 'chat_service.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ChatService _chatService = ChatService();
  final List<Map<String, String>> messages = []; // Store chat messages

  void sendMessage() async {
    String userMessage = _controller.text.trim();
    if (userMessage.isEmpty) return;

    setState(() {
      messages.add({"role": "user", "content": userMessage});
      _controller.clear();
    });

    String botResponse = await _chatService.getChatResponse(userMessage);

    setState(() {
      messages.add({"role": "assistant", "content": botResponse});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.blue.withOpacity(0.1),
      appBar: AppBar(title: Text("Chat with AI"),
      backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: false,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                bool isUser = msg["role"] == "user";

                return BubbleSpecialThree(
                  text: msg["content"]!,
                  color: isUser ? Colors.blue.withOpacity(0.4) : Colors.grey.shade300,
                  tail: true,
                  isSender: isUser,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: EdgeInsets.all(8),
                  child: IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}