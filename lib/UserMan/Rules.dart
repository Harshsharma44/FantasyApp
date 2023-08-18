import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Rules extends StatelessWidget {
  const Rules({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  color:Colors.lightBlueAccent,
                ),
                height: MediaQuery.of(context).size.height * 0.069,
                child: Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                    IconButton(

                        onPressed: (){
                          Navigator.pop(context);
                        }, icon: Icon(
                      Icons.arrow_back_outlined,
                      color: Colors.black,
                      size: MediaQuery.of(context).size.height * 0.038,
                    )),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                    const Text("Rules and Regulations",style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),),
                    ],
                ),
              ),
              Container(
              color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width * 0.95,
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                    Text("Welcome to Digital Matka Zone App",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 24,color: Colors.black),),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                    Text("Rules and Regulations ( नियम एवं शर्ते  )",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color: Colors.black),),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                    Text("1. Minimum Points Add 500 Hoga.(500 Point = 500 Rs)",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16,color: Colors.black,),),
                         SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                       Text("2. Minimum Money Withdrawal 1000 Rs Hoga .               ",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16,color: Colors.black,),),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                    Text("3. Add Points Request Karke Admin se Contact Jarur Kare (Contact Customer Support)",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16,color: Colors.black,),),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                    Text("4. Send your Bank Account Details PhonePe, Paytm and Google Pay Number for Withdrawal",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16,color: Colors.black,),),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                    Text("5. Please do not message for 30 mins after sending withdrawal request.",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16,color: Colors.black,),),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),






                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
