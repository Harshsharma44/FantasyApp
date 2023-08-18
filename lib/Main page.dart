import 'dart:async';

import 'package:flutter/material.dart';
import 'package:djdigital/Carde.dart';
import 'package:djdigital/GaliMarket.dart';
import 'package:djdigital/Payments/Withdraw.dart';
import 'package:djdigital/StarLine.dart';
import 'package:flutter/services.dart';
import 'Drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'Payments/Deposit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Game.dart';
import 'package:lottie/lottie.dart';

class Main extends StatefulWidget {
String UserPhone ;
String whatPhone = "";
Main({required this.UserPhone});
  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  // Animation Variables//

  List<Alignment> alignmentList = [Alignment.topCenter, Alignment.bottomCenter];
  int index = 0;
  Color bottomColor = Colors.black38;
  Color topColor = Color.fromARGB(0, 0, 0,1);
  Alignment begin = Alignment.bottomCenter;
  Alignment end = Alignment.topCenter;
  int Cindex = 0;
  Color CbottomColor = Colors.white70;
  Color CtopColor = Color.fromRGBO(7, 7, 7, 1);
  Alignment Cbegin = Alignment.bottomCenter;
  Alignment Cend = Alignment.topCenter;


  // Animation variables//

  String Currency = "";
   String Name = "";
   bool activated = false ;
  bool isCurrencyLoaded = false;
  Future<void> jj()async{
    final docUser = await FirebaseFirestore.instance.collection("Amounts").doc(widget.UserPhone).get();
    Map<String,dynamic>? mp = await docUser.data();
    this.Currency = mp!["Amount"];

    setState(() {
      this.Name = mp!["Name"];
      this.activated = mp!["Activate"];
      this.isCurrencyLoaded = true;
    });


  }
  

  callNumer() async {
    String tel= "tel: ${widget.whatPhone}";
    try {
      await launchUrl(Uri.parse(tel));
    } catch (_e) {
      return print(_e);
    }

  }
  @override
  getWhatsapp()async{
    final snap = await FirebaseFirestore.instance.collection('whatsapp').doc('id').get();
    final datas = await snap.data();
    widget.whatPhone = datas!['whatsapp'];

  }
  List<String> Limages = ["images/god.png" , "images/god2.png"];

  void initState() {
    // TODO: implement initState
    super.initState();
    getWhatsapp();
    jj();
    // Animation
    Timer(
      Duration(microseconds: 2000),
          () {
        setState(
              () {
            bottomColor = Colors.black;
            CbottomColor = Colors.black;
          },
        );
      },
    );
    // Animation
  }

  @override
  Stream<List<Game>> Steamer(){
    return FirebaseFirestore.instance.collection("Games").snapshots().map((event) => event.docs.map((e) => Game.fromJson(e.data())).toList());


  }
  GlobalKey<ScaffoldState> ee = new GlobalKey();
   void launcher({required int number , required String message})async{
    String url = "whatsapp://send?phone=$number&text=$message";
    if(url!=null)  await launchUrl(Uri.parse(url));
    else {print("Not bow ");}

   }
  void emailLauncher({required int number , required String message})async{
    String url = "";
    if(url!=null)  await launchUrl(Uri.parse(url));
    else {print("Not bow ");}

  }
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: ThemeData(



      ),
      home: Stack(
        children: [

          Image.asset(
            "images/ab.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Scaffold(
            backgroundColor: Colors.black.withOpacity(0),
              appBar: AppBar(
                  title: Text("Digital Game Zone",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,),),
              foregroundColor: Colors.black,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor:   Colors.lightBlueAccent

              ),
              actions: [
               this.activated? Icon(Icons.wallet , color: Colors.black,)  : SizedBox(),
                SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                isCurrencyLoaded ? this.activated ? Container(
                  alignment: Alignment.centerLeft,
                    child: Text(this.Currency,style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 20,color: Colors.black),)) : SizedBox() : Lottie.asset("assets/Goldion.json"),
                SizedBox(width: MediaQuery.of(context).size.width * 0.03,)
              ],
              backgroundColor:  Colors.lightBlueAccent


          ),
              drawer: Drawer(
                key: ee,
                child: Drawere(Userphone: widget.UserPhone,Currency: this.Currency,Name: this.Name,),
              ),

              body: Builder(
                builder: (context) {
                  return ListView(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height* 0.01,
                      ),
                        Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/ab.png'),
                      fit: BoxFit.scaleDown
                    )
                  ),

                            child: Column(
                              children: [
                                // Container(
                                //   width: MediaQuery.of(context).size.width * 0.95,
                                //   padding: EdgeInsets.all(7),
                                //   margin: EdgeInsets.only(top: 10),
                                //   decoration: BoxDecoration(
                                //       color: Colors.black.withOpacity(0.8),
                                //       borderRadius: BorderRadius.circular(18),
                                //       border: Border.all(
                                //       )
                                //   ),
                                //   child: Column(
                                //     children: [
                                //       const  Icon(Icons.verified_outlined,color: Colors.lightBlueAccent,),
                                //       SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                //       const Text("djdigital Matka is a 100% Trusted Matka App",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,color: Colors.white
                                //       ),),
                                //     ],
                                //   ),
                                //
                                // // ),

                                CarouselSlider(
                                  options: CarouselOptions(
                                      enableInfiniteScroll: true ,
                                      autoPlay: true
                                  ),
                                  items: this.Limages.map((element) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(element),
                                          ),
                                          borderRadius: BorderRadius.circular(20),
                                      ),


                                    );
                                  }).toList(),
                                ),


                               this.activated ? Container(
                                 child: Row(
                                    children: [
                                          TextButton(
                                            onPressed: ()async{
                                              final docUser = await FirebaseFirestore.instance.collection("Amounts").doc(widget.UserPhone).get();
                                              Map<String,dynamic>? mp = await docUser.data();
                                              this.Name = mp!['Name'];
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=> Deposit(UserPhone: widget.UserPhone,Currency: this.Currency,Name: this.Name,)));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                                border: Border.all(color: Colors.black),
                                                color: Colors.black.withOpacity(0.7)
                                             ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: MediaQuery.of(context).size.height * 0.05,
                                                    width: MediaQuery.of(context).size.width * 0.2,
                                                    decoration:BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage('images/AddPoints.png'),
                                                        fit: BoxFit.cover
                                                      ),
                                                    ),
                                                  ),
                                                  Text("ADD POINTS",style: TextStyle(color: Colors.green,fontSize: 10),),

                                                ],
                                              ),
                                            ),
                                          ),


                                      TextButton(
                                        onPressed: ()async{
                                          final docUser = await FirebaseFirestore.instance.collection("Amounts").doc(widget.UserPhone).get();
                                          Map<String,dynamic>? mp = await docUser.data();
                                          this.Name = mp!['Name'];
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Withdraw(UserPhone: widget.UserPhone,Currency: this.Currency,Name: this.Name,)));

                                        },
                                        child: Container(
                                     decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                   border: Border.all(color: Colors.black),
                               color: Colors.black.withOpacity(0.7),),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context).size.height * 0.05,
                                                width: MediaQuery.of(context).size.width * 0.2,
                                                decoration:BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage('images/weet.png'),
                                                      fit: BoxFit.cover

                                                  ),
                                                ),
                                                child: Center(),
                                              ),
                                              Text("WITHDRAW",style: TextStyle(color: Colors.green,fontSize: 12),),
                                            ],
                                          ),
                                        ),
                                      ) ,
                                      // SizedBox(
                                      //   width: MediaQuery.of(context).size.width * 0.005,
                                      // ),
                                          TextButton(
                                            onPressed: (){
                                             Navigator.push(context, MaterialPageRoute(builder: (context)=>Gali(Phone: widget.UserPhone, Currency: this.Currency)));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                                  border: Border.all(color: Colors.black),
                                                  color: Colors.black45.withOpacity(0.7)
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: MediaQuery.of(context).size.height * 0.05,
                                                    width: MediaQuery.of(context).size.width * 0.2,
                                                    decoration:BoxDecoration(
                                                        image: DecorationImage(
                                                          image: AssetImage('images/GaliMarket.png'),
                                                          fit: BoxFit.cover
                                                        ),
                                                    ),
                                                    child: Center(),
                                                  ),
                                                  Text('GALI MARKET',style: TextStyle(color: Colors.blue,fontSize: 12)),
                                                ],
                                              ),
                                            ),
                                          ),

                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.01,
                                      ),
                                          TextButton(
                                            onPressed: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=> Starline(Currency:this.Currency, Phone: widget.UserPhone)));
                                            },
                                            child:Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                                  border: Border.all(color: Colors.black),
                                                  color: Colors.black.withOpacity(0.7)
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: MediaQuery.of(context).size.height * 0.05,
                                                    width: MediaQuery.of(context).size.width * 0.2,
                                                    decoration:BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage('images/JOI.png'),
                                                        fit: BoxFit.cover

                                                      ),
                                                    ),
                                                    child: Center(),
                                                  ),
                                                  Text("STARLINE",style: TextStyle(fontSize: 12),),
                                                ],
                                              ),
                                            ),
                                          )

                                    ],
                                  ),
                               ) : SizedBox(),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width * 0.9,
                                      height: MediaQuery.of(context).size.height * 0.06,


                                      child: Row(

                                        children: [
                                          SizedBox(width: MediaQuery.of(context).size.width *0.03,),
                                          GestureDetector(
                                            child: Container(
                                 width: MediaQuery.of(context).size.width *0.2,
                                  height:  MediaQuery.of(context).size.height *0.2,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage('images/whatsapp.png'),
                                                  fit: BoxFit.cover
                                                ),
                                                color: Colors.black,
                                                  border: Border.all(color: Colors.white)
                                              ),
                                            ),
                                         onTap: (){
                                           launcher(number: int.parse('91' + widget.whatPhone), message: "Hi");
                                         },
                                          ),
                                          SizedBox(width: MediaQuery.of(context).size.width *0.03,),
                                          TextButton(
                                              onPressed: ()async{
                                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Main(UserPhone: widget.UserPhone)));
                                              },

                                              child: Container(
                                                child: Center(child: Text("REFRESH",style: TextStyle(color: Colors.red,fontSize: 15,fontWeight: FontWeight.w500),)),
                                                decoration: BoxDecoration(
                                                    color: Colors.black,
                                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                                  border: Border.all(color: Colors.white)
                                                ),
                                                height: MediaQuery.of(context).size.height * 0.15 ,
                                                width: MediaQuery.of(context).size.width * 0.24,
                                              )

                                          ),
                                          SizedBox(width: MediaQuery.of(context).size.width *0.04,),
                                          GestureDetector(
                                            child: Container(
                                              width: MediaQuery.of(context).size.width *0.2,
                                              height:  MediaQuery.of(context).size.height *0.2,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage('images/call.png'),
                                                      fit: BoxFit.cover
                                                  ),
                                                  color: Colors.black,
                                                  border: Border.all(color: Colors.white)
                                              ),
                                            ),
                                            onTap: (){
                                              callNumer();
                                            },
                                          ),


                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
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
                                          physics: NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          children: games!.map(
                                                  (e) {
                                                  return  e.Type == 'Main' ? Carde(Name: e.Name, Random: e.Random, Closing: e.Closing, Opening: e.Opening, Status: e.Status,Id: e.Id, i: 0,UserPhone: widget.UserPhone,Type: e.Type,activated: this.activated,) : SizedBox();
                                                  }
                                          ).toList()
                                        );

                                      }
                                      else {
                                        return Container(
                                           height: MediaQuery.of(context).size.height *0.5 ,child: Lottie.asset("assets/Goldion.json"));
                                      }
                                    }
                                )
                              ],
                            )

                        )

                      ,



                    ],
                  );
                },
              )
            ),
        ],
      ),

    );
  }
}
