import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:djdigital/UserMan/Rules.dart';
import 'package:djdigital/UserMan/UserHistory.dart';
import 'package:djdigital/main.dart';
import 'package:djdigital/Profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Admin Panel.dart';
import 'Animation.dart';
import 'UserMan/MarketRates.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// Color.fromRGBO(255, 215 , 22, 0.5)


class Drawere extends StatefulWidget {
    String Userphone;
    String Currency ;
    String Name ;
    Drawere({required this.Userphone , required this.Currency,required this.Name});
  @override
  State<Drawere> createState() => _DrawereState();
}

class _DrawereState extends State<Drawere> {
  bool activated = false ;
  @override
  Future<void> jj()async{
    final docUser = await FirebaseFirestore.instance.collection("Amounts").doc(widget.Userphone).get();
    Map<String,dynamic>? mp = await docUser.data();

    setState(() {
      this.activated = mp!["Activate"];
    });
  }
  void initState() {
    jj();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white,
      body: Container(
        decoration: BoxDecoration(
         image: DecorationImage(
           image: AssetImage('images/drawer.png'),
           fit: BoxFit.cover
         )
        ),

        child: ListView(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/paymentBG.png'),
                  fit: BoxFit.cover
                ),
              ),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.15,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/logo.png'),
                        fit: BoxFit.cover
                    ),
                ),
              ),
            ),

            TextButton(
              onLongPress: ()async{
                try {
                  final AdminUsersnap = await FirebaseFirestore.instance
                      .collection("Admins").doc(widget.Userphone).get();
                  Map<String, dynamic>? AdminUser = await AdminUsersnap.data();
                  print(widget.Name);
                  if (AdminUser!["Name"] == widget.Name) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Admin()));
                  }
                }
                catch(e){
                  print("Cheater caught");
                }


              },
              onPressed: (){

              },
              child: Container(
                decoration: BoxDecoration(
                             color: Colors.lightBlueAccent
              ),
                child:const ListTile(
                  focusColor: Colors.black12,
                  leading: Icon(Icons.home , color: Colors.black,),
                  title: const Text("Main Home",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 16),),
                ),
              ),
            ),
            TextButton(
              onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile(UserPhone: widget.Userphone,activated: this.activated,)));
              },
              child: Container(
                decoration: BoxDecoration(
                             color: Colors.lightBlueAccent

                ),
                child: const ListTile(
                  focusColor: Colors.black12,
                  leading: Icon(Icons.person,color: Colors.black,),
                  title: Text("My Profile",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.black),),
                ),
              ),
            ),
           this.activated? TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AnimatingBg1(Currency: widget.Currency,UserPhone: widget.Userphone,Name: widget.Name,)));
              },
              child: Container(
                decoration: BoxDecoration(
                             color: Colors.lightBlueAccent
                ),
                child: const ListTile(
                  focusColor: Colors.black12,
                  leading: Icon(Icons.wallet,color: Colors.black,),
                  title: Text("Wallet",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16 , color: Colors.black),),
                ),
              ),
            ) : SizedBox(),
           this.activated ? TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Rates()));
              },
              child: Container(
                decoration: BoxDecoration(
                             color: Colors.lightBlueAccent
                ),
                child: const ListTile(
                  focusColor: Colors.black12,
                  leading: Icon(Icons.star , color: Colors.black,),
                  title: Text("Market Rate (Bhaav)",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.black),),
                ),
              ),
            ) : TextButton(
             onPressed: (){
             },
             child: Container(
               decoration: BoxDecoration(
                   color: Colors.lightBlueAccent

               ),
               child: const ListTile(
                 focusColor: Colors.black12,
                 leading: Icon(Icons.star),
                 title: Text("Rate Our App",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.black),),
               ),
             ),
           ),
          this.activated?  TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> History(UserPhone: widget.Userphone)));
              },
              child: Container(
                decoration: BoxDecoration(
                             color: Colors.lightBlueAccent
                ),
                child: const ListTile(
                  focusColor: Colors.black12,
                  leading: Icon(Icons.history , color: Colors.black,),
                  title: Text("Game History",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.black),),
                ),
              ),
            ) : SizedBox(),
           this.activated? TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Rules()));
              },
              child: Container(
                decoration: BoxDecoration(
                             color: Colors.lightBlueAccent
                ),
                child: const ListTile(
                  focusColor: Colors.black12,
                  leading: Icon(Icons.rule,color: Colors.black,),
                  title: Text("Rules and Regulations",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.black),),
                ),
              ),
            ) : SizedBox(),
            TextButton(
              onPressed: (){
                // Navigator.push(context, MaterialPageRoute(builder: (context)=> History(UserPhone: widget.Userphone)));
              },
              child: Container(
                decoration: BoxDecoration(
                             color: Colors.lightBlueAccent
                ),
                child: const ListTile(
                  focusColor: Colors.black12,
                  leading: Icon(Icons.share ,color: Colors.black,),
                  title: Text("Share Our App",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.black),),
                ),
              ),
            ),
            TextButton(
              onPressed: ()async{
                FirebaseAuth _auth = FirebaseAuth.instance ;
                await _auth.signOut();
                final ref = await SharedPreferences.getInstance();
              await ref.remove('Saved_Number');
              await ref.remove('Saved_Name');
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => myApp()));
              },
              child: Container(
                decoration: BoxDecoration(
                             color: Colors.lightBlueAccent
                ),
                child: const ListTile(
                  focusColor: Colors.black12,
                  leading: Icon(Icons.logout_rounded,color: Colors.black,),
                  title: Text("Logout User",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.black),),
                ),
              ),
            ),



          ],
        ),
      ),
    );
  }
}
