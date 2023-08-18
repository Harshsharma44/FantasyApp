// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfdropcheckoutpayment.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cfpaymentcomponents/cfpaymentcomponent.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
// import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
// import 'dart:math';
//
//
//
// class Test extends StatefulWidget {
//   const Test({Key? key}) : super(key: key);
//
//   @override
//   State<Test> createState() => _TestState();
// }
//
// class _TestState extends State<Test> {
//
//   var cfPaymentGatewayService = CFPaymentGatewayService();
//   String orderId = "";
//   String order = Random.secure().nextInt(1000).toString();
//   String customerId = Random.secure().nextInt(1000).toString()+ "GGEGEGEEWIGEGEWWEBGW";
//   String paymentSessionId = "session_p3KY5Z7l3JxKMQ0m-lBzc1xl6XIn3X7sVOlfgmpOpSMFOKDFKm38qvZAMPvuaiHtXXmoT1PbN-N3wxipNPqBK9LtoLmyUYvPgPr6HKO9ryMF";
//   CFEnvironment environment = CFEnvironment.SANDBOX;
//
//   getResponse()async{
//     var res = await http.post(
//       Uri.https("sandbox.cashfree.com", "pg/orders"),
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//         'x-api-version': '2022-09-01',
//         'x-client-id': "2851107f71e2090ffb22994aae011582",
//         'x-client-secret': "23b35b85a6fe67e730bd8498966f63e323656343",
//         'x-request-id': "Rattan_Satta",
//       },
//       body: jsonEncode(
//         {
//           "order_id": order,
//           "order_amount": 12,
//           "order_currency": "INR",
//           "customer_details": {
//
//             "customer_id": customerId,
//             "customer_name": "Harsh Sharma",
//             "customer_email": "harshhash322@gmail.com",
//             "customer_phone": "8319334945"
//           }
//
//         },
//       ),
//     );
//     return res;
//
// }
//
//
//   @override
//   void initState() {
//     super.initState();
//     cfPaymentGatewayService.setCallback(verifyPayment, onError);
//   }
//   InitialOrder()async{
//     http.Response response = await getResponse();
//     Map<String,dynamic> Respone = jsonDecode(response.body);
//     if(!Respone.isEmpty){
//       print("fehfewfhwefewj not availabel  e ${Respone}");
//     }
//     setState(() {
//       orderId = Respone['order_id'];
//       this.paymentSessionId = Respone['payment_session_id'];
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: Center(
//           child: Column(
//             children: [
//               TextButton(onPressed: pay, child: const Text("Pay"))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void verifyPayment(String orderId) {
//     print("Verify Payment");
//   }
//
//   void onError(CFErrorResponse errorResponse, String orderId) {
//     print(errorResponse.getMessage());
//     print("Error while making payment");
//   }
//
//
//
//   CFSession? createSession() {
//     try {
//       var session = CFSessionBuilder().setEnvironment(environment).setOrderId(orderId).setPaymentSessionId(paymentSessionId).build();
//       return session;
//     } on CFException catch (e) {
//       print(e.message);
//     }
//     return null;
//   }
//
//  void pay() async {
//     try {
//       await InitialOrder();
//       var session = createSession();
//       List<CFPaymentModes> components = <CFPaymentModes>[];
//       var paymentComponent = CFPaymentComponentBuilder().setComponents(components).build();
//
//       var theme = CFThemeBuilder().setNavigationBarBackgroundColorColor("#FF3000").setPrimaryFont("Menlo").setSecondaryFont("Futura").build();
//
//       var cfDropCheckoutPayment = CFDropCheckoutPaymentBuilder().setSession(session!).setPaymentComponent(paymentComponent).setTheme(theme).build();
//      var jj=  cfPaymentGatewayService.doPayment(cfDropCheckoutPayment);
//     } on CFException catch (e) {
//       print(e.message + "hulalalahu yaah");
//     }
//
//   }
//
// }