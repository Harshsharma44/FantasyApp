// Game is our json to list and vice versa helper class
class Game{
  String Name;
  String Opening ;
  String Closing ;
  String Random ;
  bool Status ;
  String Id ;
  String Type;
  Game({required this.Name , required this.Random , required this.Closing , required this.Opening ,  required this.Status , required this.Id , required this.Type});
  static Game fromJson (Map<String,dynamic> json){
    return Game(Name: json['Name'], Random: json['Random'], Closing: json['Closing'], Opening: json['Opening'], Status: json['Status'],Id: json['Id'] ,Type: json['Type']);
  }
  static Map<String,dynamic> Tojson(Game game ){
    Map<String,dynamic> mp = {
      "Name": game.Name,
      "Random": game.Random,
      "Closing": game.Closing,
      "Opening": game.Opening,
      "Status": game.Status,
      "Id": game.Id,
      "Type": game.Type
    };
    return mp ;
  }


}