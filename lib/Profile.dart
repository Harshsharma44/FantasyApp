import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  bool activated;
  Profile({required this.UserPhone , required this.activated});
  String UserPhone;
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String Name = "";
  String Phone = "";
  String Balance = "";
  intialiser()async{
    final BalanceUser = await FirebaseFirestore.instance.collection("Amounts").doc(widget.UserPhone).get();
    final ProfileUser = await FirebaseFirestore.instance.collection("Users").doc(widget.UserPhone).get();
    Map<String,dynamic>? up = await ProfileUser.data();
    Map<String,dynamic>? mp = await BalanceUser.data();
    setState(() {
      Balance = mp!["Amount"];
      Name = up!["Name"];
      Phone = widget.UserPhone;

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    intialiser();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
          appBar: AppBar(
              title: Text("My Profile",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,),),
              foregroundColor: Colors.black,

              backgroundColor: Colors.lightBlueAccent


          ),
          body: ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.92,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/paymentBG.png'),
                        fit: BoxFit.cover
                    )

                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20 , left: 10 , right: 10),
                      height: MediaQuery.of(context).size.height * 0.75,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(

                          colors: [
      //
                       Color.fromRGBO(255, 255, 255, 0.24),
                        Color.fromRGBO(255, 255, 255, 0.06)
                  ]
                        )

                      ),
                      child: Column(
                        children: [
                          Container(
                              padding: EdgeInsets.all(20),
                              height: MediaQuery.of(context).size.height * 0.089,
                              width: MediaQuery.of(context).size.width * 0.89,
                              child: Center(child: Text("PROFILE",style: TextStyle(fontSize: 25,color: Colors.white),))),
                          Container(
                            padding: EdgeInsets.all(20),
                            height: MediaQuery.of(context).size.height * 0.089,
                            width: MediaQuery.of(context).size.width * 0.89,
                           child:  Row(
                             children: [
                               SizedBox(width: MediaQuery.of(context).size.width * 0.18,),
                               const  Text("Name:" , style: TextStyle(fontSize: 24 ,color: Colors.white, fontWeight: FontWeight.w500),),
                               SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                               Text(this.Name , style: TextStyle(fontSize: 24 ,color: Colors.white, fontWeight: FontWeight.w500),),

                             ],
                           )),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.034,),
                          Container(
                              padding: EdgeInsets.all(20),
                              height: MediaQuery.of(context).size.height * 0.089,
                              width: MediaQuery.of(context).size.width * 0.89,
                              child:  Row(
                                children: [
                                  SizedBox(width: MediaQuery.of(context).size.width * 0.18,),
                                  const  Text( "Phone:", style: TextStyle(fontSize: 24 ,color: Colors.white, fontWeight: FontWeight.w500),),
                                  SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                                  Text( Phone, style: TextStyle(fontSize: 24 ,color: Colors.white, fontWeight: FontWeight.w500),),

                                ],
                              )),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.034,),
                          widget.activated ? Container(
                              padding: EdgeInsets.all(20),

                              height: MediaQuery.of(context).size.height * 0.089,
                              width: MediaQuery.of(context).size.width * 0.89,
                              child:  Row(
                                children: [
                                  SizedBox(width: MediaQuery.of(context).size.width * 0.18,),
                                  const   Text("Balance:" , style: TextStyle(fontSize: 24 ,color: Colors.white, fontWeight: FontWeight.w500),),
                                  SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                               const   Icon(Icons.currency_rupee_rounded , color: Colors.white,),
                                  Text( this.Balance, style: TextStyle(fontSize: 24 ,color: Colors.white, fontWeight: FontWeight.w500),),

                                ],
                              )) : SizedBox(),

                        ],

                      ),
                    ),
                  ],
                ),
              )

            ],
          ),
        );
  }
}
