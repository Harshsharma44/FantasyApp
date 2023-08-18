

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:djdigital/Admin Panel.dart";
import 'package:djdigital/Main%20page.dart';
import 'package:url_launcher/url_launcher.dart';
class Withdraw extends StatefulWidget {
  String UserPhone;
  String Currency ;
  String Name ;
  String whatPhone = "";
  Withdraw({required this.UserPhone , required this.Currency , required this.Name});
  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  List<String> list = ["PhonePe", "GooglePay","Paytm","Others"];
  String? vale = "PhonePe";
  String Phone = "";
  String Amount = "";

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
  callNumer() async {
    String tel = "tel: ${widget.whatPhone}";
    try {
      await launchUrl(Uri.parse(tel));
    } catch (_e) {
      return print(_e);
    }
  }
  void launcher({required int number , required String message})async{
    String url = "whatsapp://send?phone=$number&text=$message";
    if(url!=null)  await launchUrl(Uri.parse(url));
    else {print("Not bow ");}

  }
    Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor:  Colors.lightBlueAccent
,
                statusBarIconBrightness: Brightness.dark,
              ),
              title: Text("WITHDRAWL",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,),),
              foregroundColor: Colors.black,
              actions: [
                const Icon(Icons.wallet , color: Colors.black,),
                SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(widget.Currency,style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 20,color: Colors.black),)),
                SizedBox(width: MediaQuery.of(context).size.width * 0.03,)
              ],
              backgroundColor:  Colors.lightBlueAccent


          ),
          body: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.redAccent,
    ),
                alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 25),
              height: MediaQuery.of(context).size.height * 0.06,
              child: Text("Withdrawl Available from 8 AM to 12 PM",style: TextStyle(shadows: [Shadow(color: Colors.black,blurRadius: 2 )],fontSize: 17,color: Colors.white),)
              ),
              Container(
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                  ),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 25),
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: Text("Minimum withdrawl amount should be 1000!",style: TextStyle(shadows: [Shadow(color: Colors.black,blurRadius: 2 )],fontSize: 17,color: Colors.white),)
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.92,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/paymentBG.png'),
                          fit: BoxFit.cover
                      )

                  ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),

                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(9, 5, 5, 0.24),
                              Color.fromRGBO(9, 5, 5, 0.46),
                            ]
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                          Container(
                            margin: EdgeInsets.only(top: 20 , bottom: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black)
                            ),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10)
                              ],
                              onChanged: (val){
                                this.Phone = val ;
                              },
                              decoration: InputDecoration(
                                hintText: "Enter Phone Number/Enter UPI ID",
                                contentPadding: EdgeInsets.only(left: 20)
                              ),
                            )
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 8,bottom: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black)
                              ),
                              child: TextField(
                                keyboardType: TextInputType.number,

                                onChanged: (val){
                                  this.Amount = val ;
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter Points to Withdraw",
                                    contentPadding: EdgeInsets.only(left: 20)
                                ),
                              )
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                          DropdownButton(
                            items: this.list.map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                      child: Text(e , style: TextStyle(color: Colors.yellow ),))
                          ).toList(),
                            onChanged: (val){
                            setState(() {
                              this.vale = val;
                            });
                          },
                            value: this.vale,
                            iconEnabledColor: Colors.white,
                            dropdownColor: Colors.black,
                          ),
                          Container(
                              padding: EdgeInsets.only(left: 7,top: 5),
                              child: Text("जिस भी माध्यम से पैसा लेना चाहते हैं कृपया उसे Select करें",style: TextStyle(color: Colors.white,fontSize: 16),)),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                          Container(
                           width: double.maxFinite - MediaQuery.of(context).size.width * 0.06,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                maximumSize: MaterialStateProperty.resolveWith((states) {
                                  if(states.isEmpty){
                                    return Size(MediaQuery.of(context).size.width * 0.6, MediaQuery.of(context).size.height * 0.5);
                                  }
                                  return Size(MediaQuery.of(context).size.width * 0.3, MediaQuery.of(context).size.height * 0.6);
                                }
                                ),
                                  backgroundColor: MaterialStateProperty.all( Colors.redAccent)
                              ),
                              onPressed: ()async{
                                int C = int.parse(widget.Currency);
                                if(DateTime.now().hour < 8 || DateTime.now().hour >= 12 ){
                                  return showDialog(context: context, builder: (context){
                                    return const AlertDialog(
                                      backgroundColor: Colors.deepPurple,
                                      content: Text("Withdrawl is available from 8 AM to 12 PM",style: TextStyle(color: Colors.white70 , fontSize: 20),),
                                    );
                                  });
                                }
                                if(this.Amount == ""){
                                  return showDialog(context: context, builder: (context){
                                    return AlertDialog(
                                      backgroundColor: Colors.deepPurple,
                                      content: Text("Please Enter an Amount",style: TextStyle(color: Colors.white70 , fontSize: 20),),
                                    );
                                  });
                                }
                                int A = int.parse(this.Amount);

                                if(C < A ){
                                  return showDialog(context: context, builder: (context){
                                    return AlertDialog(
                                      backgroundColor: Colors.deepPurple,
                                      content: Text("Insufficient Funds",style: TextStyle(color: Colors.white70 , fontSize: 20),),
                                    );
                                  });
                                }
                                else if(A<1000){
                                  return showDialog(context: context, builder: (context){
                                    return const AlertDialog(
                                      backgroundColor: Colors.deepPurple,
                                      content: Text("Withdrawl Amount should be 1000 minimum!",style: TextStyle(color: Colors.white70 , fontSize: 20),),
                                    );
                                  });

                                }
                                else if(this.Phone.length != 10){
                                  return showDialog(context: context, builder: (context){
                                    return AlertDialog(
                                      backgroundColor: Colors.deepPurple,
                                      content: Text("Please Enter a valid Phone Number",style: TextStyle(color: Colors.white70 , fontSize: 20),),
                                    );
                                  });
                                }
                                String Id = RandomGenerator.generateRandomString(8);
                                final docUser = await FirebaseFirestore.instance.collection("Withdrawls").doc(Id);
                               await docUser.set(
                                  {
                                    "Phone": this.Phone,
                                    "Amount": this.Amount,
                                    "Method": this.vale,
                                    "Id": Id,
                                    "Name": widget.Name
                                  }
                                );
                               C = C - A ;

                               await FirebaseFirestore.instance.collection("Amounts").doc(widget.UserPhone).update({
                                 "Amount": C.toString()
                               });
                            Navigator.pop(context);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Main(UserPhone: widget.UserPhone)));

                              },
                              child: Text("Submit Request",style: TextStyle(fontWeight: FontWeight.w500 ,color: Colors.white),),
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                          Row(
                            children: [
                              SizedBox(width: MediaQuery.of(context).size.width * 0.09,),
                              ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.lightGreen),
                                      foregroundColor: MaterialStateProperty.all(Colors.black87)
                                  ),
                                  onPressed: (){
                                    launcher(number: int.parse('91' + widget.whatPhone), message: "Hello");
                                  }, child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.message,color: Colors.white,),
                                    SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                                    const Text("Whatsapp",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),)
                                  ],
                                ),

                              )),
                              SizedBox(width: MediaQuery.of(context).size.width *0.1,),
                              ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.lightGreen),
                                      foregroundColor: MaterialStateProperty.all(Colors.black87)
                                  ),
                                  onPressed: (){
                                    callNumer();
                                  }, child: Container(
                                child: Row(
                                  children: [
                                    const Icon(Icons.call,color: Colors.white,),
                                    SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                                    const Text("Call",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),)
                                  ],
                                ),

                              )),
                            ],
                          ),

                          Container(
                            padding: EdgeInsets.only(left: 7,top: 5),
                            child: Text("Bank Account Number के माध्यम से Withdrawal लेने के लिए कृपया WhatsApp पर संपर्क करें अन्यथा Call करे",style: TextStyle(color: Colors.white),))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
  }
}
