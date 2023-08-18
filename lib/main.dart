
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'Sms.dart';
import 'package:http/http.dart';
import 'Main page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pinput/pinput.dart';


    void main() async{
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
  runApp(myApp());
    }

    class Splash extends StatefulWidget {
      const Splash({Key? key}) : super(key: key);

      @override
      State<Splash> createState() => _SplashState();
    }

    class _SplashState extends State<Splash> {
      @override

      Switcher()async{
        final ref = await SharedPreferences.getInstance();
        String? saved_Number = await ref.getString('Saved_Number');

        await Future.delayed(Duration(seconds: 3));
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){

             return  saved_Number != null ? Main(UserPhone: saved_Number) : Register();
            }));
      }
      void initState() {
    // TODO: implement initState
        super.initState();
        Switcher();

  }
  Alignment jj = Alignment.bottomCenter;
      Widget build(BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Container(
                   decoration: BoxDecoration(
                     color: Colors.black
                   ),
                    child: Image.asset("images/logo.png"),
                  ),
          )



          );
      }
    }


    class myApp extends StatelessWidget {

      const myApp({Key? key}) : super(key: key);
      static FirebaseAuth _auth = FirebaseAuth.instance;
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          theme: ThemeData(
          ),
          debugShowCheckedModeBanner: false,
          home: Splash()
          // home: Main(UserPhone: "8319212398")
        );
      }
    }

   class Register extends StatefulWidget {
    String whatPhone = "";
     @override
     State<Register> createState() => _RegisterState();
   }

   class _RegisterState extends State<Register> {
      @override
      getWhatsapp()async{
        final snap = await FirebaseFirestore.instance.collection('whatsapp').doc('id').get();
        final datas = await snap.data();
        widget.whatPhone = datas!['whatsapp'];

      }
      void initState() {
        getWhatsapp();
        super.initState();
      }
      String verificationId = "";
      String errorMessage = "";
      String Name = "";
      String Password = "";
      FirebaseAuth _authauth = FirebaseAuth.instance;

      void launcher({required int number , required String message})async{
        String url = "whatsapp://send?phone=$number&text=$message";
        if(url!=null)  await launchUrl(Uri.parse(url));
        else {print("Not bow ");}

      }
   String phoneNumber = "";
     @override
     Widget build(BuildContext context) {
       return SafeArea(
         child: Scaffold(
             backgroundColor: Colors.blue,
             body: ListView(
                   children: [ Center(
                       child: Container(
                         margin: EdgeInsets.only(top: 49),
                         height: MediaQuery.of(context).size.height * 0.9,
                         alignment: Alignment.center,
                         decoration: BoxDecoration(
                           image: DecorationImage(
                             image: AssetImage('images/ab.png')
                           ),
                               borderRadius: BorderRadius.circular(16),
                               border: Border.all(color: Colors.black)

                         ),
                         child: Column(

                           children: [

                              Container(
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                                     color: Colors.black,

                                 ),
                                height: MediaQuery.of(context).size.height * 0.3,
                                width: double.infinity,
                              child: Image.asset('images/logo.png',),
                              ),
                             SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                             Row(
                               children: [
                                 SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
                                 Text("Register User",style: TextStyle(color:  Colors.blue,fontSize: 24 , fontWeight: FontWeight.bold )),
                               ],
                             ),
                             SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                             Container(
                               margin: EdgeInsets.only(left: 5,right: 5),
                               decoration: BoxDecoration(
                                 color: Colors.white,
                                 borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                               ),
                               child: TextFormField(
                                 cursorColor: Colors.purple,
                                 decoration: InputDecoration(
                                     enabledBorder: OutlineInputBorder(
                                       borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                       borderSide: BorderSide(
                                           color:  Colors.blue


, width: 5.0),
                                     ),
                                     focusedBorder: OutlineInputBorder(
                                       borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                       borderSide: BorderSide(
                                           color:  Colors.blue


, width: 3.0),
                                     ),
                                     contentPadding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                                     hintText: "Name",
                                     hintStyle: TextStyle(fontWeight: FontWeight.w500 , fontSize: 18)
                                 ),
                                 onFieldSubmitted: (String val){
                                   setState(() {
                                     this.Name = val.trim() ;
                                   });
                                 },
                                 onChanged: (String val){
                                   setState(() {
                                     this.Name = val.trim() ;
                                   });
                                 },

                               ),


                             ),
                             SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                             Container(
                               decoration: BoxDecoration(
                                   color: Colors.white,
                                       borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                               ),
                               child: TextFormField(
                                 cursorColor: Colors.purple,
                                 decoration: InputDecoration(
                                     enabledBorder: OutlineInputBorder(
                                       borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                       borderSide: BorderSide(
                                           color:  Colors.blue


, width: 5.0),
                                     ),
                                     focusedBorder: OutlineInputBorder(
                                       borderSide: BorderSide(
                                           color:  Colors.blue


, width: 3.0),
                                     ),
                                     contentPadding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                                     hintText: "Password",
                                     hintStyle: TextStyle(fontWeight: FontWeight.w500 , fontSize: 18)
                                 ),
                                 onFieldSubmitted: (String val){
                                   setState(() {
                                     this.Password = val.trim() ;
                                   });
                                 },
                                 onChanged: (String val){
                                   setState(() {
                                     this.Password = val.trim() ;
                                   });
                                 },

                               ),


                             ),


                             SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                             Container(
                               decoration: BoxDecoration(
                                   color: Colors.white,
                                       borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                               ),
                               child: TextFormField(
                                 inputFormatters: [
                                   LengthLimitingTextInputFormatter(10)
                                 ],
                                   keyboardType: TextInputType.number,
                                 cursorColor: Colors.purple,
                                 decoration: InputDecoration(
                                     enabledBorder: OutlineInputBorder(
                                       borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                       borderSide: BorderSide(
                                           color:  Colors.blue


, width: 5.0),
                                     ),
                                     focusedBorder: OutlineInputBorder(
                                       borderSide: BorderSide(
                                           color:  Colors.blue


, width: 3.0),
                                     ),
                                   contentPadding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                                   hintText: "Phone Number",
                                   hintStyle: TextStyle(fontWeight: FontWeight.w500 , fontSize: 18)
                                 ),
                                 onFieldSubmitted: (String val){
                                     setState(() {
                                       this.phoneNumber = val ;
                                     });
                                 },
                                 onChanged: (String val){
                                     setState(() {
                                       this.phoneNumber = val ;
                                     });
                                 },

                               ),


                             ),

                             Container(
                               decoration: BoxDecoration(
                               ),
                               height: MediaQuery.of(context).size.height * 0.05,
                               width: MediaQuery.of(context).size.width * 0.29,
                               margin: EdgeInsets.only(top: 20),
                               child: ElevatedButton(onPressed: ()async{
                                 if(this.phoneNumber.length != 10){
                                   showDialog(context: context, builder: (context){
                                     return AlertDialog(
                                       backgroundColor: Colors.deepPurple,
                                       content: Text("Invalid Number",style: TextStyle(color: Colors.white70 , fontSize: 20),),
                                     );
                                   });
                                 }
                                 else if(this.Password.length < 5){
                                   showDialog(context: context, builder: (context){
                                     return AlertDialog(
                                       backgroundColor: Colors.deepPurple,
                                       content: Text("Password should be at least of 5 length",style: TextStyle(color: Colors.white70 , fontSize: 20),),
                                     );
                                   });
                                 }
                                 else if(this.Name.length < 3){
                                   showDialog(context: context, builder: (context){
                                     return AlertDialog(
                                       backgroundColor: Colors.deepPurple,
                                       content: Text("Name should be at least 3 characters",style: TextStyle(color: Colors.white70 , fontSize: 20),),
                                     );
                                   });
                                 }
                                else {
                                   try{
                                     final docUser = await FirebaseFirestore.instance.collection("Users").doc(this.phoneNumber);
                                     DocumentSnapshot<Map<String, dynamic>> mp = await docUser.get();
                                        Map<String,dynamic>? mpp = await mp.data();
                                        print(mpp!["Name"]);
                                       showDialog(context: context, builder: (context){
                                         return AlertDialog(
                                           title: Text("Already Registered"),
                                           content: Text("Please LogIn with the same phone number") ,
                                         );
                                       });


                                   } catch (Excetion) {
                                     // String a = "1234567890";
                                     // String x =( Random().nextInt(100000) + 100000 ).toString();
                                     // return SmsSent(this.phoneNumber, x);
                                     String x =( Random().nextInt(100000) + 100000 ).toString();
                                     print(x);
                                     // return SmsSent(this.phoneNumber, x);
                                     final url = 'https://www.fast2sms.com/dev/bulkV2?authorization=pydDkmQV2fcsZASbB7orEiwlUvM3ejYxLa45zFu8ONqW1HJPnRyR18Xkm4TxAFnHPzMQD6te9ujfZaWs&route=otp&message=&variables_values=${x}&numbers=${this.phoneNumber}';
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=>Sms(x, Name,this.phoneNumber, Password, reg: true)));
                                     final response =  await get(Uri.parse(url));
                                     final resMp = response.body ;
                                     print(resMp.toString());                                   }


                                 }

                               },
                                   child: Text("Register",style: TextStyle(color: Colors.black),),

                                 style: ButtonStyle(
                                   foregroundColor: MaterialStateProperty.all(Colors.black),
                                   backgroundColor: MaterialStateProperty.resolveWith((states){
                                     if(states.isEmpty){
                                       return  Colors.white


;
                                     }
                                     return Colors.purpleAccent;
                                   })

                                 ),
                               ),
                             ),
                             SizedBox(height: MediaQuery.of(context).size.height * 0.008,),
                             Text("Already a User?",style: TextStyle(color: Colors.white),),
                             SizedBox(height: MediaQuery.of(context).size.height * 0.016,),
                             GestureDetector(onTap: (){
                               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login()));

                             }, child: Text("Login through Password",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
                             ),
                             // Container(
                             //   alignment: Alignment.center,
                             //   width: MediaQuery.of(context).size.width * 0.3,
                             //   height: MediaQuery.of(context).size.height * 0.08,
                             //
                             //   child: ElevatedButton(
                             //       style: ButtonStyle(
                             //           backgroundColor: MaterialStateProperty.all(Colors.lightGreen),
                             //           foregroundColor: MaterialStateProperty.all(Colors.black87)
                             //       ),
                             //       onPressed: (){
                             //         launcher(number: int.parse('91' + widget.whatPhone), message: "Hi");
                             //       }, child: Container(
                             //     child: Row(
                             //       children: [
                             //         const Icon(Icons.message,color: Colors.black,),
                             //         SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                             //         const Text("Contact",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),)
                             //       ],
                             //     ),
                             //
                             //   )),
                             // ),

                           ],
                         ),
                       ),
                     ),
                    ]
                 ),
         ),
       );
     }
   }

   class Login extends StatefulWidget {
     const Login({Key? key}) : super(key: key);

     @override
     State<Login> createState() => _LoginState();
   }

   class _LoginState extends State<Login> {
      String Password = "";
      String Phone = "";
     @override

      FirebaseAuth _authauth = FirebaseAuth.instance ;


      Widget build(BuildContext context) {
       return SafeArea(
         child: Scaffold(
           backgroundColor: Colors.blueAccent

,
           body: ListView(
                   children: [ Center(
                     child: Container(
                       margin: EdgeInsets.only(top: 49),
                       height: MediaQuery.of(context).size.height * 0.9,
                       alignment: Alignment.center,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(16),
                           border: Border.all(color: Colors.black,
                             ),
                           image: DecorationImage(
                               image: AssetImage('images/ab.png')
                           )

                       ),
                       child: Column(

                         children: [

                           Container(
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                                 color: Colors.black
        ),
                             height: MediaQuery.of(context).size.height * 0.34,
                             child: Image.asset(('images/logo.png')),
                             width: double.infinity,
                           ),
                           SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                           Row(
                             children: [
                               SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
                               Text("Login User",style: TextStyle(color: Colors.blueAccent,fontSize: 24 , fontWeight: FontWeight.bold ,),),
                             ],
                           ),

                           SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                           Container(
                             decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.circular(20)
                             ),
                             child: TextFormField(
                               keyboardType: TextInputType.number,
                             inputFormatters: [
                               LengthLimitingTextInputFormatter(10)
                             ],
                               cursorColor: Colors.purple,
                               decoration: InputDecoration(
                                   enabledBorder: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(50),
                                     borderSide: BorderSide(
                                         color:  Colors.blue


, width: 5.0),
                                   ),
                                   focusedBorder: OutlineInputBorder(
                                     borderSide: BorderSide(
                                         color:  Colors.blue


, width: 3.0),
                                   ),
                                   contentPadding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                                   hintText: "Phone",
                                   hintStyle: TextStyle(fontWeight: FontWeight.w500 , fontSize: 18)
                               ),
                               onFieldSubmitted: (String val){
                                 setState(() {
                                   this.Phone = val ;
                                 });
                               },
                               onChanged: (String val){
                                 setState(() {
                                   this.Phone = val ;
                                 });
                               },

                             ),


                           ),
                           SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                           Container(
                             decoration: BoxDecoration(
                                 color: Colors.white,
                                 borderRadius: BorderRadius.circular(20)
                             ),
                             child: TextFormField(
                               cursorColor: Colors.purple,
                               decoration: InputDecoration(
                                   enabledBorder: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(50),
                                     borderSide: BorderSide(
                                         color:  Colors.blue


                                         , width: 5.0),
                                   ),
                                   focusedBorder: OutlineInputBorder(
                                     borderSide: BorderSide(
                                         color:  Colors.blue


                                         , width: 3.0),
                                   ),
                                   contentPadding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                                   hintText: "Password",
                                   hintStyle: TextStyle(fontWeight: FontWeight.w500 , fontSize: 18)
                               ),
                               onFieldSubmitted: (String val){
                                 setState(() {
                                   this.Password = val.trim() ;
                                 });
                               },
                               onChanged: (String val){
                                 setState(() {
                                   this.Password = val.trim() ;
                                 });
                               },

                             ),


                           ),

                           SizedBox(height: MediaQuery.of(context).size.height * 0.005,),

                           Container(
                             decoration: BoxDecoration(
                             ),
                             height: MediaQuery.of(context).size.height * 0.05,
                             width: MediaQuery.of(context).size.width * 0.29,
                             margin: EdgeInsets.only(top: 20),
                             child: ElevatedButton(onPressed: ()async{

                               final docUser = await FirebaseFirestore.instance.collection("Users").doc(this.Phone);
                               final mp = await docUser.get();
                               try {

                                 if ( mp["Password"] == this.Password) {
                                   final ref =await  SharedPreferences.getInstance();
                                   await ref.setString('Saved_Number', this.Phone);
                                   await Navigator.pushReplacement(context, MaterialPageRoute(
                                       builder: (context) {
                                         return Main(UserPhone: this.Phone,);}));

                                 }
                                 else {
                                   return await showDialog(
                                       context: context, builder: (context) {
                                     return AlertDialog(
                                       backgroundColor: Colors.deepPurple,
                                       content: Text("Invalid Crendentials",
                                         style: TextStyle(
                                             color: Colors.white70, fontSize: 20),),
                                     );
                                   });
                                 }
                               } catch (e){
                                 return await showDialog(context: context, builder: (context){
                                   return AlertDialog(
                                     backgroundColor: Colors.deepPurple,
                                     content: Text("Number not registered",style: TextStyle(color: Colors.white , fontSize: 20),),
                                   );
                                 });

                               }
                             },
                               child: Text("LOGIN",style: TextStyle(color: Colors.black),),

                               style: ButtonStyle(
                                   foregroundColor: MaterialStateProperty.all(Colors.black),
                                   backgroundColor: MaterialStateProperty.resolveWith((states){
                                     if(states.isEmpty){
                                       return  Colors.white


;
                                     }
                                     return Colors.purpleAccent;
                                   })

                               ),
                             ),
                           ),
                           SizedBox(height: MediaQuery.of(context).size.height * 0.008,),
                           Text("Not Registered yet?",style: TextStyle(color: Colors.white),),
                           SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                           GestureDetector(onTap: (){
                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Register()));
                           }, child: Text("Register",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
                           ),
                           SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                           GestureDetector(onTap: (){
                             showDialog(context: context, builder: (context){
                               return AlertDialog(
                                 backgroundColor: Colors.deepPurple,
                                 content: Container(
                                   height: MediaQuery.of(context).size.height * 0.4,
                                   child: Column(
                                     children: [

                                      Text("Forget Password",style: TextStyle(fontSize: 22,color: Colors.red),),
                                       SizedBox(height: MediaQuery.of(context).size.height * 0.04,),

                                       Container(
                                         width: MediaQuery.of(context).size.width * 0.5,
                                         child: TextFormField(
                                           inputFormatters: [
                                             LengthLimitingTextInputFormatter(10)
                                           ],
                                           style: TextStyle(color: Colors.white
                                           ),
                                           keyboardType: TextInputType.number,
                                           cursorColor: Colors.blue,
                                           decoration: InputDecoration(
                                               enabledBorder: OutlineInputBorder(
                                                 borderRadius: BorderRadius.circular(18),
                                                 borderSide: BorderSide(
                                                     color: Colors.lightBlueAccent, width: 5.0),
                                               ),
                                               focusedBorder: OutlineInputBorder(
                                                 borderRadius: BorderRadius.circular(18),
                                                 borderSide: BorderSide(
                                                     color: Colors.lightBlueAccent, width: 3.0),
                                               ),
                                               contentPadding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                                               hintText: "Registered Phone Number",
                                               hintStyle: TextStyle(fontWeight: FontWeight.w500 , fontSize: 18,color: Colors.white)
                                           ),
                                           onFieldSubmitted: (String val){
                                             setState(() {
                                               this.Phone = val ;
                                             });
                                           },
                                           onChanged: (String val){
                                             setState(() {
                                               this.Phone = val ;
                                             });
                                           },

                                         ),


                                       ),
                                       SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                                       Container(
                                         width: MediaQuery.of(context).size.width * 0.5,
                                         child: TextFormField(
                                           style: TextStyle(color: Colors.white
                                           ),
                                           cursorColor: Colors.purple,
                                           decoration: InputDecoration(
                                               enabledBorder: OutlineInputBorder(
                                                 borderRadius: BorderRadius.circular(18),
                                                 borderSide: BorderSide(
                                                     color: Color.fromRGBO(255, 215, 20, 1), width: 5.0),
                                               ),
                                               focusedBorder: OutlineInputBorder(
                                                 borderRadius: BorderRadius.circular(18),
                                                 borderSide: BorderSide(
                                                     color: Color.fromRGBO(206, 182, 76, 1), width: 3.0),
                                               ),
                                               contentPadding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                                               hintText: "New Password",
                                               hintStyle: TextStyle(fontWeight: FontWeight.w500 , fontSize: 18,color: Colors.white)
                                           ),
                                           onFieldSubmitted: (String val){
                                             setState(() {
                                               this.Password = val ;
                                             });
                                           },
                                           onChanged: (String val){
                                             setState(() {
                                               this.Password = val ;
                                             });
                                           },

                                         ),


                                       ),
                                       SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                                       ElevatedButton(
                                           onPressed: ()async{
                                             if(this.Phone.length != 10){
                                               showDialog(context: context, builder: (context){
                                                 return AlertDialog(
                                                   backgroundColor: Colors.deepPurple,
                                                   content: Text("Invalid Number",style: TextStyle(color: Colors.white70 , fontSize: 20),),
                                                 );
                                               });
                                             }
                                             else if(this.Password.length < 5){
                                               showDialog(context: context, builder: (context){
                                                 return AlertDialog(
                                                   backgroundColor: Colors.deepPurple,
                                                   content: Text("Password should be at least of 5 length",style: TextStyle(color: Colors.white70 , fontSize: 20),),
                                                 );
                                               });
                                             }
                                             else {
                                               String x =( Random().nextInt(100000) + 100000 ).toString();
                                               // return SmsSent(this.phoneNumber, x);
                                               final url = 'https://www.fast2sms.com/dev/bulkV2?authorization=pydDkmQV2fcsZASbB7orEiwlUvM3ejYxLa45zFu8ONqW1HJPnRyR18Xkm4TxAFnHPzMQD6te9ujfZaWs&route=otp&message=&variables_values=${x}&numbers=${this.Phone}';
                                               Navigator.push(context, MaterialPageRoute(builder: (context)=>Sms(x,"Nameless",this.Phone, Password, reg: false)));
                                               final response =  await get(Uri.parse(url));
                                               final resMp = response.body ;
                                               print(resMp.toString());
                                              }


                                       }, child: Text("Next"),
                                         style: ButtonStyle(
                                           backgroundColor: MaterialStateProperty.all(Colors.black)
                                         ),
                                       ),



                                     ],
                                   ),
                                 ),
                               );
                             });
                           }, child: Text("Forget Password",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white , fontSize: 16,shadows: [Shadow(color: Colors.red,blurRadius: 200)]),)
                           ),

                         ],
                       ),
                     ),
                   ),
                   ]
               ),


         ),
       );
     }
   }



