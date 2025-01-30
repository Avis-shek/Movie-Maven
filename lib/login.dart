// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, avoid_types_as_parameter_names, non_constant_identifier_names, avoid_print, await_only_futures, use_build_context_synchronously

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_maveen/MyDatabse/connection.dart';
import 'package:movie_maveen/register.dart';
import 'models/goodBadClassifier.dart';
import 'models/predictor.dart';
import 'models/recommeder.dart';

String Name = '';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Future<bool> hasBoughtSubscription() async {
    final SubscriptionData = await getSubscriptionsByUserId(userId.toString());
    if (SubscriptionData.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool invalidCredentials = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>(); //key for form
  Icon accountIcon = Icon(
    Icons.account_circle,
    color: Colors.red,
  );
  double val = 0;
  bool switchScreen = true;
  Timer loginTimer = Timer(Duration(seconds: 1), () {});
  bool showPass = true;
  Icon visOn = Icon(
    Icons.visibility,
    color: Colors.white,
  );
  Icon visOff = Icon(
    Icons.visibility_off,
    color: Colors.white,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Flutter Demo'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            // ignore: prefer_const_literals_to_create_immutables
            colors: [
              Colors.red,
              Colors.black,
              Colors.black,
              Colors.black,
              Colors.black,
              Colors.black,
              Colors.red,
            ],
          ),
          borderRadius: BorderRadius.circular(55.0),
        ),
        child: Center(
          child: TweenAnimationBuilder<double>(
            tween: Tween(
              begin: 0,
              end: val,
            ),
            duration: Duration(seconds: 1),
            builder: (_, value, child) => Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(value),
              child: child,
              alignment: Alignment.bottomCenter,
            ),
            child: switchScreen
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.red,
                            Colors.black,
                            Colors.black,
                          ]),
                      borderRadius: BorderRadius.circular(55.0),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100,
                            width: 200,
                            child: Center(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            child: Container(
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: Form(
                                  key: formKey,
                                  child: Column(children: [
                                    TextFormField(
                                      controller: _emailController,
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 0),
                                        prefixIcon: accountIcon,
                                        labelText: 'Username',
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                        alignLabelWithHint: true,
                                        hintText: 'Enter email or username',
                                        hintStyle:
                                            TextStyle(color: Colors.white38),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 2,
                                            color: Colors.red,
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 2,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        invalidCredentials = false;
                                        if (value == null || value.isEmpty) {
                                          return 'Enter email or username';
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                        controller: _passwordController,
                                        cursorColor: Colors.red,
                                        style: TextStyle(color: Colors.white),
                                        obscureText: showPass,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 0, vertical: 0),
                                          prefixIcon: Icon(
                                            Icons.security,
                                            color: Colors.red,
                                          ),
                                          suffixIcon: IconButton(
                                            //icon: showPass ? visOff: visOn,
                                            icon: showPass ? visOn : visOff,
                                            onPressed: () {
                                              setState(() {
                                                showPass = !showPass;
                                              });
                                            },
                                          ),
                                          labelText: 'Password',
                                          labelStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                          alignLabelWithHint: true,
                                          hintText: 'Enter your password',
                                          hintStyle:
                                              TextStyle(color: Colors.white38),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 2,
                                              color: Colors.red,
                                            ),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 2,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        validator: (value) {
                                          invalidCredentials = false;
                                          if (value == null || value.isEmpty) {
                                            return 'Enter Your Password';
                                          }
                                        }),
                                  ])),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Opacity(
                            opacity: invalidCredentials ? 1.0 : 0.0,
                            child: const Text(
                              'Invalid username or password',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/forgetPassword');
                              },
                              child: Text(
                                'Forgot Password?   ',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: 200,
                            child: ElevatedButton(
                              onPressed: () async {
                                userselected = false;
                                if (formKey.currentState!.validate()) {
                                  await selectUsers(_emailController.text,
                                      _passwordController.text);
                                  if (userselected) {
                                    invalidCredentials = false;
                                    Fluttertoast.showToast(
                                        msg: "Logged in successfully",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.white,
                                        textColor: Colors.black,
                                        fontSize: 16.0);
                                    if (await hasBoughtSubscription()) {
                                      Navigator.pushNamed(context, '/homePage');
                                    } else {
                                      Navigator.pushNamed(
                                          context, '/Subscription');
                                    }
                                  } else {
                                    setState(() {
                                      //userselected = false;
                                      invalidCredentials = true;
                                    });
                                    Fluttertoast.showToast(
                                        msg: "Invalid username or password.",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white70,
                                        fontSize: 16.0);
                                  }
                                }
                                
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(fontSize: 20),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.red),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                        color: Colors.red,
                                      )),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account? ',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    val = pi;
                                    loginTimer =
                                        Timer(Duration(milliseconds: 500), () {
                                      setState(() {
                                        switchScreen = false;
                                      });
                                    });
                                  });
                                },
                                child: Text(
                                  'Register Now',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                : Register(),
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
