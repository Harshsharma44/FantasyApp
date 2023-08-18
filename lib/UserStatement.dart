class UserStatement {
  String Name;

  String Phone;
  String Session;
  String Open;
  String Close ;
  String Amount;
  String Type;
  String Id;
  String Date;
  String Distributed;

  UserStatement(
      {required this.Name, required this.Phone, required this.Amount, required this.Type, required this.Close , required this.Open , required this.Session, required this.Id,required this.Date , required this.Distributed});

  static Map<String, dynamic> ToJson(UserStatement userStatement) {
    return {
      "Name": userStatement.Name,
      "Phone": userStatement.Phone,
      "Session": userStatement.Session,
      "Open": userStatement.Open,
      "Close": userStatement.Close,
      'Amount': userStatement.Amount,
      "Type": userStatement.Type,
      "Id": userStatement.Id,
      "Date": userStatement.Date,
      "Distributed": userStatement.Distributed


    };
  }
}