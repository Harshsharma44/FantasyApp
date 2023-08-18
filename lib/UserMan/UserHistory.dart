import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';

class History extends StatefulWidget {
String UserPhone;
History({required this.UserPhone});
  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  String searchKey = "";

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.black,
          appBar: AppBar(
        title: Text("Game History",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,),),
    foregroundColor: Colors.black,
            backgroundColor:  Colors.blue,
    ),
          body: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(6),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlueAccent)
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlueAccent)
                    ),
                    hintText: "Search by Game Name/Type/ Date",
                    hintStyle: TextStyle(color: Colors.white70)
                  ),
                  style: TextStyle(color: Colors.white),
                  textInputAction: TextInputAction.search,
                  onChanged: (val){
                    setState(() {
                      this.searchKey = val;
                    });
                  },

                ),
              ),
              Container(
               decoration: BoxDecoration(

               ),
               child: StreamBuilder<List<Map<String,dynamic>>>(
                   stream: FirebaseFirestore.instance.collection("Users").doc(widget.UserPhone).collection("History").snapshots().map((event) => event.docs.map((e) => e.data()).toList()),
                   builder: (context,snap){
                       if(snap.hasError){
                         return Text("No Data is available");
                       }
                       if(!snap.hasData){
                         return Container(
                           alignment: Alignment.center,
                             height: MediaQuery.of(context).size.height * 0.9,

                             child: Lottie.asset("assets/Goldion.json"));
                       }
                       List<Map<String,dynamic>>? datas =  snap.data;
                       datas!.sort((e1,e2){
                         int i1= 0 ;
                         int j1= 0 ;
                         int i= 0 ;
                         int j = 0 ;
                         int n1 = 0 ;
                         int n2 =0 ;
                         String s1= e1["Date"];
                         String s2 = e2["Date"];
                         while(s1[i]!='-'|| n1 != 1){
                           if(s1[i]=='-'){
                             i1 = i ;
                             n1 = 1 ;
                           }
                           i++;
                         }
                         while(s2[j]!='-' || n2 !=1 ){
                           if(s2[j]=='-'){
                             j1 = j ;
                             n2 = 1 ;
                           }
                           j++;
                         }
                         int  a= int.parse(s1.substring(i+1));
                         int  b = int.parse(s2.substring(j+1));

                         if(a==b){
                           a= int.parse(s1.substring(i1+1,i));
                           b = int.parse(s2.substring(j1+1,j));
                         }
                         if(a==b){
                           a= int.parse(s1.substring(0,i1));
                           b = int.parse(s2.substring(0,j1));
                         }

                         return a.compareTo(b);
                       });
                     return  ListView(
                       reverse: true,
                         shrinkWrap: true,
                         physics: NeverScrollableScrollPhysics(),
                         children: datas!.map((e) {
                           if(searchKey=="" || e["Date"].toString().contains(searchKey) || e["Game"].toString().contains(searchKey) || e["Type"].toString().contains(searchKey) ){
                             return Container(
                           height: MediaQuery.of(context).size.height * 0.18,
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
                               Text("Game: " +e["Game"].toString() ,style: TextStyle(color: Colors.white ,fontWeight: FontWeight.w500,fontSize: 18 ),),
                               SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                               Row(
                                 children: [
                                   SizedBox(width: MediaQuery.of(context).size.width * 0.14,),
                                   Text("Bid Digit: " +e["Opening"] + "-" + e["Closing"].toString() ,style: TextStyle(color: Colors.white ,fontWeight: FontWeight.w500,fontSize: 18 ),),
                                   SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                                   Text("Date: " +e["Date"].toString() ,style: TextStyle(color: Colors.white ,fontWeight: FontWeight.w500,fontSize: 18 ),),
                                 ],
                               ),
                               SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                               Text("Bid Points: " +e["Amount"].toString() ,style: TextStyle(color: Colors.white ,fontWeight: FontWeight.w500,fontSize: 18 ),),
                               SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                               Row(
                                 children: [
                                   SizedBox(width: MediaQuery.of(context).size.width * 0.14,),
                                   Text("Session: " +e["Session"].toString() ,style: TextStyle(color: Colors.white ,fontWeight: FontWeight.w500,fontSize: 18 ),),
                                   SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                                   Text("Type: " +e["Type"].toString() ,style: TextStyle(color: Colors.white ,fontWeight: FontWeight.w500,fontSize: 18 ),),
                                 ],
                               ),


                             ],
                           ),
                         );
                   }
                           return SizedBox();
                  }
                         ).toList(),
                       );


                   }
               ),
             )

            ],
          ),
        );
  }
}
