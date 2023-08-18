import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Game.dart';
import 'Carde.dart';
import 'package:lottie/lottie.dart';

class Starline extends StatefulWidget {
   Starline({required this.Currency,required this.Phone});
String Currency;
String Phone;
  @override
  State<Starline> createState() => _StarlineState();
}

class _StarlineState extends State<Starline> {
  @override
  Stream<List<Game>> Steamer(){
    return FirebaseFirestore.instance.collection("Games").snapshots().map((event) => event.docs.map((e) => Game.fromJson(e.data())).toList());


  }
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
          title: Text("Starline Games",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,),),
          foregroundColor: Colors.black,
          actions: [
            const Icon(Icons.account_balance_wallet_rounded , color: Colors.black,),
            SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
            Container(
                alignment: Alignment.centerLeft,
                child: Text(widget.Currency,style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 20,color: Colors.black),)),
            SizedBox(width: MediaQuery.of(context).size.width * 0.03,)
          ],
          backgroundColor: Colors.blue,

      ),
      body: Stack(
        children: [
          Image(image: AssetImage('images/paymentBG.png'),fit: BoxFit.cover,height: MediaQuery.of(context).size.height * 1,),
          ListView(
            children: [
              Container(
                padding: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('images/paymentBG.png')
                    )
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.height * 0.23,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black,Color.fromRGBO(54, 34, 102, 0.9),Color.fromRGBO(54, 56, 102, 0.3)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter
                      )
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                      Row(
                        children: [
                          SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                          Text("Single Digit", style: TextStyle(color: Colors.white,fontSize: 18),),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.45,),
                          Text("10-100",style: TextStyle(color: Colors.white,fontSize: 18),)
                        ],
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                      Row(
                        children: [
                          SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                          Text("Single Panna", style: TextStyle(color: Colors.white,fontSize: 18),),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.42,),
                          Text("10-1400",style: TextStyle(color: Colors.white,fontSize: 18),)
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                      Row(
                        children: [
                          SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                          Text("Double Panna", style: TextStyle(color: Colors.white,fontSize: 18),),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.4,),
                          Text("10-2800",style: TextStyle(color: Colors.white,fontSize: 18),),

                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                      Row(
                        children: [
                          SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                          Text("Triple Panna", style: TextStyle(color: Colors.white,fontSize: 18),),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.43,),
                          Text("10-7000",style: TextStyle(color: Colors.white,fontSize: 18),)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('images/ab.png')
                    )
                ),
                child: StreamBuilder<List<Game>>(
                    stream: Steamer(),
                    builder: (context,snapshots){
                      if(snapshots.hasData){
                        final games = snapshots.data;

                        try {
                          games!.sort((e1, e2) {
                            if (e1.Opening.substring(0, 2) !=
                                e2.Opening.substring(0, 2)) {
                              return int.parse(
                                  e1.Opening.substring(0, 2))
                                  .compareTo(int.parse(
                                  e2.Opening.substring(0, 2)));
                            }

                            return int.parse(
                                e1.Opening.substring(3, 5))
                                .compareTo(int.parse(
                                e2.Opening.substring(3, 5)));
                          }
                          );}
                        catch(e){
                          print("hello ");
                        }
                        return ListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: games!.map(
                                  (e) {
                                return  e.Type == 'Starline' ? Carde(Name: e.Name, Random: e.Random, Closing: e.Closing, Opening: e.Opening, Status: e.Status,Id: e.Id, i: 0,UserPhone: widget.Phone,Type: e.Type,activated: true,) : SizedBox();
                              }
                          ).toList(),
                        );

                      }
                      else {
                        return Container(
                            height: MediaQuery.of(context).size.height *0.8 ,child: Lottie.asset("assets/Goldion.json"));                  }
                    }
                ),
              )

            ],
          ),
        ],
      )

    );
  }
}
