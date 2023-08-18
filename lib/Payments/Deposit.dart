import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:djdigital/Admin Panel.dart';
import 'package:url_launcher/url_launcher.dart';

    class Deposit extends StatefulWidget {
      String UserPhone ;
      String Currency ;
      String whatPhone = "";
      String Name ;
      Deposit({required this.UserPhone , required this.Currency,required this.Name});

      @override
      State<Deposit> createState() => _DepositState();
    }

    class _DepositState extends State<Deposit> {
      String Amount = "";


      // String? _upiAddrError;
      //
      // final _upiAddressController = TextEditingController();
      // final _amountController = TextEditingController();
      //
      // bool _isUpiEditable = false;
      // List<ApplicationMeta>? _apps;
      // void dispose() {
      //   _amountController.dispose();
      //   _upiAddressController.dispose();
      //   super.dispose();
      // }
      //
      // void _generateAmount() {
      //   setState(() {
      //     _amountController.text =
      //         (Random.secure().nextDouble() * 10).toStringAsFixed(2);
      //   });
      // }
      // String? _validateUpiAddress(String value) {
      //   if (value.isEmpty) {
      //     return 'UPI VPA is required.';
      //   }
      //   if (value.split('@').length != 2) {
      //     return 'Invalid UPI VPA';
      //   }
      //   return null;
      // }
      //
      // Future<void> _onTap(ApplicationMeta app) async {
      //   final err = _validateUpiAddress(_upiAddressController.text);
      //   if (err != null) {
      //     setState(() {
      //       _upiAddrError = err;
      //     });
      //     return;
      //   }
      //   setState(() {
      //     _upiAddrError = null;
      //   });
      //
      //   final transactionRef = Random.secure().nextInt(1 << 32).toString();
      //   print("Starting transaction with id $transactionRef");
      //
      //   final a = await UpiPay.initiateTransaction(
      //     amount: _amountController.text,
      //     app: app.upiApplication,
      //     receiverName: 'Sharad',
      //     receiverUpiAddress: _upiAddressController.text,
      //     transactionRef: transactionRef,
      //     transactionNote: 'UPI Payment',
      //     // merchantCode: '7372',
      //   );
      //
      //   print(a);
      // }


      @override
      callNumer() async {
        String tel= "tel: ${widget.whatPhone}";
        try {
          await launchUrl(Uri.parse(tel));
        } catch (_e) {
          return print(_e);
        }

      }
      getWhatsapp()async{
        final snap = await FirebaseFirestore.instance.collection('whatsapp').doc('id').get();
        final datas = await snap.data();
        widget.whatPhone = datas!['whatsapp'];

      }
      void initState() {
        getWhatsapp();
        super.initState();
      }





      // void initState() {
      //   super.initState();
      //
      //   _amountController.text =
      //       (Random.secure().nextDouble() * 10).toStringAsFixed(2);
      //
      //   Future.delayed(Duration(milliseconds: 0), () async {
      //     _apps = await UpiPay.getInstalledUpiApplications(
      //         statusType: UpiApplicationDiscoveryAppStatusType.all);
      //     setState(() {});
      //   });
      // }
      void launcher({required int number , required String message})async{
        String url = "whatsapp://send?phone=$number&text=$message";
        if(url!=null)  await launchUrl(Uri.parse(url));
        else {print("Not bow ");}

      }
      void sendPayment(String num) async {
       final datta =  await FirebaseFirestore.instance.collection('upi').doc('id').get();
       final MapUpi =  datta.data();
       String Upi = "Nto";

         Upi =  await MapUpi!['upi'];

       print(Upi);

        String upiurl = 'upi://pay?pa=${Upi}&pn=djdigital Matka&am=${num}&tn=djdigital MatkaPayment&cu=INR';
        bool oo = await launchUrl(Uri.parse(upiurl));
        print(oo);
      }

      Widget build(BuildContext context) {
        return Scaffold(
              appBar: AppBar(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.black,
                  statusBarIconBrightness: Brightness.light,

                ),
                  title: Text("ADD POINTS",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,),),
                  actions: [
                    const Icon(Icons.wallet , color: Colors.black,),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text(widget.Currency,style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 20,color: Colors.black),)),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03,)
                  ],
                  foregroundColor: Colors.black,
                  backgroundColor:  Colors.lightBlueAccent


              ),
              body: ListView(

                children: [

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
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                        Container(
                          margin: EdgeInsets.all(10),
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
                          child: Form(
                            child: Column(
                              children: [
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    child: Container(
                                      margin: EdgeInsets.only(top: 15),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                       borderRadius: BorderRadius.circular(26)
                                      ),
                                      height: MediaQuery.of(context).size.height * 0.08,
                                      width: MediaQuery.of(context).size.width * 0.9,
                                      child: Row(
                                        children: [
                                        const  Icon(Icons.currency_rupee),
                                          Expanded(
                                            child: TextFormField(
                                              keyboardType: TextInputType.number,
                                              decoration: InputDecoration(
                                               hintText: "Points to Add",
                                                hintStyle: TextStyle(fontSize: 18),
                                                contentPadding: EdgeInsets.only(left: 10),
                                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                                                disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                                              ),
                                              onChanged: (val){
                                                setState(() {
                                                  this.Amount = val;
                                                });
                                              },

                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ),
                                Container(
                                  decoration: BoxDecoration(
                                ),
                                  width:  MediaQuery.of(context).size.width * 0.9,
                                  height: MediaQuery.of(context).size.height * 0.06,
                                  margin: EdgeInsets.only(top: 10),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all( Colors.redAccent)
                                    ),
                                    onPressed: ()async{
                                      if(this.Amount == ""){
                                        return showDialog(context: context, builder: (context){
                                          return AlertDialog(
                                            backgroundColor: Colors.deepPurple,
                                            content: Text("Please Enter an Amount",style: TextStyle(color: Colors.white70 , fontSize: 20),),
                                          );
                                        });
                                      }
                                      int A = int.parse(this.Amount);
                                      if(A<500){
                                        return showDialog(context: context, builder: (context){
                                          return AlertDialog(
                                            backgroundColor: Colors.deepPurple,
                                            content: Text("Deposit Amount should be 500 minimum!",style: TextStyle(color: Colors.white70 , fontSize: 20),),
                                          );
                                        });

                                      }
                                      String Id = RandomGenerator.generateRandomString(8);
                                      final docUser = await FirebaseFirestore.instance.collection("Deposits").doc(Id);
                                      await docUser.set(
                                          {
                                            "Phone": widget.UserPhone,
                                            "Amount": this.Amount,
                                            "Id": Id,
                                            "Name": widget.Name
                                          }
                                      );
                                      sendPayment(this.Amount);


                                    },
                                    child: Center(child: const Text("Add Points in Account", style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w500),)),

                                  )
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.07,),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.88,
                                    child: Column(
                                      children: [
                                        //करावे इस नंबर पर
                                        Row(
                                          children: [
                                            Expanded(child: Text("* PhonePe, Google Pay और Paytm के माध्यम से पैसा जमा करावे",style: TextStyle(color: Colors.white),)),
                                          ],
                                        ),

                                        SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                                        Row(
                                          children: [
                                            Expanded(child: Text("* Minimum Points Add 500 होगा ( 1 Point = 1 Rs)         ",style: TextStyle(color: Colors.white),),)
                                          ],
                                        ),
                                        SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                                        Text("* Add Points in Account करके Admin से contact जरुर करें (WhatsApp और Call पर)",style: TextStyle(color: Colors.white , fontSize: 14),),
                                        SizedBox(height: MediaQuery.of(context).size.height * 0.07,),
                                        Row(
                                          children: [
                                            SizedBox(width: MediaQuery.of(context).size.width * 0.09,),
                                            ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor: MaterialStateProperty.all(Colors.lightGreen),
                                                    foregroundColor: MaterialStateProperty.all(Colors.black87)
                                                ),
                                                onPressed: (){
                                                  launcher(number: int.parse('91' + widget.whatPhone), message: "Hi");
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
                                      ],
                                    ))

                              ],
                            ),
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
