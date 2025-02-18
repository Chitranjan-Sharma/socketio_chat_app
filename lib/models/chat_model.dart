import 'dart:convert';

import 'package:image_picker/image_picker.dart';

class ChatModel {
  String? text, time;
  String? receiverId;
  bool isSender;
  String? fileData;
  XFile? xFile;

  ChatModel(
      {this.text,
      this.isSender = false,
      this.time,
      this.receiverId,
      this.fileData,
      this.xFile});

  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "isSender": isSender,
      "time": time,
      "receiverId": receiverId,
      "fileData": fileData,
      "xFile": xFile
    };
  }

  ChatModel toModel(Map map) {
    return ChatModel(
        text: map['text'],
        time: map['time'],
        isSender: map['isSender'],
        receiverId: map["receiverId"],
        fileData: map["fileData"],
        xFile: map["xFile"]);
  }
}
