class Statements{
  String Name ;
  String Phone ;
  String Session;
  String Open;
  String Close ;
  String Amount;
  String Type;
  String Date;
  String Ditributed;
  String Id;
  Statements({required this.Session , required this.Open , required this.Close , required this.Amount , required this.Type , required this.Phone , required this.Name,required this.Date , required this.Id , required this.Ditributed});
 static Statements fromJson(Map<String,dynamic> mp){
   return Statements(Session: mp["Session"], Phone: mp["Phone"], Name: mp["Name"], Date: mp["Date"],Open: mp["Open"] , Close: mp["Close"],Type: mp["Type"],Amount: mp["Amount"] , Id: mp["Id"] , Ditributed: mp["Distributed"]);
 }
}