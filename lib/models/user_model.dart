import 'package:evently_app/models/event_model.dart';

class UserModel {
  static UserModel? currentUser;
  String id;
  String name;
  String email;
  List<String> favouriteEventsIds;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.favouriteEventsIds,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "favouriteEventsIds":favouriteEventsIds
    };
  }

  UserModel.formJson(Map<String, dynamic> json)
    : this(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    favouriteEventsIds: (json["favouriteEventsIds"]as List<dynamic>).map((favouriteEventId)=>favouriteEventId.toString()).toList()

  );

  // factory UserModel.fromJson(Map<String,dynamic> json){
  //   return UserModel(id: json["id"], name: json["name"], email: json["email"]);
  // }
}
