import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  final String apiKey = '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'; // Replace with your valid OpenRouter API key
  final String apiUrl = 'https://openrouter.ai/api/v1/chat/completions';

  Future<String> getChatResponse(String userMessage) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
          'HTTP-Referer': 'https://your-registered-site.com', // Replace with your registered site URL
          'X-Title': 'com.example.chatbot', // Replace with your app name
        },
        body: jsonEncode({
          "model": "deepseek/deepseek-r1:free", // Match the model in Python
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
