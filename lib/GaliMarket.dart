import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Game.dart';
import 'Carde.dart';
import 'package:lottie/lottie.dart';



class Gali extends StatefulWidget {
String Phone ;
String Currency;
Gali({required this.Phone ,required this.Currency});
  @override
  State<Gali> createState() => _GaliState();
}

class _GaliState extends State<Gali> {
  @override
  Stream<List<Game>> Steamer(){
    return FirebaseFirestore.instance.collection("Games").snapshots().map((event) => event.docs.map((e) => Game.fromJson(e.data())).toList());


  }
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
              title: Text("Gali Market",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,),),
              foregroundColor: Colors.black,
              actions: [
                const Icon(Icons.account_balance_wallet_rounded , color: Colors.black,),
                SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(widget.Currency,style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 20,color: Colors.black),)),
                SizedBox(width: MediaQuery.of(context).size.width * 0.03,)
              ],
              backgroundColor: Colors.lightBlueAccent
,


          ),
      backgroundColor: Colors.black,
      body: ListView(
        children: [

          Container(
            width: double.infinity,

            child: Container(
              child: StreamBuilder<List<Game>>(
                  stream: Steamer(),
                  builder: (context,snapshots){
                    if(snapshots.hasData){
                      final games = snapshots.data;
                      if(games![0].Opening.length > 5){
                        games!.sort((e1,e2)=> int.parse(e1.Opening.substring(3,5)).compareTo(int.parse(e2.Opening.substring(3,5))));
                        games!.sort((e1,e2)=> int.parse(e1.Opening.substring(0,2)).compareTo(int.parse(e2.Opening.substring(0,2))));
                      }
                      return ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: games!.map(
                                (e) {
                              return  e.Type == 'Market' ? Carde(Name: e.Name, Random: e.Random, Closing: e.Closing, Opening: e.Opening, Status: e.Status,Id: e.Id, i: 0,UserPhone: widget.Phone,Type: e.Type,activated: true,) : SizedBox();
                            }
                        ).toList(),
                      );

                    }
                    else {
                      return Container(
                          height: MediaQuery.of(context).size.height *0.8 ,child: Lottie.asset("assets/Goldion.json"));                    }
                  }
              ),
            ),
          )

        ],
      ),

    );
  }
}
