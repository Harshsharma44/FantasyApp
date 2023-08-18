import 'dart:async';

import 'package:flutter/material.dart';
import 'package:djdigital/MultiUserInput.dart';
import 'package:djdigital/multiGameSelection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'UserStatement.dart';


class Multi extends StatefulWidget {
List<Bet> bets ;
String type ;
String Name ;
String userPhone ;
String Id;
Multi({required this.bets , required this.type , required this.userPhone, required this.Name,required this.Id});
  @override
  State<Multi> createState() => _MultiState();
}

class _MultiState extends State<Multi> {
  String Currency = "";
  bool isCurrencyLoaded = false;
  bool lock = false ;
  Future<void> jj()async {
    final docUser = await FirebaseFirestore.instance.collection("Amounts").doc(
        widget.userPhone).get();
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
  }  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return await showDialog(context: context, builder: (cot){
          return AlertDialog(
            backgroundColor: Colors.deepPurple,
            title: Text("Are you sure ?",style: TextStyle(color: Colors.white),),
            content: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Column(
                children: [
                  Text("All Current Bid in the list will be cleared if you go ahead",style: TextStyle(color: Colors.white),),
                  Row(
                    children: [
                      ElevatedButton(onPressed: (){
                        Navigator.pop(cot);
                        Navigator.pop(context);
                      }, child: Text("Yes")),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
                      ElevatedButton(onPressed: (){
                        Navigator.pop(cot);
                      }, child: Text("No"))
                    ],
                  )
                ],
              ),
            ),
          );
        });
      },
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
       appBar: AppBar(
          title: Text(widget.Name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,),),
          actions: [
            const Icon(Icons.account_balance_wallet_rounded , color: Colors.white,),
            SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
            Container(
                alignment: Alignment.centerLeft,
                child: Text(this.Currency,style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 20,color: Colors.white),)),
            SizedBox(width: MediaQuery.of(context).size.width * 0.03,)
          ],
          backgroundColor: Color.fromRGBO(39,39,40, 1),


        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10 ,right: 10),
              child: Container(
                child: ElevatedButton(onPressed: ()async{
                  assert(this.lock == false );
                  this.lock = true;
                  int A = 0 ;
                  int C = int.parse(this.Currency);
                  widget.bets.forEach((element) {
                    A=  A + int.parse(element.Bid);
                  });
                  if(C<A){
                    return showDialog(context: context, builder: (cote){
                      this.lock = false ;
                      return AlertDialog(
                        backgroundColor: Colors.blueGrey,
                        content: Text("Insufficient funds!",style: TextStyle(fontSize: 18,color: Colors.white),),
                      );
                    }
                    );
                  }
                  C = C - A ;

                    await FirebaseFirestore.instance.collection(
                        "Amounts").doc(widget.userPhone).update({
                      "Amount": C.toString()
                    });

                    widget.bets.forEach((element)async {
                      final UId = RandomGenerator.generateRandomString(10);
                      final docuser = await FirebaseFirestore.instance.collection("Games").doc(widget.Id).collection("Users").doc(UId);
                      final Historyplayed = await FirebaseFirestore.instance.collection("Users").doc(widget.userPhone).collection("History").doc(UId);
                      final Userdetails = await FirebaseFirestore.instance.collection("Users").doc(widget.userPhone).get();
                      final User = await Userdetails.data();
                      final date = await DateTime.now().day.toString() + "-"+ DateTime.now().month.toString() +"-"+ DateTime.now().year.toString();
                         Historyplayed.set({
                          "Game": element.Name,
                          "Session": element.Session,
                          'Type': element.Mode,
                          'Opening': element.Open,
                          'Closing': element.Close,
                          'Amount': element.Bid,
                          "Date": date,
                          "Id": UId
                        });
                         docuser.set(UserStatement.ToJson(
                            UserStatement(Name: User!["Name"],
                                Phone: widget.userPhone,
                                Type: element.Mode,
                                Open: element.Open,
                                Close: element.Close,
                                Amount: element.Bid,
                                Session: element.Session,
                                Id: UId,
                                Date: date,
                                Distributed: "NO")));
                        print(UId);

                    });
                    Navigator.pop(context);
                    late BuildContext conte;
                  showDialog(context: context, builder: (cote){
                    conte = cote ;
                    this.lock = false ;
                    return AlertDialog(
                    backgroundColor: Colors.blueGrey,
                    content: Text("Bid Placed Successfully",style: TextStyle(fontSize: 18,color: Colors.white),),
                  );
                  }
                  );
                  Timer(Duration(seconds: 3),(){
                    Navigator.pop(conte);
                  });

                }, child: Text("Place Final Bid"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.red),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10 , right:  10),
              child: ElevatedButton(onPressed: (){
                int amount = 0 ;
                widget.bets.forEach((element) {
                  amount += int.parse(element.Bid);
                });
                showDialog(context: context, builder: (context)=> AlertDialog(
                  backgroundColor: Colors.blueGrey,
                  title: Text("Total Bid Amount is :",style: TextStyle(color: Colors.white70),),
                  content: Text(amount.toString(),style: TextStyle(color: Colors.white,fontSize: 18),),
                ));
              }, child: Text("Calculate Total Bid Amount"),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.red),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10 , right:  10),
              child: ElevatedButton(onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=> MultiGameSelection(Name: widget.Name, Id: widget.Id, UserPhone: widget.userPhone, Type: widget.type,bets: widget.bets,)));
              }, child: Text("Add a Bet"),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.red),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(left: 5,right: 5),
             itemCount: widget.bets.length,
             itemBuilder: (context,index){
                return  Container(
                  height: MediaQuery.of(context).size.height * 0.22,
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: EdgeInsets.only(top: 10,bottom: 10 , left: 5 , right: 5) ,
                  decoration: BoxDecoration(
                      boxShadow: [BoxShadow(spreadRadius: 1,blurRadius: 2,color: Colors.deepPurple,blurStyle: BlurStyle.solid)],
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [Colors.red,Colors.black,Colors.orange]
                      ),
                      borderRadius: BorderRadius.all(Radius.elliptical(50, 100))
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Game: " + widget.bets[index].Name ,style: TextStyle(color: Colors.white ,fontWeight: FontWeight.w500,fontSize: 18 ),),
                          IconButton(onPressed: (){
                         showDialog(context: context, builder: (cot)=> AlertDialog(
                           title: Text("This item will be deleted, are you sure?"),
                           content: Container(
                             height: MediaQuery.of(context).size.height * 0.1,
                             child: Row(
                                   children: [
                                     ElevatedButton(onPressed: (){
                                       Navigator.pop(cot);
                                       setState(() {
                                         widget.bets.removeAt(index);
                                       });
                                     }, child: Text("Yes")),
                                     SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
                                     ElevatedButton(onPressed: (){
                                       Navigator.pop(cot);
                                     }, child: Text("No"))
                                   ],
                                 )

                           ),
                         ));
                          }, icon: Icon(Icons.delete,color: Colors.white,)
                          )
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                      Row(
                        children: [
                          SizedBox(width: MediaQuery.of(context).size.width * 0.14,),
                          Text("Bid Digit: " +widget.bets[index].Open + "-" + widget.bets[index].Close.toString() ,style: TextStyle(color: Colors.white ,fontWeight: FontWeight.w500,fontSize: 18 ),),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                          Text("Date: " +widget.bets[index].Date ,style: TextStyle(color: Colors.white ,fontWeight: FontWeight.w500,fontSize: 18 ),),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Bid Points: " +widget.bets[index].Bid ,style: TextStyle(color: Colors.white ,fontWeight: FontWeight.w500,fontSize: 18 ),),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                          Text("Game Mode: " +widget.bets[index].Mode ,style: TextStyle(color: Colors.white ,fontWeight: FontWeight.w500,fontSize: 18 ),),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                      Row(
                        children: [
                          SizedBox(width: MediaQuery.of(context).size.width * 0.14,),
                          Text("Session: " +widget.bets[index].Session ,style: TextStyle(color: Colors.white ,fontWeight: FontWeight.w500,fontSize: 18 ),),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                          Text("Type: " + widget.bets[index].Type ,style: TextStyle(color: Colors.white ,fontWeight: FontWeight.w500,fontSize: 18 ),),
                        ],
                      ),


                    ],
                  ),
                );
             }
            ),
          ],
        ),
      ),
    );
  }
}

class Bet{
  String Name ;
  String Bid;
  String Open ;
  String Close ;
  String Amount ;
  String Type;
  String Mode;
  String Session;
  String Date ;
  String Id;
  Bet({required this.Name , required this.Amount ,required this.Open , required this.Close , required this.Bid ,required this.Type,required this.Id, required this.Date , required this.Session, required this.Mode});
}