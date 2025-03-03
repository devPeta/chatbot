import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  final String apiKey = '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';
  final String apiUrl = 'https://openrouter.ai/api/v1/chat/completions';

  Future<String> getChatResponse(String userMessage) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
          'HTTP-Referer': 'com.example.chatbot',  // Replace with your app domain
          'X-Title': 'Chat Bot',
        },
        body: jsonEncode({
          "model": "deepseek-ai/deepseek-chat",  // Use DeepSeek Chat model
          "messages": [
            {"role": "system", "content": "You are a helpful assistant."},
            {"role": "user", "content": userMessage}
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      } else {
        return "Error: ${response.statusCode} - ${response.body}";
      }
    } catch (e) {
      return "Error: $e";
    }
  }
}
