import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';



class Calendar extends StatefulWidget {
  String Id ;
  Calendar({required this.Id});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white12,
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
                color:  Colors.lightBlueAccent

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
                const Text("Result Chart",style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('images/ab.png')
              )
            ),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Games").doc(widget.Id).collection("Calendars").snapshots().map((event) => event.docs.map((e) => e.data()).toList()),
                builder: (context,snapshots){
                  if(snapshots.hasData){
                    List<Map<String,dynamic>>? calendars = snapshots.data;
                    calendars!.sort((e1,e2){
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
                    return GridView.builder(
                      reverse: true,
                      physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                      itemCount: calendars!.length,
                      itemBuilder: (ctx,index){
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:  Colors.lightBlueAccent
,

                        ),
                        margin: EdgeInsets.only(left: 10),
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Column(
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                            Text(calendars[index]["Date"],style: TextStyle(fontWeight: FontWeight.bold , color: Colors.black,fontSize: 20),),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                            Text(calendars[index]["Digits"],style: TextStyle(fontWeight: FontWeight.bold , color: Colors.black , fontSize: 16),),


                          ],
                        ),
                      );
                      }

                    );

                  }
                  else {
                    return Lottie.asset("assets/Goldion.json");
                  }
                }
            ),
          )

        ],
      ),
    ));
  }
}
