import 'package:flutter/material.dart';

import 'Payments/Deposit.dart';
import 'Payments/Withdraw.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';


class AnimatingBg1 extends StatefulWidget {
  String UserPhone ;
  String Currency ;
  String Name ;
  AnimatingBg1({required this.UserPhone , required this.Currency,required this.Name });
  @override
  _AnimatingBg1State createState() => _AnimatingBg1State();
}

class _AnimatingBg1State extends State<AnimatingBg1>
    with TickerProviderStateMixin {


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color:   Colors.lightBlueAccent
,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 1,
           width: double.infinity,
           child: Column(
             children: [
               Container(
                 height: MediaQuery.of(context).size.height * 0.1,
                 width: MediaQuery.of(context).size.width * 1,
                 child: ElevatedButton(onPressed: (){
                   Navigator.pop(context);
                 },
                   child: Row(
                     children: [
                       Icon(Icons.arrow_back_ios_new_sharp,size: 30,color: Colors.black,),
                       SizedBox(width: 25,),
                       Text("Back" , style: TextStyle(fontSize: 26,color: Colors.black),),
                     ],
                   ),
                   style: ButtonStyle(
                       backgroundColor: MaterialStateProperty.all(  Colors.lightBlueAccent
,)
                   ),

                 ),
               ),
               SizedBox(height: MediaQuery.of(context).size.height * 0.2,),
               Container(
                 height: MediaQuery.of(context).size.height * 0.14,
                 width: MediaQuery.of(context).size.width * 0.97,
                 child: ElevatedButton(onPressed: ()async{
                   final docUser = await FirebaseFirestore.instance.collection("Amounts").doc(widget.UserPhone).get();
                   Map<String,dynamic>? mp = await docUser.data();
                   String Name = mp!['Name'];
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Deposit(UserPhone: widget.UserPhone, Currency: widget.Currency,Name: Name,)));
                 },
                child: Text("ADD POINTS" , style: TextStyle(fontSize: 20,color: Colors.black),),
                   style: ButtonStyle(
                     backgroundColor: MaterialStateProperty.all(  Colors.lightBlueAccent
,)
                   ),

                 ),
               ),
               SizedBox(height: MediaQuery.of(context).size.height * 0.2,),
               Container(
                 height: MediaQuery.of(context).size.height * 0.14,
                 width: MediaQuery.of(context).size.width* 0.97,
                 child: ElevatedButton(onPressed: ()async{
                   final docUser = await FirebaseFirestore.instance.collection("Amounts").doc(widget.UserPhone).get();
                   Map<String,dynamic>? mp = await docUser.data();
                   String Name = mp!['Name'];
                   Navigator.push(context, MaterialPageRoute(builder: (context)=> Withdraw(UserPhone: widget.UserPhone, Currency: widget.Currency,Name: Name,)));
                 },
                   child: Text("WITHDRAW" , style: TextStyle(fontSize: 20,color: Colors.black),),
                   style: ButtonStyle(
                       backgroundColor: MaterialStateProperty.all(  Colors.lightBlueAccent
,)
                   ),

                 ),
               ),

             ],
           ),
          )
        ),
      ),
    );
  }
}