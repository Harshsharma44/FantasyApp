import 'package:flutter/material.dart';
import 'package:djdigital/MultiUserInput.dart';
import 'MultiBet.dart';
class MultiGameSelection extends StatelessWidget {
  String UserPhone;
 List<Bet> bets; 
  String Name ;
  String Id;
  String Type;
  late int a ;
  MultiGameSelection({required this.Name ,required this.Id,required this.UserPhone,required this.Type ,required this.bets});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          title: Text("Select Market",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,),),
          foregroundColor: Colors.white,

          backgroundColor: Colors.deepPurple

      ),
      body: ListView(
        children: [

          Container(
            color: Color.fromRGBO(255, 215, 0, 1),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height * 0.23,

                  child: Row(
                    children: [
                      InkWell(
                        onTap: (){
                          a =1 ;
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MultiUserInput(Id: this.Id, Name: this.Name, a: this.a,UserPhone: this.UserPhone,Type: this.Type, bets: this.bets)));
                        },
                        child: Container(
                          margin: EdgeInsets.only( right: 12, top: 10),
                          child: Image.asset("images/8.png",height: MediaQuery.of(context).size.height * 0.9,width: MediaQuery.of(context).size.width * 0.5,),
                          width: MediaQuery.of(context).size.width * 0.45,
                          decoration: BoxDecoration(
                              color: Colors.black


                              ,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.only(topRight: Radius.circular(20) , bottomLeft: Radius.circular(20) , bottomRight: Radius.circular(50) , topLeft: Radius.circular(50))
                          ),

                        ),
                      ),
                      this.Type == 'Main'? InkWell(
                        onTap: (){
                          a =2 ;
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MultiUserInput(Id: this.Id, Name: this.Name, a: this.a,UserPhone: this.UserPhone,Type: this.Type,bets: this.bets,)));

                        },
                        child: Container(
                          margin: EdgeInsets.only( right: 5, top: 10),
                          child: Image.asset("images/9.png",height: MediaQuery.of(context).size.height * 0.9,width: MediaQuery.of(context).size.width * 0.5,),
                          width: MediaQuery.of(context).size.width * 0.45,
                          decoration: BoxDecoration(
                              color: Colors.black


                              ,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.only(topRight: Radius.circular(20) , bottomLeft: Radius.circular(20) , bottomRight: Radius.circular(50) , topLeft: Radius.circular(50))
                          ),


                        ),
                      ) : SizedBox(),

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height * 0.23,

                  child: Row(
                    children: [
                      InkWell(
                        onTap: (){
                          a=3 ;
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MultiUserInput(Id: this.Id, Name: this.Name, a: this.a,UserPhone: this.UserPhone,Type: this.Type, bets: this.bets)));

                        },
                        child: Container(
                          margin: EdgeInsets.only( right: 12, top: 10),
                          child: Image.asset("images/10.png",height: MediaQuery.of(context).size.height * 0.9,width: MediaQuery.of(context).size.width * 0.5,),
                          width: MediaQuery.of(context).size.width * 0.45,
                          decoration: BoxDecoration(
                              color: Colors.black


                              ,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.only(topRight: Radius.circular(20) , bottomLeft: Radius.circular(20) , bottomRight: Radius.circular(50) , topLeft: Radius.circular(50))
                          ),

                        ),
                      ),
                      InkWell(
                        onTap: (){
                          a=4;
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MultiUserInput(Id: this.Id, Name: this.Name, a: this.a,UserPhone: this.UserPhone,Type: this.Type, bets: this.bets)));

                        },
                        child: Container(
                          margin: EdgeInsets.only( right: 5, top: 10),
                          child: Image.asset("images/11.png",height: MediaQuery.of(context).size.height * 0.9,width: MediaQuery.of(context).size.width * 0.5,),
                          width: MediaQuery.of(context).size.width * 0.45,
                          decoration: BoxDecoration(
                              color: Colors.black


                              ,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.only(topRight: Radius.circular(20) , bottomLeft: Radius.circular(20) , bottomRight: Radius.circular(50) , topLeft: Radius.circular(50))
                          ),


                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height * 0.23,

                  child: Row(
                    children: [
                      InkWell(
                        onTap: (){
                          a=5;
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MultiUserInput(Id: this.Id, Name: this.Name, a: this.a,UserPhone: this.UserPhone,Type: this.Type, bets: this.bets)));

                        },
                        child: Container(
                          margin: EdgeInsets.only( right: 12, top: 10),
                          child: Image.asset("images/12.png",height: MediaQuery.of(context).size.height * 0.9,width: MediaQuery.of(context).size.width * 0.5,),
                          width: MediaQuery.of(context).size.width * 0.45,
                          decoration: BoxDecoration(
                              color: Colors.black


                              ,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.only(topRight: Radius.circular(20) , bottomLeft: Radius.circular(20) , bottomRight: Radius.circular(50) , topLeft: Radius.circular(50))
                          ),

                        ),
                      ),
                      this.Type == 'Main' ? InkWell(
                        onTap: (){
                          a=-1;
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MultiUserInput(Id: this.Id, Name: this.Name, a: this.a,UserPhone: this.UserPhone,Type: this.Type, bets: this.bets)));

                        },
                        child: Container(
                          margin: EdgeInsets.only( right: 5, top: 10),
                          child: Image.asset("images/13.png",height: MediaQuery.of(context).size.height * 0.9,width: MediaQuery.of(context).size.width * 0.5,),
                          width: MediaQuery.of(context).size.width * 0.45,
                          decoration: BoxDecoration(
                              color: Colors.black


                              ,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.only(topRight: Radius.circular(20) , bottomLeft: Radius.circular(20) , bottomRight: Radius.circular(50) , topLeft: Radius.circular(50))
                          ),


                        ),
                      ) : SizedBox(),

                    ],
                  ),
                ),

              ],
            ),
          ),

          this.Type == 'Main' ? Container(
            color: Color.fromRGBO(255, 215, 0, 1),
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.3,
            child: InkWell(
              onTap: (){
                a=-2;
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MultiUserInput(Id: this.Id, Name: this.Name, a: this.a,UserPhone: this.UserPhone,Type: this.Type, bets: this.bets)));

              },
              child: Container(

                margin: EdgeInsets.only(left: 10,right: 10),
                child: Image.asset("images/14.png",),
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                    color: Colors.black


                    ,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20) , bottomRight: Radius.circular(20))
                ),


              ),
            ),
          ) : SizedBox(),


        ],
      ),
    );
  }
}
