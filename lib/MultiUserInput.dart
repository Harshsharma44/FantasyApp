import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:djdigital/MultiBet.dart';
import 'dart:math';



class MultiUserInput extends StatefulWidget {
  String UserPhone;
  String Name;
  String Id;
  String Type;
  List<Bet> bets; 
  int a ;
  MultiUserInput({required this.Id , required this.Name , required this.a,required this.UserPhone,required this.Type,required this.bets});
  @override
  State<MultiUserInput> createState() => _MultiUserInputState(Name: this.Name , Id:  this.Id , a: this.a,Type: this.Type);
}

class _MultiUserInputState extends State<MultiUserInput> {
  String Name ;
  String Id;
  int? value = -1  ;
  bool submitted = false;
  int a ;
  String statement = "" ;
  String amount = "";
  String open = "";
  String close = "";
  String Type ;
  _MultiUserInputState({required this.Name , required this.Id , required this.a,required this.Type});
  String Currency = "";
  bool isCurrencyLoaded = false;
  Future<void> jj()async {
    final docUser = await FirebaseFirestore.instance.collection("Amounts").doc(
        widget.UserPhone).get();
    Map<String, dynamic>? mp = await docUser.data();
    this.Currency = mp!["Amount"];
    setState(() {
      this.isCurrencyLoaded = true;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jj();
  }
  @override


  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text(this.Name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,),),

        actions: [
          const Icon(Icons.account_balance_wallet_rounded , color: Colors.white,),
          SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
          Container(
              alignment: Alignment.centerLeft,
              child: Text(this.Currency,style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 20,color: Colors.white),)),
          SizedBox(width: MediaQuery.of(context).size.width * 0.03,)
        ],
        backgroundColor: Colors.deepPurple,


      ),
      body: ListView(

        children: [

          Container(
            height: MediaQuery.of(context).size.height * 0.9,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/paymentBG.png'),
                  fit: BoxFit.cover
                )
            ),
            child:  Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(9, 5, 5, 0.24),
                          Color.fromRGBO(9, 5, 5, 0.46),
                        ]
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.height * 0.67,
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                      this.Type == 'Main'&& this.a != -2 && this.a != 2? Row(
                        children: [
                          SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                          Text("Choose Session:",style: TextStyle(fontSize: 20,color: Colors.white),),

                        ],
                      ) : SizedBox(),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      this.Type == 'Main' && this.a != -2 && this.a != 2? Row(
                        children: [
                          SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                          Text("Open",style: TextStyle(fontSize: 20,color: Colors.white),),
                          Radio(activeColor: Colors.green,value: 1, groupValue: value,fillColor: MaterialStatePropertyAll(Colors.cyan), onChanged: (val){
                            setState(() {
                              value = val ;
                            });
                          }),
                          Text("Close",style: TextStyle(fontSize: 20,color: Colors.white),),
                          Radio(activeColor: Colors.green ,fillColor: MaterialStatePropertyAll(Colors.cyan) ,value: 2 , groupValue: value, onChanged: (val){
                            setState(() {
                              value = val ;
                            });
                          })
                        ],
                      ) : SizedBox(),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                      a>0 ?    Container(
                        color: Colors.white,
                        child: TextFormField(

                          onChanged: (val){
                            setState(() {
                              this.open = val ;
                            });
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter( a==1 ? 1 : a==2 ? 2 : a==3 ? 3 : a==4? 3 : a==5? 3 :  1)
                          ],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                            contentPadding: EdgeInsets.only(left: 20),
                            hintText: "Enter the Bid Digit",

                          ),


                        ),
                      ) :   Container(
                        color: Colors.white,
                        child: TextFormField(
                          onChanged: (val){
                            setState(() {
                              this.open = val ;
                            });
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(3)
                          ],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                              contentPadding: EdgeInsets.only(left: 20),
                              hintText: a==-1 ? "Panna": "Open Panna"
                          ),


                        ),
                      ),
                      a<0 ?
                      Container(
                        color: Colors.white,
                        margin: EdgeInsets.only(top: 20),
                        child: TextFormField(
                          onChanged: (val){
                            setState(() {
                              this.close = val ;
                            });
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(3)
                          ],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                              contentPadding: EdgeInsets.only(left: 20),
                              hintText: a==-1 ? "Digit" :"Close Panna"
                          ),


                        ),
                      ) : SizedBox(),



                      SizedBox(height: MediaQuery.of(context).size.height * 0.04),

                      Container(
                        color: Colors.white,
                        child: TextFormField(
                          onChanged: (val){
                            setState(() {
                              this.amount = val ;
                            });
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(5)
                          ],
                          decoration: InputDecoration(
                              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                              contentPadding: EdgeInsets.only(left: 20),
                              hintText: "Enter the Bid Amount"
                          ),


                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.05,
                        margin: EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: this.submitted? MaterialStatePropertyAll( Color.fromRGBO(255, 215, 0, 1)
                                ) :MaterialStateProperty.all( Color.fromRGBO(255, 215, 0, 1)
                                )
                            ),
                            onPressed: this.submitted ? (){} : ()async{

                              int C = int.parse(this.Currency);
                              if(this.amount == ""){
                                return showDialog(context: context, builder: (context){

                                  return AlertDialog(
                                    backgroundColor: Colors.deepPurple,
                                    content: Text("Please Enter an Amount",style: TextStyle(color: Colors.white70 , fontSize: 20),),
                                  );
                                });
                              }
                              int A = int.parse(this.amount);

                              if(C < A ){
                                return showDialog(context: context, builder: (context){
                                  return AlertDialog(
                                    backgroundColor: Colors.deepPurple,
                                    content: Text("Insufficient Funds",style: TextStyle(color: Colors.white70 , fontSize: 20),),
                                  );
                                });
                              }
                              if( this.open.length ==0 || this.amount.length ==0 ){
                                return showDialog(context: context, builder: (context){
                                  return  AlertDialog(
                                    backgroundColor: Colors.deepPurple,
                                    content: Text("Please Enter all the fields",style: TextStyle(color: Colors.white70 , fontSize: 20),),
                                  );
                                });

                              }
                              else if(this.value == -1 && !(a==-2 || a==2)){
                                if(this.Type == 'Main') {
                                  return showDialog(
                                      context: context, builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.deepPurple,
                                      content: Text(
                                        "Please Enter all the field",
                                        style: TextStyle(color: Colors.white70,
                                            fontSize: 20),),
                                    );
                                  });
                                }
                              }
                              else if(a<0 && this.close == 0){
                                return showDialog(context: context, builder: (context){
                                  return  AlertDialog(
                                    backgroundColor: Colors.deepPurple,
                                    content: Text("Please Enter all the fields ",style: TextStyle(color: Colors.white70 , fontSize: 20),),
                                  );
                                });

                              }
                              if(int.parse(this.amount)<10){
                                return showDialog(context: context, builder: (context){
                                  return  AlertDialog(
                                    backgroundColor: Colors.deepPurple,
                                    content: Text("Minimum Bid amount should be 10",style: TextStyle(color: Colors.white70 , fontSize: 20),),
                                  );
                                });

                              }
                              //
                              final CheckOpenSnap = await FirebaseFirestore.instance.collection("Games").doc(this.Id).get();
                              Map<String,dynamic>? CheckOpen = await CheckOpenSnap.data();
                              if(int.parse(CheckOpen!["Opening"].toString().substring(0,2))< DateTime.now().hour && value == 1 ){
                                return showDialog(context: context, builder: (context){
                                  return  AlertDialog(
                                    backgroundColor: Colors.deepPurple,
                                    content: Text("Open Session Time is over",style: TextStyle(color: Colors.white70 , fontSize: 20),),
                                  );
                                });
                              }
                              else if(int.parse(CheckOpen!["Opening"].toString().substring(0,2))==DateTime.now().hour && value == 1){
                                if(int.parse(CheckOpen!["Opening"].toString().substring(3,5))<DateTime.now().minute && value == 1){
                                  return showDialog(context: context, builder: (context){
                                    return  AlertDialog(
                                      backgroundColor: Colors.deepPurple,
                                      content: Text("Open Session Time is over",style: TextStyle(color: Colors.white70 , fontSize: 20),),
                                    );
                                  });
                                }
                              }
                              if(int.parse(CheckOpen!["Closing"].toString().substring(0,2)) < DateTime.now().hour && value == 2 ){
                                return showDialog(context: context, builder: (context){
                                  return  AlertDialog(
                                    backgroundColor: Colors.deepPurple,
                                    content: Text("Close Session Time is over",style: TextStyle(color: Colors.white70 , fontSize: 20),),
                                  );
                                });
                              }
                              else if(int.parse(CheckOpen!["Closing"].toString().substring(0,2))==DateTime.now().hour && value == 2){
                                if(int.parse(CheckOpen!["Closing"].toString().substring(3,5))<DateTime.now().minute && value == 2){
                                  return showDialog(context: context, builder: (context){
                                    return  AlertDialog(
                                      backgroundColor: Colors.deepPurple,
                                      content: Text("Close Session Time is over",style: TextStyle(color: Colors.white70 , fontSize: 20),),
                                    );
                                  });
                                }
                              }
                              if(int.parse(CheckOpen!["Closing"].toString().substring(0,2))< DateTime.now().hour  ){
                                return showDialog(context: context, builder: (context){
                                  return  AlertDialog(
                                    backgroundColor: Colors.deepPurple,
                                    content: Text("Game Time is over",style: TextStyle(color: Colors.white70 , fontSize: 20),),
                                  );
                                });
                              }
                              else if(int.parse(CheckOpen!["Closing"].toString().substring(0,2))==DateTime.now().hour ){
                                if(int.parse(CheckOpen!["Closing"].toString().substring(3,5))<DateTime.now().minute ){
                                  return showDialog(context: context, builder: (context){
                                    return  AlertDialog(
                                      backgroundColor: Colors.deepPurple,
                                      content: Text("Game Time is over",style: TextStyle(color: Colors.white70 , fontSize: 20),),
                                    );
                                  });
                                }
                              }

                              if(int.parse(CheckOpen!["Opening"].toString().substring(0,2))< DateTime.now().hour && (a==-2 || a==2) ){
                                return showDialog(context: context, builder: (context){
                                  return  AlertDialog(
                                    backgroundColor: Colors.deepPurple,
                                    content: Text("Open Session Time is over for Full Sangam and Jodi Digit",style: TextStyle(color: Colors.white70 , fontSize: 20),),
                                  );
                                });
                              }
                              else if (int.parse(CheckOpen!["Opening"].toString().substring(0,2))==DateTime.now().hour && (a==-2 || a==2) ){
                                if(int.parse(CheckOpen!["Opening"].toString().substring(3,5))< DateTime.now().minute && (a==-2 || a==2) ){
                                  return showDialog(context: context, builder: (context){
                                    return  AlertDialog(
                                      backgroundColor: Colors.deepPurple,
                                      content: Text("Open Session Time is over",style: TextStyle(color: Colors.white70 , fontSize: 20),),
                                    );
                                  });
                                }
                              }
                              //
                              String session = this.value == 1 ? "Open" : "Close";
                              String type = a == 1 ? "Single Digit"  : a==2 ?  "Jodi Digit": a ==3 ? "Single Panna" : a==4 ? "Double Panna" : a==5?  "Triple Panna" : a==-1 ? "Half Sangam" :  a==-2? "Full Sangam" : "";
                              if(this.Type == 'Starline'){
                                this.Name = "Starline: " + this.Name ;
                                session = "";
                              }
                              if(this.Type == 'Market'){
                                this.Name = "Gali Market: " + this.Name ;
                                session = "";
                              }
                              this.statement = "Session: " + session + ", Type: ${type}" ", Opening Number: ${this.open}" + this.close+ ", Amount: " + this.amount ;
                              // final UId = RandomGenerator.generateRandomString(10);
                              // final docuser = await FirebaseFirestore.instance.collection("Games").doc(this.Id).collection("Users").doc(UId);
                              // final Historyplayed = await FirebaseFirestore.instance.collection("Users").doc(widget.UserPhone).collection("History").doc(UId);
                              // final Userdetails = await FirebaseFirestore.instance.collection("Users").doc(widget.UserPhone).get();
                              // final User = await Userdetails.data();
                              final date = await DateTime.now().day.toString() + "-"+ DateTime.now().month.toString() +"-"+ DateTime.now().year.toString();
                              Bet tempBet= Bet(Name: Name, Amount: this.amount, Open: this.open, Close: this.close, Bid: this.amount , Type: Type, Id: Id, Date: date, Session: session , Mode: type);
                                widget.bets.add(tempBet);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Multi(bets: widget.bets,Name: this.Name ,userPhone: widget.UserPhone,type: this.Type,Id: this.Id,)));
                            },
                            child: Text("Add a Bet ", style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w500),)
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
class RandomGenerator{
  static String generateRandomString(int lengthOfString) {
    final random = Random();
    const allChars = 'AaBbCcDdlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1EeFfGgHhIiJjKkL234567890';
    // below statement will generate a random string of length using the characters
    // and length provided to it
    final randomString = List.generate(lengthOfString,
            (index) => allChars[random.nextInt(allChars.length)]).join();
    return randomString;
  }// return the generated string
}

