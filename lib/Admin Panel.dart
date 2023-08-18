
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:djdigital/userCarde.dart';
import 'package:flutter/services.dart';
import 'Game.dart';
import 'dart:math';
import 'Carde.dart';
import 'Statements.dart';
import 'Main page.dart';
import 'package:url_launcher/url_launcher.dart';
class Admin extends StatelessWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(foregroundColor: Colors.black,title: const Text("Admin Panel",style: TextStyle(color: Colors.black),),backgroundColor: Colors.white70,),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10,right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.red
              ),
              child: ElevatedButton(
                onPressed: ()async{
                  int activated = 0 ;
                  int notActivated = 0 ;
                  final usersSnap = await  FirebaseFirestore.instance.collection("Amounts").get();
                  final usersQuery = await usersSnap.docs;
                  usersQuery.forEach((element) {
                    final elementData = element.data();
                    if(elementData["Activate"] == true){
                      activated ++ ;
                    }
                    else{
                      notActivated++;
                    }
                  });

                  return showDialog(context: context, builder: (context)=>
                      AlertDialog(
                        backgroundColor: Colors.blueGrey,
                        title: Text("Total Number of users are: " + (activated + notActivated).toString(),style: TextStyle(color: Colors.white70),),
                        content: Text("Activated: ${activated}  Not Activated: ${notActivated}",style: TextStyle(color: Colors.white70),),
                      )
                  );
                }, child: Text("Calculate total number of users"),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.black45),

                ),
              ),
            ),

            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20) , bottomRight: Radius.circular(20)),

              ),
              child: Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.06,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const ADD()));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.yellowAccent,

                        ),
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: const Center(child: Text("ADD",style: TextStyle(fontSize: 20),))
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Edit()));

                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        padding: EdgeInsets.only(left: 15),
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: const Center(child: Text("Edit/Delete/Result/Chart/Market Status",style: TextStyle(fontSize: 20),))
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> const UserUpdate()));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      height: MediaQuery.of(context).size.height * 0.15,
                      padding: EdgeInsets.only(left: 10),
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: const Center(child: Text("User Info and Point Update",style: TextStyle(fontSize: 20,color: Colors.white),))
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> const WithdrawlRequests()));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 20),
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: const Text("Withdrawl Requests",style: TextStyle(fontSize: 20),)
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=> const DepositRequests()));
              },
              child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20) , bottomRight: Radius.circular(20)),
                      color: Colors.blueAccent
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 20),
                  margin: const EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: const Text("Deposit Requests",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w500),)
              ),
            ),
            GestureDetector(
              onTap: ()async{
                final upiSnap = await FirebaseFirestore.instance.collection('upi').doc('id').get();
                final upiMap = upiSnap.data();
                String upiCurrent ="";
                try {
                  upiCurrent = upiMap!["upi"];
                }
                catch(e){
                  upiCurrent = '000';
                }
                showDialog(context: context, builder: (context){
                  String vale = "";
                  return AlertDialog(
                    title: Column(
                      children: [
                        Text("Current UPI ID is ${upiCurrent}"),
                        TextField(
                          onChanged: (val){
                            vale = val ;
                          },
                          decoration: const InputDecoration(
                              hintText: "UPI ID"
                          ),
                        ),
                      ],
                    ),
                    content: ElevatedButton(onPressed: ()async{
                      if(vale!=""){
                        await FirebaseFirestore.instance.collection('upi').doc('id').set({
                          "upi": vale
                        });
                      }
                      Navigator.pop(context);

                    },child: const Text("Submit"),),
                  );
                });
              },
              child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20) , bottomRight: Radius.circular(20)),
                      color: Colors.pinkAccent
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 20),
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: const Text("Change UPI",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w500),)
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
            GestureDetector(
              onTap: ()async{
                final whatsappSnap = await FirebaseFirestore.instance.collection('whatsapp').doc('id').get();
                final whatsappMap = whatsappSnap.data();
                String whatsappCurrent = "";
                try {
                  whatsappCurrent = whatsappMap!['whatsapp'];
                }
                catch(e){
                  whatsappCurrent = "0000";
                }

                showDialog(context: context, builder: (context){
                  String vale = "";
                  return AlertDialog(
                    title: Column(
                      children: [
                        Text("Current Whatsapp Number is ${whatsappCurrent}"),
                        TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10)
                          ],
                          onChanged: (val){
                            vale = val ;
                          },
                          decoration: InputDecoration(
                              hintText: "Whatsapp Number"
                          ),
                        ),
                      ],
                    ),
                    content: ElevatedButton(onPressed: ()async{
                      if(vale!=""){
                        await FirebaseFirestore.instance.collection('whatsapp').doc('id').set({
                          "whatsapp": vale
                        });
                      }
                      Navigator.pop(context);

                    },child: Text("Submit"),),
                  );
                });
              },
              child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20) , bottomRight: Radius.circular(20)),
                      color: Colors.green
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 20),
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: const Text("Change Whatsapp",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w500),)
              ),
            ),
          ],
        )
    );
  }
}


class ADD extends StatefulWidget {
  const ADD({Key? key}) : super(key: key);

  @override
  State<ADD> createState() => _ADDState();
}

class _ADDState extends State<ADD> {
  String Name = "";
  String Opening = "00";
  String Closing = "00";
  String omin = "00";
  String cmin = "00";
  String Random = "XXX-XX-XXX";
  bool Status = false ;
  String Type = "Main";
  late String Id ;
  int value = 1;


  intialId()async{
    Id = await RandomGenerator.generateRandomString(10);

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    intialId();
  }

  @override


  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(foregroundColor: Colors.black,title: const Text("ADD",style: TextStyle(color: Colors.black),),backgroundColor: Colors.white70,),
        body: ListView(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.lightBlueAccent,
              ),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                  TextField(
                    onChanged: (val){
                      setState(() {
                        this.Name = val ;
                      });
                    },
                    decoration: const InputDecoration(
                        hintText: "Enter the NAME here",
                        hintStyle: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),
                        contentPadding: EdgeInsets.only(left: 40),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))



                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04,),

                  TextField(
                    onChanged: (val){
                      setState(() {
                        this.Opening = val ;
                      });

                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(2)
                    ],
                    decoration: const InputDecoration(
                        hintText: "Enter the Opening Time here in hours",
                        hintStyle: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),
                        contentPadding: EdgeInsets.only(left: 40),
                        enabledBorder: OutlineInputBorder( borderSide: BorderSide(color: Colors.black)),
                        border: OutlineInputBorder( borderSide: BorderSide(color: Colors.black))



                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                  TextField(
                    onChanged: (val){
                      setState(() {
                        this.omin = val ;
                      });

                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(2)
                    ],
                    decoration: const InputDecoration(
                        hintText: "Enter the Opening Time in minutes",
                        hintStyle: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),
                        contentPadding: EdgeInsets.only(left: 40),
                        enabledBorder: OutlineInputBorder( borderSide: BorderSide(color: Colors.black)),
                        border: OutlineInputBorder( borderSide: BorderSide(color: Colors.black))
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04,),

                  TextField(
                    onChanged: (val){
                      setState(() {
                        this.Closing = val;
                      });
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(2)
                    ],
                    decoration: const InputDecoration(
                        hintText: "Enter the Closing Time here in hours",
                        hintStyle: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),
                        contentPadding: EdgeInsets.only(left: 40),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))



                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                  TextField(
                    onChanged: (val){
                      setState(() {
                        this.cmin = val;
                      });
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(2)
                    ],
                    decoration: const InputDecoration(
                        hintText: "Enter the Closing Time here in minutes",
                        hintStyle: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),
                        contentPadding: EdgeInsets.only(left: 40),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))



                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04,),

                  SwitchListTile(value: Status, onChanged: (val){
                    setState(() {
                      Status = !Status;
                    });
                  },
                    title: const Text("Status",style: TextStyle(fontSize: 20),),
                    subtitle: const Text("Green for Open , Red for Close "),
                    contentPadding: const EdgeInsets.only(left: 39),
                    activeColor: Colors.green,
                    inactiveThumbColor: Colors.red,
                  ),

                  Column(
                    children: [
                      const Text("Select white for Normal, Red for Starline and Green for Gali Market",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,backgroundColor: Colors.black),),
                      Row(
                        children: [
                          Radio(activeColor: Colors.white ,value: 1 , groupValue: value, onChanged: (val){
                            setState(() {
                              value = val! ;
                            });
                          }),
                          Radio(activeColor: Colors.red ,value: 2 , groupValue: value, onChanged: (val){
                            setState(() {
                              value = val! ;
                            });
                          }),
                          Radio(activeColor: Colors.greenAccent,value: 3 , groupValue: value, onChanged: (val){
                            setState(() {
                              value = val! ;
                            });
                          })
                        ],
                      )

                    ],
                  )


                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            ElevatedButton(onPressed: ()async{
              if(this.value == 2){
                this.Type = 'Starline';
              }
              if(this.value == 3){
                this.Type = 'Market';
              }
              this.Opening = this.Opening + ":" + this.omin ;
              this.Closing = this.Closing + ":" + this.cmin;
              if(this.Opening.length != 5 || this.Closing.length!=5){
                return showDialog(context: context, builder: (context){
                  return const AlertDialog(
                    content: Text("Please enter opening and closing times in the correct order!"),
                  );
                });
              }
              final docUser = await FirebaseFirestore.instance.collection("Games").doc(this.Id);
              final json = Game.Tojson(Game(Name: this.Name, Random: this.Random, Closing: this.Closing, Opening: this.Opening, Status: Status == true,Id: this.Id ,Type: this.Type));
              docUser.set(json);

              Navigator.pop(context);

            }, child: const Text("Submit",style: TextStyle(fontSize: 24),))

          ],
        )
    );
  }
}

class Edit extends StatefulWidget {
  const Edit({Key? key}) : super(key: key);

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  @override
  bool azaad = false ;
  String searchKey = "";
  int grandTotal = 0;
  int greatGrandTotal = 0;
  bool free = false ;
  bool lock = false ;
  Stream<List<Game>> Steamer(){
    return FirebaseFirestore.instance.collection("Games").snapshots().map((event) => event.docs.map((e) => Game.fromJson(e.data())).toList());
  }
  Widget showWinner(Statements statement , Game e){
    return userCarde(Name: statement.Name, Phone: statement.Phone, Session: statement.Session, Type: statement.Type, Amount: statement.Amount, Close: statement.Close, Open: statement.Open, Date: statement.Date , userId: statement.Id,gameId: e.Id,);
  }


  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(foregroundColor: Colors.black,title: const Text("Edit",style: TextStyle(color: Colors.black),),backgroundColor: Colors.white70,),
        body: ListView(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height *0.04,),
              Padding(
                padding: EdgeInsets.all(6),
                child: TextField(
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                      ),
                      hintText: "Search by Name",
                      hintStyle: TextStyle(color: Colors.white)
                  ),
                  textInputAction: TextInputAction.search,
                  onChanged: (val){
                    setState(() {
                      this.searchKey = val;
                    });
                  },

                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height *0.04,),
              Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      border: Border.all(color: Colors.blue)

                  ),
                  child: !lock? ElevatedButton(onPressed: ()async{
                    int omg = 0 ;
                    bool allowed = false ;
                    final Snap = await FirebaseFirestore.instance.collection('Games').get();
                    final snaps = await Snap.docs;
                    List<Map<String,dynamic>>? mp = await snaps.map((e) => e.data()).toList();
                    int i= 0;
                    mp.forEach((element) async{
                      String Idd = element!['Id'];
                      final Snap2 = await FirebaseFirestore.instance.collection('Games').doc(Idd).collection('Users').get();
                      final snaps2 = await Snap2.docs;
                      List<Map<String,dynamic>>? mp2 = await snaps2.map((e) => e.data()).toList();
                      mp2.forEach((elemento) {
                        String amount = elemento!['Amount'];
                        String dist = elemento!["Distributed"];
                        if(dist == 'NO') {
                          omg = omg + int.parse(amount);
                        }
                      });
                      i++;
                      if(i==mp.length){
                        print(omg);
                        setState(() {
                          grandTotal = omg ;
                          lock = true ;
                        });
                      }
                    });
                    print(omg);



                  }, child: Text("Calculate Total Bid")) : Text(" Grandtotal Bid = ${grandTotal}",style: TextStyle(color: Colors.white, fontSize: 20),)


              ),
              SizedBox(height: MediaQuery.of(context).size.height *0.04,),
              const Center(child: Text("Tap on the items to edit",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
              StreamBuilder<List<Game>>(
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
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: games!.map((e) {
                          if(searchKey == "" || e.Name.toLowerCase().contains(searchKey.toLowerCase()) ){
                            return GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>EditForm(Id: e.Id,Name: e.Name, Random: e.Random, Closing: e.Closing, Opening: e.Opening, Status: e.Status,Type: e.Type,)));
                                },
                                child: Column(
                                  children: [
                                    Carde(Name: e.Name, Random: e.Random, Closing: e.Closing, Opening: e.Opening, Status: e.Status,Id: e.Id, i: 1,UserPhone: "",Type: e.Type, activated: true,),
                                    StreamBuilder<List<Statements>>(
                                      stream: FirebaseFirestore.instance.collection("Games").doc(e.Id).collection("Users").snapshots().map((event) => event.docs.map((e) => Statements.fromJson(e.data()) ).toList()),
                                      builder: (context,snaps){
                                        if(snaps.hasData){
                                          int total = 0 ;
                                          List<Statements>? data = snaps.data;
                                          int itr = 0 ;
                                          data!.forEach((element) {
                                            itr++;
                                            if(element.Ditributed == "NO") {
                                              total =
                                                  total + int.parse(element.Amount);
                                            }


                                          });
                                          // if(lock==false){
                                          //     grandTotal = grandTotal + total ;
                                          // }




                                          return Text("Total Bid = " + total.toString(), style:  const TextStyle(color: Colors.white),);
                                        }
                                        else{
                                          return const Text("0 Bid so far");
                                        }
                                      },

                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(onPressed: ()async{
                                          String ran= e.Random;
                                          String s1 , s2 , s3 ;



                                          QuerySnapshot<Map<String,dynamic>> snaps = await FirebaseFirestore.instance.collection("Games").doc(e.Id).collection("Users").get();
                                          List<QueryDocumentSnapshot<Map<String, dynamic>>> mp = snaps.docs;
                                          List<Statements> statements =  mp.map((e) => Statements.fromJson(e.data())).toList();
                                          List<Statements> ls = [];
                                          int flag = 1;
                                          statements.forEach((element)async{
                                            if(element.Ditributed == "YES"){
                                              print("Already done");
                                            }
                                            else if(e.Type == 'Main'){
                                              if(ran.length != 10){
                                                flag = 0;
                                                return await showDialog(context: context, builder: (context){
                                                  return AlertDialog(
                                                    content: Text("Declaration should be of the order XXX-XX-XXX"),
                                                  );
                                                });
                                              }
                                              s1 = ran.substring(0,3);
                                              s2 = ran.substring(4,6);
                                              s3 = ran.substring(7);
                                              if (element.Type == 'Single Digit') {
                                                if (element.Session == 'Open' &&
                                                    element.Open ==
                                                        s2.substring(0, 1)) {
                                                  ls.add(element);
                                                } else if (element.Session ==
                                                    'Close' &&
                                                    element.Open ==
                                                        s2.substring(1)) {
                                                  ls.add(element);
                                                } else {
                                                  print("NO");
                                                }
                                              }
                                              else if (element.Type == 'Jodi Digit' && s2 == element.Open) {
                                                ls.add(element);
                                              }
                                              else if (element.Type == 'Single Panna' || element.Type == 'Double Panna' || element.Type == 'Triple Panna') {
                                                if (element.Session == 'Open' &&
                                                    s1 == element.Open) {
                                                  ls.add(element);
                                                } else if (element.Session ==
                                                    'Close' &&
                                                    s3 == element.Open) {
                                                  ls.add(element);
                                                }
                                              }
                                              else if (element.Type == 'Half Sangam') {
                                                if (element.Session == 'Open' &&
                                                    s1 == element.Open &&
                                                    s2.substring(1) ==
                                                        element.Close) {
                                                  ls.add(element);
                                                } else if (element.Session ==
                                                    'Close' &&
                                                    s3 == element.Open &&
                                                    s2.substring(0, 1) ==
                                                        element.Close) {
                                                  ls.add(element);
                                                }
                                              }
                                              else if (element.Type == 'Full Sangam') {
                                                if (element.Open == s1 &&
                                                    element.Close == s3) {
                                                  ls.add(element);
                                                }
                                              }
                                            }
                                            else if(e.Type == 'Starline'){
                                              if(ran.length != 5){
                                                flag = 0 ;
                                                return await showDialog(context: context, builder: (context){
                                                  return AlertDialog(
                                                    content: Text("Declaration should be of the order XXX-X for ${e.Name}"),
                                                  );
                                                });
                                              }
                                              s1 = ran.substring(0,3);
                                              s2 = ran.substring(4,5);
                                              if (element.Type == 'Single Panna' || element.Type == 'Double Panna' || element.Type == 'Triple Panna') {
                                                if (s1 == element.Open) {
                                                  ls.add(element);
                                                }
                                              }
                                              else if (element.Type == 'Single Digit' && s2 == element.Open) {
                                                ls.add(element);
                                              }
                                            }

                                            else if(e.Type == 'Market'  && element.Type == 'Jodi Digit'){
                                              String s1 = ran ;
                                              if(ran.length != 2){
                                                flag = 0;
                                                return await showDialog(context: context, builder: (context){
                                                  return AlertDialog(
                                                    content: Text("Declaration should be of the order XX for ${e.Name}"),
                                                  );
                                                });
                                              }

                                              element.Open == s1 ? ls.add(element) : print("") ;
                                            }
                                          }
                                          );
                                          assert(flag == 1);
                                          return  showDialog(context: context, builder: (context){
                                            return Container(
                                              color: Colors.white,
                                              child: Center(
                                                child: ListView(
                                                  children: [
                                                    Container(
                                                      child: Text("LIST OF WINNERS",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                      margin: EdgeInsets.only(top: 10 , bottom: 10),
                                                      alignment: Alignment.center,
                                                      width: double.infinity,
                                                      height: MediaQuery.of(context).size.height * 0.08,
                                                      decoration: BoxDecoration(
                                                          gradient: LinearGradient(
                                                              colors: [Colors.red,Colors.blue]
                                                          )

                                                      ),
                                                    ),
                                                    ListView.builder(
                                                        shrinkWrap: true,
                                                        physics: NeverScrollableScrollPhysics(),
                                                        itemCount: ls.length,
                                                        itemBuilder: (context,index){
                                                          return showWinner(ls[index],e);
                                                        }),
                                                    GestureDetector(
                                                      onTap: (){
                                                        ls.sort((a,b){
                                                          return a.Phone.compareTo(b.Phone);
                                                        });
                                                      },
                                                      onLongPress: ()async{
                                                        assert(this.azaad == false );
                                                        this.azaad = true ;
                                                        int i=0;
                                                        ls.sort((a,b){
                                                          return a.Phone.compareTo(b.Phone);
                                                        });
                                                        List<String> phoones = [];
                                                        List<int> amountes = [];
                                                        ls.forEach((element) async{
                                                          i++ ;
                                                          int amount = 0;
                                                          int points = await int.parse(element.Amount);
                                                          phoones.add(element.Phone);

                                                          if (element.Type ==
                                                              'Single Digit') {
                                                            amount = amount +((points*95)/10).toInt() ;
                                                          }
                                                          if (element.Type ==
                                                              'Jodi Digit') {
                                                            amount = amount + points * 95 ;
                                                          }
                                                          if (element.Type ==
                                                              'Single Panna') {
                                                            amount = amount + points * 140 ;
                                                          }
                                                          if (element.Type ==
                                                              'Double Panna') {
                                                            amount = amount + points * 280 ;

                                                          }
                                                          if (element.Type ==
                                                              'Triple Panna') {
                                                            amount = amount + points * 700;
                                                          }
                                                          if (element.Type ==
                                                              'Half Sangam') {
                                                            amount = amount + points * 1000 ;
                                                          }
                                                          if (element.Type ==
                                                              'Full Sangam') {
                                                            amount = amount + points * 10000;
                                                          }
                                                          amountes.add(amount);
                                                          if(phoones.length==ls.length){
                                                            print("amm: "+ amountes.toString());
                                                            // Set<String> jj = {} ;
                                                            Map<String,int> mp = {};
                                                            phoones.forEach((element) {
                                                              // jj.add(element);
                                                              mp[element] = 0 ;
                                                            });
                                                            // print("Set is " + jj.toString());
                                                            print("Map is " + mp.toString());
                                                            int j = 0 ;
                                                            phoones.forEach((element) {
                                                              // jj.add(element);
                                                              mp[element] = (mp[element]! + amountes[j])! ;
                                                              j++;
                                                            });
                                                            print("Updated map is" + mp.toString());
                                                            mp.forEach((key, value) async{
                                                              final  userMan = await FirebaseFirestore.instance.collection('Amounts').doc(key);
                                                              final shots = await userMan.get();
                                                              final list = await shots.data();
                                                              int iterableAmount = int.parse(list!['Amount']);
                                                              iterableAmount = iterableAmount + value;
                                                              await FirebaseFirestore.instance.collection('Amounts').doc(key).update({
                                                                "Amount": iterableAmount.toString()
                                                              });
                                                            });


                                                          }

                                                          await FirebaseFirestore.instance.collection('Games').doc(e.Id).collection("Users").doc(element.Id).update(
                                                              {
                                                                "Distributed": "YES"
                                                              }) ;


                                                          //
                                                          // final  userMan6 = await FirebaseFirestore.instance.collection('Amounts').doc(element.Phone).get();
                                                          // Map<String,dynamic>? show = await userMan6.data();
                                                          // print("AMOUNT FOR THIS ITERATION " + show!["Amount"]);
                                                          //
                                                        });


                                                        Navigator.pop(context);
                                                        this.azaad = false ;
                                                        showDialog(context: context, builder: (context){
                                                          return AlertDialog(content: Text("Successfull "),);
                                                        });
                                                      },
                                                      child: Container(
                                                        child: Text("Amount Dispersal",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                        margin: EdgeInsets.only(top: 10 , bottom: 10 , left: 20 ,right:  20),

                                                        alignment: Alignment.center,
                                                        width: MediaQuery.of(context).size.width * 0.25,
                                                        height: MediaQuery.of(context).size.height * 0.08,
                                                        decoration: BoxDecoration(
                                                            gradient: LinearGradient(
                                                                colors: [Colors.red,Colors.blue]
                                                            )

                                                        ),
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                              ),
                                            );

                                          });



                                        }, child: Text("Show Winners")),
                                        SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                                        ElevatedButton(onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>EditForm(Id: e.Id,Opening: e.Opening,Closing: e.Closing,Random: e.Random,Name: e.Name,Status: e.Status,Type: e.Type,)));
                                        }, child: Text("Edit/Result")),
                                        SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                                        ElevatedButton(onPressed: (){
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>showAllStatement(Id: e.Id)));
                                        }, child: Text("Bid History"))
                                      ],
                                    ),
                                    Divider(color: Colors.white,),

                                  ],
                                ));
                          }
                          else{
                            return Text("");
                          }
                        }
                        ).toList(),
                      );

                    }
                    else if(snapshots.hasError){
                      return Text(snapshots.hasError.toString());
                    }
                    else {
                      return const Text("Technical Issues on the Server");
                    }
                  }
              )
            ]
        )
    );
  }
}

class EditForm extends StatefulWidget {
  String Name ;
  String Opening  ;
  String Closing  ;
  String Random ;
  bool Status ;
  String Id ;
  String Type;
  EditForm({required this.Id , required this.Opening , required this.Closing , required this.Random , required this.Name , required this.Status,required this.Type});
  @override
  State<EditForm> createState() => _EditFormState(Name: this.Name,Opening: this.Opening.substring(0,2),omin: this.Opening.substring(3),Closing: this.Closing.substring(0,2),cmin: this.Closing.substring(3),Id: this.Id , Status: this.Status , Random: this.Random,Type: this.Type);
}

class _EditFormState extends State<EditForm> {
  String Name ;
  String Opening  ;
  String Closing  ;
  String omin ;
  String cmin ;
  String Random ;
  bool Status ;
  String Type;
  String Id ;
  _EditFormState({required this.Name , required this.Id , required this.Opening , required this.Closing , required this.Status , required this.Random,required this.Type, required this.cmin , required this.omin});

  @override


  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(foregroundColor: Colors.black,title: Text(this.Name,style: const TextStyle(color: Colors.black),),backgroundColor: Colors.white70,),
        body: ListView(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.lightBlueAccent,
              ),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                  TextFormField(
                    initialValue: widget.Name,
                    onChanged: (val){
                      setState(() {
                        this.Name = val ;
                      });
                    },
                    decoration: InputDecoration(
                        hintText: "Enter the NAME here",
                        hintStyle: const TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),
                        contentPadding: const EdgeInsets.only(left: 40),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20) , borderSide: const BorderSide(color: Colors.black)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20) , borderSide: const BorderSide(color: Colors.black))



                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04,),

                  TextFormField(
                    initialValue:  this.Opening,
                    onChanged: (val){
                      setState(() {
                        this.Opening = val ;
                      });

                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(2)
                    ],
                    decoration: InputDecoration(
                        hintText: "Enter the Opening Time here in hours",
                        hintStyle: const TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),
                        contentPadding: const EdgeInsets.only(left: 40),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20) , borderSide: const BorderSide(color: Colors.black)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20) , borderSide: const BorderSide(color: Colors.black))
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                  TextFormField(
                    initialValue:  this.omin,
                    onChanged: (val){
                      setState(() {
                        this.omin = val ;
                      });

                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(2)
                    ],
                    decoration: InputDecoration(
                        hintText: "Enter the Opening Time here in minutes",
                        hintStyle: const TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),
                        contentPadding: const EdgeInsets.only(left: 40),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20) , borderSide: const BorderSide(color: Colors.black)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20) , borderSide: const BorderSide(color: Colors.black))



                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04,),

                  TextFormField(
                    initialValue:  this.Closing,
                    onChanged: (val){
                      setState(() {
                        this.Closing = val ;
                      });

                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(2)
                    ],
                    decoration: InputDecoration(
                        hintText: "Enter the Closing Time here in hours",
                        hintStyle: const TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),
                        contentPadding: const EdgeInsets.only(left: 40),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20) , borderSide: const BorderSide(color: Colors.black)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20) , borderSide: const BorderSide(color: Colors.black))
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                  TextFormField(
                    initialValue:  this.cmin,
                    onChanged: (val){
                      setState(() {
                        this.cmin = val ;
                      });

                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(2)
                    ],
                    decoration: InputDecoration(
                        hintText: "Enter the Closing Time here in minutes",
                        hintStyle: const TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),
                        contentPadding: const EdgeInsets.only(left: 40),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20) , borderSide: const BorderSide(color: Colors.black)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20) , borderSide: const BorderSide(color: Colors.black))



                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04,),

                  TextFormField(
                    initialValue:  this.Random,
                    onChanged: (val){
                      setState(() {
                        this.Random = val ;
                      });

                    },
                    decoration: InputDecoration(
                        hintText: "Enter the Lottery Number here",
                        hintStyle: const TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),
                        contentPadding: const EdgeInsets.only(left: 40),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20) , borderSide: const BorderSide(color: Colors.black)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20) , borderSide: const BorderSide(color: Colors.black))



                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04,),

                  SwitchListTile(value: this.Status, onChanged: (val){
                    setState(() {
                      this.Status = !this.Status;
                    });
                  },
                    title: const Text("Status",style: TextStyle(fontSize: 20),),
                    subtitle: const Text("Green for Open , Red for Close "),
                    contentPadding: const EdgeInsets.only(left: 39),
                    activeColor: Colors.green,
                    inactiveThumbColor: Colors.red,
                  )


                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            ElevatedButton(onPressed: ()async{
              final docuser = await FirebaseFirestore.instance.collection("Games").doc(widget.Id);
              this.Opening = this.Opening.substring(0,2);
              this.Closing = this.Closing.substring(0,2);
              this.Opening = this.Opening + ":" + this.omin ;
              this.Closing = this.Closing + ":" + this.cmin;
              String op = this.Opening ;
              String cl = this.Closing;

              if(this.Opening.length != 5 || this.Closing.length!=5){
                return showDialog(context: context, builder: (context){
                  return const AlertDialog(
                    content: Text("Please enter opening and closing times in the correct order!"),
                  );
                });
              }
              await docuser.update(
                  Game.Tojson(Game(Name: this.Name, Random: this.Random, Closing: cl, Opening: op, Status: this.Status, Id: this.Id,Type: this.Type))
              );
              Navigator.pop(context);

            }, child: const Text("Submit",style: TextStyle(fontSize: 24),)),
            ElevatedButton(onPressed: (){
              BuildContext ctx;
              showDialog(context: context, builder: (cntext){
                ctx = cntext;
                return AlertDialog(
                  title: const Text("Are you sure?"),
                  content: Row(
                    children: [
                      TextButton(onPressed: ()async{
                        final docuser = await FirebaseFirestore.instance.collection("Games").doc(widget.Id);
                        await docuser.delete();
                        Navigator.pop(cntext);
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Edit()));


                      }, child: const Text("Yes",style: TextStyle(fontSize: 20),)),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.06,),
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: const Text("No",style: TextStyle(fontSize: 20),)),


                    ],
                  ),
                );
              });

            }, child: const Text("Delete"))

          ],
        )
    );
  }
}

class showAllStatement extends StatefulWidget {
  String Id ;
  showAllStatement({required this.Id});

  @override
  State<showAllStatement> createState() => _showAllStatementState();
}

class _showAllStatementState extends State<showAllStatement> {
  @override
  String searchKey = "";
  Stream<List<Statements>> Steamer(){
    return FirebaseFirestore.instance.collection("Games").doc(widget.Id).collection("Users").snapshots().map((event) => event.docs.map((e) => Statements.fromJson(e.data()) ).toList());
  }
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: ()async{
          return await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Edit()));
        },
        child: Scaffold(
            appBar: AppBar(foregroundColor: Colors.black,title: const Text("Edit",style: TextStyle(color: Colors.black),),backgroundColor: Colors.white70,),
            body: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)
                        ),
                        hintText: "Search by Name/ Phone Number/ Date",
                      ),
                      textInputAction: TextInputAction.search,
                      onChanged: (val){
                        setState(() {
                          this.searchKey = val;
                        });
                      },

                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height *0.04,),
                  StreamBuilder<List<Statements>>(
                      stream: Steamer(),
                      builder: (context,snapshots) {
                        if (snapshots.hasData) {
                          final statements = snapshots.data;
                          return ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: statements!.map((e) {
                                if( e.Phone.contains(searchKey) || e.Name.toLowerCase().contains(searchKey.toLowerCase()) || e.Date.contains(searchKey)){
                                  return  userCarde(Name: e.Name,
                                    Phone: e.Phone,
                                    Session: e.Session,
                                    Type: e.Type,
                                    Amount: e.Amount,
                                    Close: e.Close,
                                    Open: e.Open,
                                    Date: e.Date,
                                    gameId: widget.Id,
                                    userId: e.Id,
                                  );
                                }
                                else{
                                  return const SizedBox();
                                }
                              }).toList()

                          );
                        }
                        else{
                          return const Text("This");
                        }
                      }
                  )
                ]
            )
        ));
  }
}

class UserUpdate extends StatefulWidget {
  const UserUpdate({Key? key}) : super(key: key);

  @override
  State<UserUpdate> createState() => _UserUpdateState();
}

class _UserUpdateState extends State<UserUpdate> {
  String amount = "";
  late  bool activated ;
  int count = 20 ;
  String searchKey = "";
  bool vale = false;
  void launcher({required int number , required String message})async{
    String url = "whatsapp://send?phone=$number&text=$message";
    if(url!=null)  await launchUrl(Uri.parse(url));
    else {print("Not bow ");}

  }
  callNumer(int num) async {
    String tel= "tel: ${num}";
    try {
      await launchUrl(Uri.parse(tel));
    } catch (_e) {
      return print(_e);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(foregroundColor: Colors.black,title: const Text("Update Users",style: TextStyle(color: Colors.black),),backgroundColor: Colors.white70,),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(6),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)
                ),
                hintText: "Search by Name/ Phone Number/ Date",
              ),
              textInputAction: TextInputAction.search,
              onChanged: (val){
                setState(() {
                  this.searchKey = val;
                });
              },

            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Filter by users not activated",style: TextStyle(fontSize: 20),),
              Switch(value: vale, onChanged: (val){
                setState(() {
                  vale = !vale ;
                });
              }),
            ],
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance.collection("Amounts").snapshots().map((event) => event.docs.map((e) => e.data()).toList()),
              builder: (context,snap) {
                if (snap.hasData) {
                  List<Map<String,dynamic>>? datas = snap.data;

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
                  datas = datas.reversed.toList();

                  if(datas!.length > count && this.searchKey == "" && this.vale == false ){
                    datas = datas.sublist(0,count);
                    datas.add({});
                  }
                  int index =0 ;
                  print(datas.length);
                  return ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: datas!.map((e) {
                        if(index>=count && datas!.length > count){
                          return ElevatedButton(onPressed: (){
                            setState(() {
                              count = count + 20 ;
                            });
                          }, child: Text("Load More"));
                        }
                        if(searchKey=="" || e["Name"].toString().toLowerCase().contains(searchKey.toLowerCase())  || e["Phone"].toString().contains(searchKey) ||  e["Date"].toString().contains(searchKey)){
                          if(this.vale == true && e["Activate"] == true){
                            return const SizedBox();
                          }
                          index ++ ;
                          return GestureDetector(
                            onTap: () async {
                              return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title:  Text(e["Phone"]),
                                      content: Container(
                                        height: MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.22,
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              initialValue: e["Amount"],
                                              onChanged: (val) {
                                                setState(() {
                                                  this.amount = val;
                                                });
                                              },
                                              keyboardType: TextInputType
                                                  .number,
                                              decoration: const InputDecoration(

                                              ),
                                            ),

                                            SizedBox(height: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.02,),

                                            ElevatedButton(onPressed: () async {
                                              if(amount==''){
                                                this.amount = '0';
                                              }
                                              final updateUser = await FirebaseFirestore
                                                  .instance.collection(
                                                  "Amounts").doc(e["Phone"]);
                                              updateUser.update({
                                                "Amount": this.amount
                                              }
                                              );
                                              Navigator.pop(context);
                                            }, child: const Text("Update"))
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                              );
                            },
                            child: Container(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.28,
                              color: Colors.lightBlueAccent,
                              margin: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  SizedBox(height: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.02,),
                                  Text("Name:  " + e["Name"],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  SizedBox(height: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.02,),
                                  Text("Phone:  " + e["Phone"],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  SizedBox(height: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.02,),

                                  Text("Date:  " + e["Date"],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),

                                  Row(
                                    children: [
                                      SizedBox(width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.1,),
                                      Text("Amount: " + e["Amount"],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),),
                                      SizedBox(width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.05,),
                                      ElevatedButton(onPressed: () {
                                        launcher(number: int.parse(
                                            "91" + e["Phone"]),
                                            message: "Hello");
                                      }, child: const Icon(Icons.message)),
                                      SizedBox(width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.02,),
                                      ElevatedButton(onPressed: () {
                                        callNumer(int.parse(e["Phone"]));
                                      }, child: const Icon(Icons.call))
                                    ],
                                  ),
                                  e["Phone"] != "1231231230" ?  Row(
                                    children: [
                                      const Text("Activate account"),
                                    Switch(value: e["Activate"],
                                        onChanged: (val) async {
                                          setState(() {
                                            this.activated = val;
                                          });
                                          final docuser = await FirebaseFirestore
                                              .instance.collection("Amounts")
                                              .doc(e["Phone"]);
                                          docuser.update({
                                            "Amount": this.amount,
                                            "Activate": this.activated
                                          });
                                        },
                                        activeColor: Colors.green,
                                        inactiveTrackColor: Colors.red,
                                        inactiveThumbColor: Colors.red,
                                      ),
                                    ],
                                  ) : SizedBox()
                                ],
                              ),

                            ),
                          );
                        }
                        else{
                          return const SizedBox();
                        }
                      }
                      ).toList()
                  );
                }
                else{
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: CircularProgressIndicator(color: Colors.black,),
                    padding: EdgeInsets.all(10),
                  );
                }
              }
          )


        ],
      ),
    );
  }
}

class WithdrawlRequests extends StatefulWidget {
  const WithdrawlRequests({Key? key}) : super(key: key);

  @override
  State<WithdrawlRequests> createState() => _WithdrawlRequestsState();
}

class _WithdrawlRequestsState extends State<WithdrawlRequests> {
  @override
  String searchKey= "";
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(foregroundColor: Colors.black,title: const Text("Withdrawls Requests",style: TextStyle(color: Colors.black),),backgroundColor: Colors.white70,),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(6),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)
                ),
                hintText: "Search by Name/ Phone Number/ Date",
              ),
              textInputAction: TextInputAction.search,
              onChanged: (val){
                setState(() {
                  this.searchKey = val;
                });
              },

            ),
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance.collection("Withdrawls").snapshots().map((event) => event.docs.map((e) => e.data()).toList()),
              builder: (context ,snap){
                if (snap.hasData ) {
                  List<Map<String,dynamic>>? datas = snap.data;
                  return ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: datas!.map((e) {
                        if(searchKey=="" || e["Name"].toString().toLowerCase().contains(searchKey.toLowerCase())  || e["Phone"].toString().contains(searchKey)){
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.28,
                            color: Colors.lightBlueAccent,
                            margin: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                                Text("Name:  " + e["Name"] ,style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 20) ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                                Text("Phone:  " + e["Phone"] ,style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 20) ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                                Text("Amount: " + e["Amount"] , style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 20),),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                                Text("Method: " + e["Method"] , style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 20),),
                                SizedBox(height: MediaQuery.of(context).size.width * 0.02,),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Colors.black)
                                    ),
                                    onPressed: ()async{
                                      BuildContext ctx ;
                                      Navigator.pop(context);
                                      final docUser = await FirebaseFirestore.instance.collection("Withdrawls").doc(e["Id"]);
                                      docUser.delete();
                                      return ;

                                    }, child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.done, color: Colors.green),
                                    const Text("Done"),
                                  ],
                                ))
                              ],
                            ),

                          );
                        }
                        else{
                          return const Text("");
                        }
                      }

                      ).toList()
                  );
                }
                else{
                  return const Text("Error has been there or no user has played the game ");
                }

              }
          )
        ],
      ),
    );
  }
}

class DepositRequests extends StatefulWidget {
  const DepositRequests({Key? key}) : super(key: key);

  @override
  State<DepositRequests> createState() => _DepositRequestsState();
}

class _DepositRequestsState extends State<DepositRequests> {
  @override
  String searchKey = "";
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(foregroundColor: Colors.black,title: const Text("Deposits Requests",style: TextStyle(color: Colors.black),),backgroundColor: Colors.white70,),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(6),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)
                ),
                hintText: "Search by Name/ Phone Number/ Date",
              ),
              textInputAction: TextInputAction.search,
              onChanged: (val){
                setState(() {
                  this.searchKey = val;
                });
              },

            ),
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance.collection("Deposits").snapshots().map((event) => event.docs.map((e) => e.data()).toList()),
              builder: (context ,snap){
                if (snap.hasData) {
                  List<Map<String,dynamic>>? datas = snap.data;
                  return ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: datas!.map((e){
                        if(searchKey=="" || e["Name"].toString().toLowerCase().contains(searchKey.toLowerCase())  || e["Phone"].toString().contains(searchKey)){
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.25,
                            color: Colors.lightBlueAccent,
                            margin: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                                Text("Name:  " + e["Name"] ,style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 20) ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                                Text("Phone:  " + e["Phone"] ,style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 20) ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                                Text("Amount: " + e["Amount"] , style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 20),),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Colors.black)
                                    ),
                                    onPressed: ()async{
                                      return showDialog(context: context, builder: (context)=>
                                          AlertDialog(
                                            title: const Text("Do you want to deposit amount to user Account directly?"),
                                            content: Row(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.all(10),
                                                  color: Colors.green,
                                                  child: ElevatedButton(onPressed: ()async{

                                                    final docUser = await FirebaseFirestore.instance.collection("Deposits").doc(e["Id"]);
                                                    docUser.delete();
                                                    Navigator.pop(context);
                                                    final amountUser = await FirebaseFirestore.instance.collection('Amounts').doc(e["Phone"]);
                                                    final amounted= await amountUser.get();
                                                    final amountValue= amounted.data();
                                                    String updatedAmount= (int.parse(e["Amount"]) + int.parse(amountValue!["Amount"])).toString();
                                                    amountUser.update({
                                                      "Amount": updatedAmount
                                                    });

                                                  }, child: const Text("Yes")),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.all(10),
                                                  color: Colors.black,
                                                  child: ElevatedButton(onPressed: ()async{

                                                    final docUser = await FirebaseFirestore.instance.collection("Deposits").doc(e["Id"]);
                                                    docUser.delete();

                                                    Navigator.pop(context);

                                                  }, child: const Text("No")),
                                                ),

                                                Container(
                                                  color: Colors.red,
                                                  margin: const EdgeInsets.all(10),
                                                  child: ElevatedButton(onPressed: (){
                                                    Navigator.pop(context);
                                                  }, child: const Text("Cancel")),
                                                ),

                                              ],
                                            ),
                                          )
                                      );

                                    }, child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.done, color: Colors.green),
                                    const Text("Done"),
                                  ],
                                ))
                              ],
                            ),

                          );
                        }
                        else{
                          return const SizedBox();
                        }
                      }

                      ).toList()
                  );
                }
                else{
                  return const Text("Error has been there or no user has played the game ");
                }

              }
          )
        ],
      ),
    );
  }
}




class RandomGenerator{
  static String generateRandomString(int lengthOfString){
    final random = Random();
    const allChars='AaBbCcDdlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1EeFfGgHhIiJjKkL234567890';
    // below statement will generate a random string of length using the characters
    // and length provided to it
    final randomString = List.generate(lengthOfString,
            (index) => allChars[random.nextInt(allChars.length)]).join();
    return randomString;    // return the generated string
  }
}



