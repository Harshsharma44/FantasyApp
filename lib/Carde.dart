// It is not a helper it is used just for UI simplicity we pass carde in stream side hahahhaah
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:djdigital/Admin%20Panel.dart';
import 'package:djdigital/GameSelection.dart';
import 'UserInput.dart';
import 'Calendar.dart';

class Carde extends StatelessWidget {
String Name;
String Opening ;
String Closing ;
String Random ;
bool Status ;
String tempOpening = "";
String tempClosing = "";
String UserPhone;
int i ;
String Type;
bool activated;
String Id;
Carde({required this.Name , required this.Random , required this.Closing , required this.Opening ,  required this.Status ,required this.Id ,required this.i,required this.UserPhone,required this.Type,required this.activated});

  @override
  void okay(){
    if(this.Opening.length >= 2){
      int open = int.parse(this.Opening.substring(0,2));
      String time = " AM";
      if(open==12){
        time = " PM";
      }
      else if(open>12){
        open = open%12;
        time = " PM";
      }
      this.tempOpening = open.toString() + ":" + this.Opening.substring(3) + time;
    }
    if(this.Closing.length >= 2){
      int close = int.parse(this.Closing.substring(0,2));
      String time = " AM";
      if(close==12){
        time = " PM";
      }
      else if(close>12){
        close = close%12;
        time = " PM";
      }
      print(this.Closing.substring(2));
     this.tempClosing = close.toString() +":"  + this.Closing.substring(3) + time;
    }
}
  final key = GlobalKey();
  Widget build(BuildContext context) {
    okay();
     return this.Type != 'Market' ? Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
       borderRadius: BorderRadius.only(topLeft: Radius.elliptical(80, 50) , bottomRight: Radius.elliptical(80, 50)),
        // image: DecorationImage(
        //   image: AssetImage('images/ab.png'),
        //   fit: BoxFit.cover
        // )
        color: Colors.black
      ),
      height: MediaQuery.of(context).size.height * 0.16,
      margin: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
          Padding(
            padding: const EdgeInsets.only(right: 150),
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20)
              ),
                child: Text(this.Name , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.w600 , color: Colors.white , shadows: [Shadow(color: Colors.red , blurRadius: 60 )]),)),
          ),
          Row(
            children: [
              SizedBox(width: MediaQuery.of(context).size.width *0.02,),
              GestureDetector(
                  onTap: (){
                    i==0? Navigator.push(context, MaterialPageRoute(builder: (context)=> Calendar(Id: this.Id,))) : showDialog(context: context, builder: (context){
                      return AlertDialog(
                          title: Text("Do you want to upload current Game Digits on the calendar?"),
                          content: Row(
                            children: [
                              GestureDetector(onTap: ()async{
                                String date = await DateTime.now().day.toString() + "-"+ DateTime.now().month.toString() +"-"+ DateTime.now().year.toString();
                                final CalendarUser = await FirebaseFirestore.instance.collection("Games").doc(this.Id).collection("Calendars").doc(date);
                                await CalendarUser.set({
                                  "Date": date,
                                  "Digits": this.Random,
                                });

                                Navigator.pop(context);
                              }, child: Text("Yes Upload it!")),
                              SizedBox(width: MediaQuery.of(context).size.width *0.2,),
                              ElevatedButton(onPressed: (){
                                Navigator.pop(context);

                              }, child: Text("No"))
                            ],
                          )
                      );
                    });
                  },
                  child:   Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                          image: AssetImage('images/Calendar.png'),
                          fit: BoxFit.cover
                        )
                      ),
                      height: MediaQuery.of(context).size.height * 0.04,
                    width:  MediaQuery.of(context).size.width * 0.18,
                      )
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.01),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.green
                ),
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    this.Type == 'Main' ? this.Random.length>=4? Text(this.Random.substring(0,4),style: TextStyle(fontSize: 17,color: Colors.white),) : Text(this.Random , style: TextStyle(fontSize: 17 , color: Colors.red)): Text(this.Random , style: TextStyle(fontSize: 17 , color: Colors.white),),
                    this.Type == 'Main' ? this.Random.length>=6? Text(this.Random.substring(4,6),style: TextStyle(fontSize: 17,color: Colors.black),): Text("") : Text(""),
                    this.Type == 'Main' ? this.Random.length>=7? Text(this.Random.substring(6),style: TextStyle(fontSize: 17,color: Colors.white),): Text(""): Text(""),
                  ],
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              this.activated   ?  (this.Status  && !(DateTime.now().weekday == 7 && (this.Name.toLowerCase() == 'Madhur Night'.toLowerCase() || this.Name.toLowerCase() == 'Main bazar'.toLowerCase() ||this.Name.toLowerCase() == 'Kalyan'.toLowerCase() || this.Name.toLowerCase() == 'Milan Day'.toLowerCase() ||   this.Name.toLowerCase() == 'Milan Night'.toLowerCase() ||this.Name.toLowerCase() == 'Time Bazar'.toLowerCase() || this.Name.toLowerCase() == 'rajdhani day'.toLowerCase() || this.Name.toLowerCase() == 'kalyan night'.toLowerCase() || this.Name.toLowerCase() == 'Rajdhani night'.toLowerCase() )) && !(DateTime.now().weekday == 6 &&( this.Name.toLowerCase() == 'Kalyan Night'.toLowerCase() ||   this.Name.toLowerCase() == 'Rajdhani Night'.toLowerCase() ||this.Name.toLowerCase() == 'Main Bazar'.toLowerCase()  ))  && int.parse(Closing.substring(0,2)) > DateTime.now().hour) || i == 1 ||(int.parse(Closing.substring(3,5)) > DateTime.now().minute && int.parse(Closing.substring(0,2)) == DateTime.now().hour ) ?  InkWell(
                onTap: (){
                  i == 0 ? this.Type != 'Market'? Navigator.push(context, MaterialPageRoute(builder: (context)=> GameSelection(Name: this.Name, Id: this.Id,UserPhone: this.UserPhone,Type: this.Type,))) : Navigator.push(context, MaterialPageRoute(builder: (context)=>UserInput(Id: this.Id, Name: this.Name, a: 2,UserPhone: this.UserPhone,Type: this.Type,))) :
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> showAllStatement(Id: this.Id,)));
                },
                splashColor: Colors.yellowAccent,
                radius: 200,
                child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(20) , topLeft: Radius.circular(20)),
                          image: DecorationImage(
                            image: AssetImage('images/play.png'),
                            fit: BoxFit.cover
                          ),
                          // boxShadow: [BoxShadow(color: Colors.greenAccent,blurRadius: 20)]
                      ),
                      width: MediaQuery.of(context).size.width * 0.17,
                      height: MediaQuery.of(context).size.height * 0.07,

                ),
              ): InkWell(
                splashColor: Colors.yellowAccent,
                radius: 200,
                child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(20) , topLeft: Radius.circular(20)),
                          image: DecorationImage(
                              image: AssetImage('images/close.png'),
                              fit: BoxFit.cover
                          ),
                          // boxShadow: [BoxShadow(color: Colors.redAccent,blurRadius: 20)]
                      ),
                      width: MediaQuery.of(context).size.width * 0.18,
                      height: MediaQuery.of(context).size.height * 0.075,

                    )
              ) : SizedBox(),
              this.activated   ?        Container(
                  padding: EdgeInsets.only(left: 5,right: 5),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: (this.Status  && !(DateTime.now().weekday == 7 && (this.Name.toLowerCase() == 'Madhur Night'.toLowerCase() || this.Name.toLowerCase() == 'Main bazar'.toLowerCase() ||this.Name.toLowerCase() == 'Kalyan'.toLowerCase() || this.Name.toLowerCase() == 'Milan Day'.toLowerCase() ||   this.Name.toLowerCase() == 'Milan Night'.toLowerCase() ||this.Name.toLowerCase() == 'Time Bazar'.toLowerCase() || this.Name.toLowerCase() == 'rajdhani day'.toLowerCase() || this.Name.toLowerCase() == 'kalyan night'.toLowerCase() || this.Name.toLowerCase() == 'Rajdhani night'.toLowerCase() )) && !(DateTime.now().weekday == 6 &&( this.Name.toLowerCase() == 'Kalyan Night'.toLowerCase() ||   this.Name.toLowerCase() == 'Rajdhani Night'.toLowerCase() ||this.Name.toLowerCase() == 'Main Bazar'.toLowerCase()  ))  && int.parse(Closing.substring(0,2)) > DateTime.now().hour) || i == 1 ||(int.parse(Closing.substring(3,5)) > DateTime.now().minute && int.parse(Closing.substring(0,2)) == DateTime.now().hour )? Text("PLAY",style: TextStyle(color: Colors.greenAccent,fontSize: 12),) :Text("CLOSED",style: TextStyle(color: Colors.greenAccent,fontSize: 12),) )   : SizedBox()
            ]
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
          Row(
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
              SizedBox(width: MediaQuery.of(context).size.width * 0.07,),
              Container(
               width: MediaQuery.of(context).size.width * 0.7,
               child: Row(
                 children: [
                   this.Type == 'Main'? Expanded(child: Text("Open Time: "+ this.tempOpening,style: TextStyle(fontSize: 12,color: Colors.white),)): SizedBox(),
                   SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                   this.Type == 'Main'? Expanded(child: Text("Close Time: "+ this.tempClosing,style: TextStyle(fontSize: 12 , color: Colors.white),)) : SizedBox(),
                 ],
               ),
             ),



            ],
          )


        ],


      ),
    ) :  Container(
       decoration: BoxDecoration(
           border: Border.all(color: Colors.white),
           borderRadius: BorderRadius.all(Radius.elliptical(80, 50)),
           // image: DecorationImage(
           //     image: AssetImage('images/ab.png'),
           //     fit: BoxFit.cover
           // )
           color: Colors.black
       ),
       height: MediaQuery.of(context).size.height * 0.25,
       margin: EdgeInsets.all(5),
       width: MediaQuery.of(context).size.width * 0.9,
       child: Column(
         children: [
           SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
           Row(
             children: [
               SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
               this.Type == 'Main'? Text("Open Time: "+ this.tempOpening,style: TextStyle(fontSize: 15,color: Colors.white),): SizedBox(),
                Text("Result Time: "+ this.tempClosing,style: TextStyle(fontSize: 18 , color: Colors.white,fontWeight: FontWeight.bold),) ,
             ],
           ),
           SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
           Row(
               children: [
                 SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
                 Container(
                     child: Container(
                       padding: EdgeInsets.all(5),
                       decoration: BoxDecoration(
                         color: Colors.red,
                         borderRadius: BorderRadius.circular(20)
                       ),
                       child: Text(this.Name , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.w600 ,                              color: Colors.white, shadows: [Shadow(color: Colors.white , blurRadius: 60 )]),),
                     )),
                 SizedBox(width: MediaQuery.of(context).size.width * 0.43,),
                    (this.Status && int.parse(Closing.substring(0,2)) > DateTime.now().hour) || i == 1 ||(int.parse(Closing.substring(3,5)) > DateTime.now().minute && int.parse(Closing.substring(0,2)) == DateTime.now().hour ) ? InkWell(
                   onTap: (){
                     i == 0 ? this.Type != 'Market'? Navigator.push(context, MaterialPageRoute(builder: (context)=> GameSelection(Name: this.Name, Id: this.Id,UserPhone: this.UserPhone,Type: this.Type,))) : Navigator.push(context, MaterialPageRoute(builder: (context)=>UserInput(Id: this.Id, Name: this.Name, a: 2,UserPhone: this.UserPhone,Type: this.Type,))) :
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> showAllStatement(Id: this.Id,)));
                   },
                   splashColor: Colors.yellowAccent,
                   radius: 200,
                   child: Column(
                     children: [
                       Container(
                         decoration: BoxDecoration(
                             color: Colors.transparent,
                             borderRadius: BorderRadius.only(bottomRight: Radius.circular(20) , topLeft: Radius.circular(20)),
                             image: DecorationImage(
                                 image: AssetImage('images/play.png'),
                                 fit: BoxFit.cover
                             ),
                             // boxShadow: [BoxShadow(color: Colors.greenAccent,blurRadius: 20)]
                         ),
                         width: MediaQuery.of(context).size.width * 0.18,
                         height: MediaQuery.of(context).size.height * 0.075,

                       ),
                       Text("PLAY",style: TextStyle(color: Colors.greenAccent,fontSize: 15),)
                     ],
                   ),
                 ): InkWell(
                   splashColor: Colors.yellowAccent,
                   radius: 200,
                   child: Column(
                     children: [
                       Container(
                         decoration: BoxDecoration(
                             color: Colors.transparent,
                             borderRadius: BorderRadius.only(bottomRight: Radius.circular(20) , topLeft: Radius.circular(20)),
                             image: DecorationImage(
                                 image: AssetImage('images/close.png'),
                                 fit: BoxFit.cover
                             ),
                             // boxShadow: [BoxShadow(color: Colors.redAccent,blurRadius: 20)]
                         ),
                         width: MediaQuery.of(context).size.width * 0.18,
                         height: MediaQuery.of(context).size.height * 0.075,

                       ),
                       Text("CLOSE",style: TextStyle(color: Colors.red,fontSize: 15),)
                     ],
                   ),
                 )
               ]
           ),
           Row(
             children: [
               SizedBox(width: MediaQuery.of(context).size.width * 0.07,),
               this.Type == 'Main' ? Text(this.Random.substring(0,4),style: TextStyle(fontSize: 20 ,color: Colors.white),) : Text(this.Random , style: TextStyle(fontSize: 20 , color: Colors.white),),

               SizedBox(width: MediaQuery.of(context).size.width * 0.02),
               GestureDetector(
                 onTap: (){
                 i==0? Navigator.push(context, MaterialPageRoute(builder: (context)=> Calendar(Id: this.Id,))) : showDialog(context: context, builder: (context){
                    return AlertDialog(
                      title: Text("Do you want to upload current Game Digits on the calendar?"),
                      content: Row(
                        children: [
                          ElevatedButton(onPressed: ()async{
                            String date = await DateTime.now().day.toString() + "-"+ DateTime.now().month.toString() +"-"+ DateTime.now().year.toString();
                            final CalendarUser = await FirebaseFirestore.instance.collection("Games").doc(this.Id).collection("Calendars").doc(date);
                            await CalendarUser.set({
                              "Date": date,
                              "Digits": this.Random,
                            });

                             Navigator.pop(context);
                          }, child: Text("Yes Upload it!")),
                          SizedBox(width: MediaQuery.of(context).size.width *0.2,),
                          ElevatedButton(onPressed: (){
                            Navigator.pop(context);

                          }, child: Text("No"))
                        ],
                      )
                    );
                  });
                 },
                 child: Container(
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(50),
                       image: DecorationImage(
                           image: AssetImage('images/Calendar.png'),
                           fit: BoxFit.cover
                       )
                   ),
                   height: MediaQuery.of(context).size.height * 0.06,
                   width:  MediaQuery.of(context).size.width * 0.18,
                 ),
               )
               ],
           )


         ],
       ),
     );
  }
}
