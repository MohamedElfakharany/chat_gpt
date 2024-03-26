import 'package:chat_gpt_task/model/Chat/models.dart';
import 'package:chat_gpt_task/shared/services/api_service.dart';
import 'package:flutter/material.dart';

class ModelsProvider with ChangeNotifier {
  String currentModel = "gpt-3.5-turbo-0301";

  String get getCurrentModel {
    return currentModel;
  }

}
