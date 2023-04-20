import 'package:chatgpt/models/chat_model.dart';
import 'package:chatgpt/services/api_services.dart';
import 'package:flutter/cupertino.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];
  List<ChatModel> get getChatList {
    return chatList;
  }

  void addUserMessage({required String msg}) {
    chatList.add(
      ChatModel(msg: msg, chatIndex: 0),
    );
    notifyListeners();
  }

  Future<void> sendUserMessage(
      {required String msg, required String chosenModel}) async {
    chatList.addAll(await ApiService.sendMessage(
      message: msg,
      modelID: chosenModel,
    ));
    notifyListeners();
  }
}
