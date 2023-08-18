import 'package:flutter/material.dart';


class Rates extends StatelessWidget {
  const Rates({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
          title: Text("Market Rates(Bhaav)",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,),),
          foregroundColor: Colors.black,

          backgroundColor: Colors.lightBlueAccent,

      ),
      body: ListView(
        children: [

          Container(
            padding: EdgeInsets.only(left: 20 , right:  20 ,top: 80,bottom: 130),
            height: MediaQuery.of(context).size.height * 0.92,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("images/paymentBG.png")
              )
            ),
            child: Container(
              decoration: BoxDecoration( 
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(9, 5, 5, 0.54),
                    Color.fromRGBO(9, 5, 5, 0.46),
                  ]
                ),
                  borderRadius: BorderRadius.circular(15)
              ),
              height: MediaQuery.of(context).size.height * 0.3,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                  Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                      Text("Single Digit", style: TextStyle(color: Colors.white,fontSize: 18),),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.45,),
                      Text("10-95",style: TextStyle(color: Colors.white,fontSize: 18),)
                    ],
                  ),
                  Divider(color: Colors.white,),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                  Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                      Text("Jodi Digit", style: TextStyle(color: Colors.white,fontSize: 18),),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.49,),
                      Text("10-950",style: TextStyle(color: Colors.white,fontSize: 18),)
                    ],
                  ),
                  Divider(color: Colors.white,),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                  Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                      Text("Single Panna", style: TextStyle(color: Colors.white,fontSize: 18),),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.42,),
                      Text("10-1400",style: TextStyle(color: Colors.white,fontSize: 18),)
                    ],
                  ),
                  Divider(color: Colors.white ,),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                  Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                      Text("Double Panna", style: TextStyle(color: Colors.white,fontSize: 18),),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.4,),
                      Text("10-2800",style: TextStyle(color: Colors.white,fontSize: 18),),

                    ],
                  ),
                  Divider(color: Colors.white ,),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                  Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                      Text("Triple Panna", style: TextStyle(color: Colors.white,fontSize: 18),),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.43,),
                      Text("10-7000",style: TextStyle(color: Colors.white,fontSize: 18),)
                    ],
                  ),
                  Divider(color: Colors.white ,),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                  Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                      Text("Half Sangam", style: TextStyle(color: Colors.white,fontSize: 18),),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.4,),
                      Text("10-10000",style: TextStyle(color: Colors.white,fontSize: 18),),

                    ],
                  ),
                  Divider(color: Colors.white ,),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                  Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                      Text("Full Sangam", style: TextStyle(color: Colors.white,fontSize: 18),),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.37,),
                      Text("10-100000",style: TextStyle(color: Colors.white,fontSize: 18),)
                    ],
                  )

                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}
