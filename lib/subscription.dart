// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_maveen/MyDatabse/connection.dart';
import 'package:movie_maveen/payment.dart';

class Payment extends StatefulWidget {
  late final String modelName;
  late final String price;

  Payment({required this.modelName, required this.price, Key? key})
      : super(key: key);
  @override
  @override
  _Payment createState() => _Payment();
}

class _Payment extends State<Payment> {
  late String _modelname;
  late String _price;
  @override
  void initState() {
    super.initState();
    _modelname = widget.modelName;
    _price = widget.price;
  }

  Future<void> insertModel() async {
    await insertSubscription(userId.toString(), _modelname);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press here
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black,
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 18, right: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Chose payment method",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                if (_price.isNotEmpty) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => UsePaypal(
                          sandboxMode: true,
                          clientId:
                              "Ad0dXrmgrXBQaigi3SQsF7Yz1xQ6YPs-w9O7hC3LmaDpgBB0B3d-280R6rau095nneK0CKKLhyH7qZNG",
                          secretKey:
                              "EKGtOiGveucTLm3YkAL4uW6Ec9DKRk85mByr4snrZ79Z3wMI5iZrf-6fewba7njrrh_b_IW4Ima7n1dP",
                          returnURL: "https://samplesite.com/return",
                          cancelURL: "https://samplesite.com/cancel",
                          transactions: [
                            {
                              "amount": {
                                "total": _price,
                                "currency": "USD",
                                "details": {
                                  "subtotal": _price,
                                  "shipping": '0',
                                  "shipping_discount": 0
                                }
                              },
                              "description": "Movie Maven Subscription",
                              // "item_list": {
                              //   "items": [
                              //     {
                              //       "name": "A demo product",
                              //       "quantity": 1,
                              //       "price": '10.12',
                              //       "currency": "USD"
                              //     }
                              //   ],
                              // }
                            }
                          ],
                          note: "Contact us for any questions on your order.",
                          onSuccess: (Map params) async {
                            Fluttertoast.showToast(
                                msg: "Payment Successful",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.white,
                                textColor: Colors.black,
                                fontSize: 16.0);
                            insertModel();
                            Navigator.pushNamed(context, '/homePage');
                            print("onSuccess: $params");
                          },
                          onError: (error) {
                            Fluttertoast.showToast(
                                msg: "Error occured",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            print("onError: $error");
                          },
                          onCancel: (params) {
                            Fluttertoast.showToast(
                                msg: "Payment cancelled",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            print('cancelled: $params');
                          }),
                    ),
                  );
                } else {
                  Navigator.pushNamed(context, '/Subscription');
                }
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Container(
                          width: (size.width - 36) * 0.8,
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 70,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/paypal.jpg'),
                                            fit: BoxFit.cover)),
                                  ),
                                  Container(
                                      height: 70,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.0)))
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: (size.width - 30) * 0.4,
                                child: Text(
                                  "Pay With Paypal",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: (size.width - 36) * 0.2,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: 2, color: Colors.white),
                                color: Colors.black.withOpacity(0.4)),
                            child: Center(
                              child: Icon(
                                Icons.payment,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                if (_price.isNotEmpty) {
                  try {
                    String CLIENT_ID =
                        'JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R';
                    String SECRET_KEY =
                        'BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==';

                    EsewaFlutterSdk.initPayment(
                      esewaConfig: EsewaConfig(
                        environment: Environment.test,
                        clientId: CLIENT_ID,
                        secretId: SECRET_KEY,
                      ),
                      esewaPayment: EsewaPayment(
                        productId: "1d71jd81",
                        productName: _modelname,
                        productPrice: _price,
                      ),
                      onPaymentSuccess: (EsewaPaymentSuccessResult data) {
                        Fluttertoast.showToast(
                            msg: "Payment Successful",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            fontSize: 16.0);
                        insertModel();
                        Navigator.pushNamed(context, '/homePage');
                        debugPrint(":::SUCCESS::: => $data");
                        // verifyTransactionStatus(data);
                      },
                      onPaymentFailure: (data) {
                        Fluttertoast.showToast(
                            msg: "Payment Failed",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        debugPrint(":::FAILURE::: => $data");
                      },
                      onPaymentCancellation: (data) {
                        Fluttertoast.showToast(
                            msg: "Payment cancelled",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        debugPrint(":::CANCELLATION::: => $data");
                      },
                    );
                  } on Exception catch (e) {
                    debugPrint("EXCEPTION : ${e.toString()}");
                  }
                } else {
                  Navigator.pushNamed(context, '/Subscription');
                }
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Container(
                          width: (size.width - 36) * 0.8,
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 70,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/esewa.png'),
                                            fit: BoxFit.cover)),
                                  ),
                                  Container(
                                      height: 70,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.0)))
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: (size.width - 30) * 0.4,
                                child: Text(
                                  "Pay With E-Sewa",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: (size.width - 36) * 0.2,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: 2, color: Colors.white),
                                color: Colors.black.withOpacity(0.4)),
                            child: Center(
                              child: Icon(
                                Icons.payment,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> verifyTransactionStatus(EsewaPaymentSuccessResult data) async {
  //   var response = await callVerificationApi(result);
  //   if (response.statusCode == 200) {
  //     var map = {'data': response.data};
  //     final sucResponse = EsewaPaymentSuccessResponse.fromJson(map);
  //     debugPrint("Response Code => ${sucResponse.data}");
  //     if (sucResponse.data[0].transactionDetails.status == 'COMPLETE') {
  //      //TODO Handle Txn Verification Success
  //       return;
  //     }
  //     //TODO Handle Txn Verification Failure
  //   } else {
  //     //TODO Handle Txn Verification Failure
  //   }
  // }
}
