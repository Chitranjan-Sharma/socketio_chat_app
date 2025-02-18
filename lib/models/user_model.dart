class UserModel {
  String? name, lastMessage, time, dp, id;

  UserModel({this.id, this.name, this.lastMessage, this.time, this.dp});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "time": time,
      "id": id,
      "lastMessage": lastMessage,
      "dp": dp
    };
  }

  UserModel toModel(Map map) {
    return UserModel(
        name: map['name'],
        time: map['time'],
        lastMessage: map['lastMessage'],
        id: map["id"],
        dp: map["dp"]);
  }
}
