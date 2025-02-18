import 'dart:convert';
import 'dart:ui';

import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:socketio_chat_app/constants/colors_constants.dart';

class SendMessageWidget extends StatefulWidget {
  SendMessageWidget(
      {super.key,
      required this.sendMessageCallback,
      required this.selectFilesCallback,
      required this.controller,
      this.imageFileData});

  final VoidCallback sendMessageCallback;
  final VoidCallback selectFilesCallback;
  final TextEditingController controller;
  String? imageFileData;

  @override
  State<SendMessageWidget> createState() => _SendMessageWidgetState();
}

class _SendMessageWidgetState extends State<SendMessageWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: MyColors.secondaryDark,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      padding: EdgeInsets.all(15),
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            widget.imageFileData == null
                ? IconButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white)),
                    onPressed: widget.selectFilesCallback,
                    icon: Icon(
                      Icons.add,
                      color: MyColors.secondaryDark,
                    ))
                : CircleAvatar(
                    backgroundImage:
                        MemoryImage(base64Decode(widget.imageFileData!)),
                    child: InkWell(
                      onTap: () {
                        widget.imageFileData = null;
                        setState(() {});
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
              controller: widget.controller,
              minLines: 1,
              maxLines: 5,
              decoration: InputDecoration(
                
                  hintStyle: TextStyle(color: MyColors.lightGrey),
                  hintText: "Message...",
                  border: InputBorder.none),
            )),
            SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: widget.sendMessageCallback,
              icon: Icon(
                Icons.send,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
