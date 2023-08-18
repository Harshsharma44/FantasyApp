import 'package:djdigital/Game.dart';

class User {
  String Name;
  String Password;
  String UID ;
  String Phone ;
  User({required this.Name , required this.Password , required this.Phone , required this.UID});
 static User fromJson(Map<String,dynamic> json){
   return User(Name: json["Name"], Password: json["Password"], Phone: json["Phone"], UID: json["UID"]);
  }
  static Map<String,dynamic> ToJson(User user ){
   return {
     "Name": user.Name,
     "Password": user.Password,
     "Phone": user.Phone,
     "UID": user.UID

   };
  }

}