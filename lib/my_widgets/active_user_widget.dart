import 'package:flutter/material.dart';
import 'package:socketio_chat_app/models/user_model.dart';

class ActiveUserWidget extends StatelessWidget {
  const ActiveUserWidget({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(2),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.green, width: 2)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                userModel.dp!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            userModel.name!,
            maxLines: 1,
            style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
