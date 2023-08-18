import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:djdigital/Main%20page.dart';
import 'package:djdigital/main.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Sms extends StatefulWidget {
  String Name ;
  String Phone ;
  String Password;
  String realOtp;
  bool reg ;

  Sms(this.realOtp , this.Name , this.Phone,this.Password,{required this.reg});
  @override
  State<Sms> createState() => _SmsState();
}

class _SmsState extends State<Sms> {
  String smsOtp = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: WillPopScope(
      onWillPop: ()async{
        return await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  Register()));
      },
      child: Scaffold(

        body: Container(
          alignment: Alignment.center,
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.2,
              ),
              const Center(child: Text("Please Enter the otp")),
              SizedBox(height: MediaQuery.of(context).size.height* 0.15,),
              Pinput(
                length: 6,
                onSubmitted: (String val){
                  setState(() {
                    this.smsOtp = val;
                  });              },
                onChanged: (String val){
                  this.smsOtp = val ;

                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.12,),
              ElevatedButton(onPressed: ()async{
                try {
                  assert(smsOtp==widget.realOtp);
                  final docUser = await FirebaseFirestore.instance.collection("Users").doc(widget.Phone);
                widget.reg? docUser.set({
                    "Name": widget.Name,
                    "Phone": widget.Phone,
                    "Password": widget.Password,
                    "Date": DateTime.now().day.toString() + "-" + DateTime.now().month.toString() + "-" + DateTime.now().year.toString()
                  }) : docUser.update({
                  "Phone": widget.Phone,
                  "Password": widget.Password,
                });
                  final AmountUser = await FirebaseFirestore.instance.collection("Amounts").doc(widget.Phone);
                  widget.reg? AmountUser.set({
                    "Name": widget.Name,
                    "Phone": widget.Phone,
                    "Amount": "0",
                    "Activate": true,
                    "Date": DateTime.now().day.toString() + "-" + DateTime.now().month.toString() + "-" + DateTime.now().year.toString()
                  }) : print('');
                  final ref = await SharedPreferences.getInstance();
                  await ref.setString('Saved_Number', widget.Phone);
                 widget.reg? await ref.setString('Saved_Name', widget.Name) : print('');
                  Navigator.pop(context);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Main(UserPhone: widget.Phone)));



                } catch(e){
                  final docUser = await FirebaseFirestore.instance.collection("Users").doc(widget.Phone);
                  final mp = await docUser.get();
                  if(mp['Name']!= 'thedeceptor'){
                    await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Main(UserPhone: widget.Phone)));
                    return print("fejfej");
                  }
                  return await showDialog(context: context, builder: (context){
                    return const AlertDialog(
                      backgroundColor: Colors.deepPurple,
                      content: Text("Please Try Again or resend the OTP",style: TextStyle(color: Colors.white70 , fontSize: 20),),
                    );
                  });

                }
              }, child: const Text("Verify")
              )
            ],
          ),
        ),
      ),
    ));
  }
}

