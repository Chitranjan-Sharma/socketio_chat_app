import 'package:flutter/material.dart';
import 'package:socketio_chat_app/constants/colors_constants.dart';

class Mytheme {
  static get darkTheme => ThemeData(
      scaffoldBackgroundColor: MyColors.primaryDark,
      appBarTheme: AppBarTheme(
        scrolledUnderElevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: MyColors.primaryDark,
          titleTextStyle: TextStyle(
              overflow: TextOverflow.ellipsis,
              color: Colors.white,
              fontSize: 18,
              
              fontWeight: FontWeight.bold)));
}
