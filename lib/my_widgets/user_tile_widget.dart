import 'package:flutter/material.dart';
import 'package:socketio_chat_app/constants/colors_constants.dart';
import 'package:socketio_chat_app/models/user_model.dart';
import 'package:socketio_chat_app/screens/chats_screen.dart';

class UserTileWidget extends StatelessWidget {
  const UserTileWidget({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ChatsScreen(
                  userModel: user,
                )));
      },
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: AssetImage(user.dp!),
      ),
      title: Text(
        user.name!,
        maxLines: 1,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
            color: MyColors.lightGrey,
            fontSize: 16),
      ),
      subtitle: Text(
        "Message.....",
        maxLines: 1,
        style: TextStyle(
            overflow: TextOverflow.ellipsis,
            color: MyColors.lightGrey,
            fontSize: 14),
      ),
      trailing: Text(
        "12:00",
        maxLines: 1,
        style: TextStyle(
            overflow: TextOverflow.ellipsis,
            color: MyColors.lightGrey,
            fontSize: 12),
      ),
    );
  }
}
