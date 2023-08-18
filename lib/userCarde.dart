import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";


class userCarde extends StatefulWidget {
 String Name ;
 String Phone ;
 String Session;
 String Open;
 String gameId ;
 String userId ;
 String Close ;
 String Amount;
 String Type;
 String Date ;
 userCarde({required this.Name , required this.Phone , required this.Session,required this.Type , required this.Amount , required this.Close , required this.Open , required this.Date , required this.gameId ,required this.userId });

  @override
  State<userCarde> createState() => _userCardeState();
}

class _userCardeState extends State<userCarde> {
  @override
  Widget build(BuildContext context) {
    return Container(
    margin: EdgeInsets.all(8),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(20)
    )

    ,
    // height: MediaQuery.of(context).size.height * 0.225,
    child: Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
        Row(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
            SizedBox(width: MediaQuery.of(context).size.width * 0.12,),
            Text("Phone: " + widget.Phone,style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
            SizedBox(width: MediaQuery.of(context).size.width * 0.10,),
             ElevatedButton(onPressed: (){
    showDialog(context: context, builder: (context){
    int amount = 0 ;
    if (widget.Type ==
    'Single Digit') {
    amount = amount + ((int.parse(widget.Amount) * 95)/10).toInt() ;
    }
    if (widget.Type ==
    'Jodi Digit') {
    amount = amount + int.parse(widget.Amount) * 95 ;
    }
    if (widget.Type ==
    'Single Panna') {
    amount = amount + int.parse(widget.Amount) * 140 ;
    }
    if (widget.Type ==
    'Double Panna') {
    amount = amount + int.parse(widget.Amount) * 280 ;

    }
    if (widget.Type ==
    'Triple Panna') {
    amount = amount + int.parse(widget.Amount) * 700;
    }
    if (widget.Type ==
    'Half Sangam') {
    amount = amount + int.parse(widget.Amount) * 1000 ;
    }
    if (widget.Type ==
    'Full Sangam') {
    amount = amount + int.parse(widget.Amount) * 10000;
    }
    return AlertDialog(
    backgroundColor: Colors.black,
    content: Text("Give Amount = " + amount.toString(),style: TextStyle(color: Colors.blue , fontWeight: FontWeight.bold , fontSize: 20),),
    );
    });
             }, child: Text("Possible Win Amount",style: TextStyle(color: Colors.white),),)
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
        Text(widget.Name , style: TextStyle(fontSize: 22 , fontWeight: FontWeight.w500),),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
        Row(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
            Expanded(child: Text("Session: ${widget.Session}",style: TextStyle(fontSize: 15 ),)),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
            Expanded(child: Text("Game Type: ${widget.Type}",style: TextStyle(fontSize: 15 ),)),
          ]
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
        Row(
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
              GestureDetector(
                  onTap: ()async{
                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        content:   TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (val){
                            setState(() {
                              widget.Open = val;
                            });
                          },
                        ),
                        title:   ElevatedButton(onPressed: ()async{
                          final docuser = await FirebaseFirestore.instance.collection("Games").doc(widget.gameId).collection("Users").doc(widget.userId);
                          final Historyplayed = await FirebaseFirestore.instance.collection("Users").doc(widget.Phone).collection("History").doc(widget.userId);
                          docuser.update(
                              {
                                "Open": widget.Open
                              }
                          );
                          Historyplayed.update(
                              {
                                "Opening": widget.Open
                              }
                          );
                          Navigator.pop(context);
                        }, child: Text("Submit")),


                      );
                    });
                  },
                  child: Text("Open Panna/Ank: ${widget.Open}",style: TextStyle(fontSize: 15 ,fontWeight: FontWeight.bold),)),
              SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
              GestureDetector(
                  onTap: ()async{
                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                          content:   TextField(
                            keyboardType: TextInputType.number,
                                onChanged: (val){
                                  setState(() {
                                    widget.Close = val;
                                  });
                                },
                              ),
                        title:   ElevatedButton(onPressed: ()async{
                          final docuser = await FirebaseFirestore.instance.collection("Games").doc(widget.gameId).collection("Users").doc(widget.userId);
                          final Historyplayed = await FirebaseFirestore.instance.collection("Users").doc(widget.Phone).collection("History").doc(widget.userId);
                          docuser.update(
                              {
                                "Close": widget.Close
                              }
                          );
                          Historyplayed.update(
                              {
                                "Closing": widget.Close
                              }
                          );
                          Navigator.pop(context);
                        }, child: Text("Submit")),


                      );
                    });
                  },
                  child: Text("Close Panna: ${widget.Close}",style: TextStyle(fontSize: 15 ,fontWeight: FontWeight.bold),))          ,
              SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
              Expanded(child: GestureDetector(child: Text("Bid Point: ${int.parse(widget.Amount)}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),) , onTap: (){
                showDialog(context: context, builder: (context){
                  int amount = 0 ;
                  if (widget.Type ==
                      'Single Digit') {
                    amount = amount + int.parse(widget.Amount) * 10 ;
                  }
                  if (widget.Type ==
                      'Jodi Digit') {
                    amount = amount + int.parse(widget.Amount) * 95 ;
                  }
                  if (widget.Type ==
                      'Single Panna') {
                    amount = amount + int.parse(widget.Amount) * 140 ;
                  }
                  if (widget.Type ==
                      'Double Panna') {
                    amount = amount + int.parse(widget.Amount) * 280 ;

                  }
                  if (widget.Type ==
                      'Triple Panna') {
                    amount = amount + int.parse(widget.Amount) * 700;
                  }
                  if (widget.Type ==
                      'Half Sangam') {
                    amount = amount + int.parse(widget.Amount) * 1000 ;
                  }
                  if (widget.Type ==
                      'Full Sangam') {
                    amount = amount + int.parse(widget.Amount) * 10000;
                  }
                  return AlertDialog(
                    backgroundColor: Colors.black,
                   content: Text("Give Amount = " + amount.toString(),style: TextStyle(color: Colors.blue , fontWeight: FontWeight.bold , fontSize: 20),),
                  );
                });
              },),)
            ]
        ),        // Text(widget.Statement.substring(51),style: TextStyle(fontSize: 15 ),),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
        Text("Date: " + widget.Date , style:  TextStyle(fontSize: 20),),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01,),





      ],
    ),
  );
  }
}
