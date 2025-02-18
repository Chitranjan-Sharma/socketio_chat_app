import 'package:flutter/material.dart';
import 'package:socketio_chat_app/constants/colors_constants.dart';
import 'package:socketio_chat_app/models/user_model.dart';
import 'package:socketio_chat_app/my_widgets/active_user_widget.dart';
import 'package:socketio_chat_app/my_widgets/user_tile_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List users = [];

  @override
  void initState() {
    super.initState();
    users.add(UserModel(
        name: "Chitranjan",
        id: "559072CS",
        lastMessage: "",
        time: "",
        dp: "assets/dp1.jpeg"));
    users.add(UserModel(
        name: "Neeraj",
        id: "441489CS",
        lastMessage: "",
        time: "",
        dp: "assets/dp2.jpeg"));
    users.add(UserModel(
        name: "User 1",
        id: "",
        lastMessage: "",
        time: "",
        dp: "assets/dp3.png"));
    users.add(UserModel(
        name: "User 2",
        id: "",
        lastMessage: "",
        time: "",
        dp: "assets/dp3.png"));
    users.add(UserModel(
        name: "User 3",
        id: "",
        lastMessage: "",
        time: "",
        dp: "assets/dp3.png"));
    users.add(UserModel(
        name: "User 4",
        id: "",
        lastMessage: "",
        time: "",
        dp: "assets/dp3.png"));
    users.add(UserModel(
        name: "User 5",
        id: "",
        lastMessage: "",
        time: "",
        dp: "assets/dp3.png"));
    users.add(UserModel(
        name: "User 6",
        id: "",
        lastMessage: "",
        time: "",
        dp: "assets/dp3.png"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Hi, User"),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ))
        ],
      ),
      body: Column(
        children: [
          SizedBox(
              height: 150,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "STATUS",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: users.length,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, i) {
                            UserModel userModel = users[i];
                            return ActiveUserWidget(
                              userModel: userModel,
                            );
                          }),
                    )
                  ])),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                  color: MyColors.secondaryDark,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35))),
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  itemCount: users.length,
                  itemBuilder: (_, index) {
                    return UserTileWidget(user: users[index]);
                  }),
            ),
          )
        ],
      ),
    );
  }
}
