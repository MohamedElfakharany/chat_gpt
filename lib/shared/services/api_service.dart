import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:chat_gpt_task/model/Chat/chat_model.dart';
import 'package:chat_gpt_task/model/Chat/models.dart';
import 'package:chat_gpt_task/shared/providers/chats_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

String baseUrl = "https://api.openai.com/v1";

// Change ApiKey Every Hour!!
// String test_key = "ApiKey";
String test_key = "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";

class ApiService {

  // Send Message using ChatGPT API
  static Future<List<ChatModel>> sendMessageGPT(
      {required String message, required String modelId}) async {
    try {
      log("modelId $modelId");
      var response = await http.post(
        Uri.parse("$baseUrl/chat/completions"),
        headers: {
          'Authorization': 'Bearer $test_key',
          "Content-Type": "application/json"
        },
        body: jsonEncode(
          {
            "model": modelId,
            "max_tokens": 100,
            "messages": [
              {
                "role": "user",
                "content": message,
              }
            ]
          },
        ),
      );

      Map jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']["message"]);
      }
      List<ChatModel> chatList = [];
      if (jsonResponse["choices"].length > 0) {
        chatList = List.generate(
          jsonResponse["choices"].length,
          (index) => ChatModel(
            msg: jsonResponse["choices"][index]["message"]["content"],
            chatIndex: 1,
          ),
        );
      }
      return chatList;
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }

  // Send Message fct
  static Future<List<ChatModel>> sendMessage(
      {required String message, required String modelId}) async {
    try {
      log("modelId $modelId");
      var response = await http.post(
        Uri.parse("$baseUrl/completions"),
        headers: {
          'Authorization': 'Bearer $test_key',
          "Content-Type": "application/json"
        },
        body: jsonEncode(
          {
            "model": modelId,
            "prompt": message,
            "max_tokens": 300,
          },
        ),
      );

      Map jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']["message"]);
      }
      List<ChatModel> chatList = [];
      if (jsonResponse["choices"].length > 0) {
        chatList = List.generate(
          jsonResponse["choices"].length,
          (index) => ChatModel(
            msg: jsonResponse["choices"][index]["text"],
            chatIndex: 1,
          ),
        );
      }
      return chatList;
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }

  // Delete Message
  static Future deleteMessage({context}) async {
    try {
      log("delete message test_key $test_key");
      var response = await http.delete(
        Uri.parse("$baseUrl/completions"),
        headers: {
          'Authorization': 'Bearer $test_key',
          "Content-Type": "application/json"
        },
        body: jsonEncode(
          {
            "OpenAI-Beta": 'assistants=v1',
          },
        ),
      );

      Map jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']["message"]);
      }
      if (jsonResponse["deleted"] == true) {
        Provider.of<ChatProvider>(context).getChatList.clear();
      }
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }

}
