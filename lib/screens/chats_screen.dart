import 'dart:convert';
import 'dart:io';

import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socketio_chat_app/models/chat_model.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socketio_chat_app/constants/server_constants.dart';
import 'package:socketio_chat_app/models/user_model.dart';
import 'package:socketio_chat_app/my_widgets/send_message_widget.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key, required this.userModel});

  final UserModel userModel;

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  List<ChatModel> chats = [];
  List<ChatModel> orgChats = [];
  ChatModel currentMessage = ChatModel();

  final TextEditingController _editingController = TextEditingController();

  IO.Socket socket = IO.io(
      ServerConstants.HTTP_SERVER_URL,
      IO.OptionBuilder()
          .disableAutoConnect()
          .setTransports(['websocket']).build());

  @override
  void initState() {
    super.initState();

    connectToSocket();
  }

  connectToSocket() {
    socket.connect();

    socket.onConnect(
      (data) {
        print(data);
        socket.emit("register_client", ServerConstants.SENDER_ID);

        socket.on("fromServerMsg", (data) {
          print(data);
          orgChats.add(ChatModel().toModel(data));
          chats = orgChats.reversed.toList();
          setState(() {});
        });
      },
    );

    print("Connected");
  }

  String getCurrentTimes() {
    DateTime dt = DateTime.now();
    String hr = (dt.hour > 12 ? dt.hour - 12 : dt.hour).toString();
    String mn = (dt.minute).toString();
    hr = hr.length > 1 ? hr : "0$hr";
    mn = mn.length > 1 ? mn : "0$mn";

    return "$hr:$mn";
  }

  void _sendMessageToUser() {
    if (_editingController.text.trim().isNotEmpty) {
      currentMessage.receiverId = widget.userModel.id;
      currentMessage.text = _editingController.text;
      currentMessage.time = getCurrentTimes();
      currentMessage.isSender = true;

      print(currentMessage.fileData);

      socket.emit("fromClientMsg", currentMessage.toJson());
      orgChats.add(currentMessage);
      chats = orgChats.reversed.toList();
      setState(() {
        currentMessage = ChatModel();
      });
      _editingController.clear();
    }
  }

  void _selectFiles() async {
    await ImagePicker()
        .pickImage(source: ImageSource.gallery)
        .then((data) async {
      if (data != null) {
        currentMessage.fileData = base64Encode(await data.readAsBytes());
        currentMessage.xFile = data;
        setState(() {});
      }
    }).catchError((error) {
      if (mounted) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text("Alert"),
                  content: Text("Error occured ! Please try again later."),
                ));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    socket.disconnect();
    _editingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(widget.userModel.dp!),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                widget.userModel.name!,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Text(
            "connected withe @${widget.userModel.name}",
            style: TextStyle(color: Colors.green),
          ),
          Expanded(
              child: ListView.builder(
                  reverse: true,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  itemCount: chats.length,
                  itemBuilder: (cnxt, i) {
                    ChatModel chatModel = chats[i];

                    return SizedBox(
                      child: Row(
                        mainAxisAlignment: chatModel.isSender
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: chatModel.isSender
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              chatModel.fileData == null
                                  ? BubbleSpecialThree(
                                      text: chatModel.text.toString(),
                                      isSender: chatModel.isSender,
                                      color: chatModel.isSender
                                          ? Colors.blue
                                          : const Color.fromARGB(
                                              255, 216, 216, 216),
                                      constraints:
                                          BoxConstraints(maxWidth: 250),
                                      textStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: chatModel.isSender
                                              ? Colors.white
                                              : Colors.black),
                                    )
                                  : SizedBox(
                                      width: 250,
                                      child: BubbleNormalImage(
                                          tail: false,
                                          id: DateTime.now().toString(),
                                          isSender: chatModel.isSender,
                                          image: Image.file(
                                              chatModel.xFile as File)),
                                    ),
                              Padding(
                                padding: chatModel.isSender
                                    ? const EdgeInsets.only(right: 20)
                                    : const EdgeInsets.only(
                                        left: 20,
                                      ),
                                child: Text(
                                  chatModel.time.toString(),
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  })),
          SendMessageWidget(
            imageFileData: currentMessage.fileData,
            controller: _editingController,
            selectFilesCallback: _selectFiles,
            sendMessageCallback: _sendMessageToUser,
          )
        ],
      ),
    );
  }
}
