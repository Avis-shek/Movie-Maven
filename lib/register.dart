// ignore_for_file: non_constant_identifier_names, override_on_non_overriding_member, sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables, duplicate_ignore

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_maveen/login.dart';
import 'package:movie_maveen/functions.dart';
import 'MyDatabse/connection.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import 'otpScreen.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  final List<TextEditingController> _controllers =
      List.generate(3, (index) => TextEditingController());
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  String generateOTP() {
    // Generate a random 6-digit OTP
    final random = Random();
    final codeUnits = List.generate(4, (_) => random.nextInt(9) + 1);
    return codeUnits.join();
  }

  Future<void> sendOTP(String recipientEmail) async {
    String username = 'gavishek21@tbc.edu.np'; // Your email
    String password = 'Nepal@210'; // Your password

    final smtpServer = gmail(username, password);
    final otp = generateOTP(); // Generate OTP
    final message = Message()
      ..from = Address(username)
      ..recipients.add(recipientEmail) // Recipient's email address
      ..subject = 'OTP Verification'
      ..text =
          'Your OTP for verification is: $otp'; // Include the generated OTP

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Otp(email: recipientEmail, otp: otp),
        ),
      );
    } catch (e) {
      print('Error occurred while sending email: $e');
    }
  }

  bool _emailExists = false;
  String? _Password;
  Functions function = Functions();
  bool showPass = true;
  bool confirmShowPass = true;

  Icon visOn = Icon(
    Icons.visibility,
    color: Colors.white,
  );
  Icon visOff = Icon(
    Icons.visibility_off,
    color: Colors.white,
  );
  final formKey = GlobalKey<FormState>(); //key for form
  Icon accountIcon = Icon(
    Icons.account_circle,
    color: Colors.red,
  );
  Icon emailIcon = Icon(
    Icons.email,
    color: Colors.red,
  );
  bool switchScreen = true;
  Timer registerTimer = Timer(Duration(seconds: 1), () {});
  double val = 0;
  Widget build(BuildContext context) {
    return Form(
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
            ? Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(pi),
                child: Container(
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
                              'Register',
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
                                  controller: _controllers[0],
                                  style: TextStyle(color: Colors.white),
                                  // ignore: prefer_const_constructors
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 0),
                                    prefixIcon: accountIcon,
                                    labelText: 'FullName',
                                    // ignore: prefer_const_constructors
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                    alignLabelWithHint: true,
                                    hintText: 'Enter your fullname',
                                    hintStyle: TextStyle(color: Colors.white38),
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
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter your full name';
                                    } else {
                                      if (!RegExp(
                                              r'^([a-zA-Z]+)(\s[a-zA-Z]+)*$')
                                          .hasMatch(value)) {
                                        return 'Enter your full name';
                                      }
                                    }
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: _controllers[1]
                                    ..addListener(() async {
                                      _emailExists = await emailExists(
                                          _controllers[1].text);
                                      setState(() {});
                                    }),
                                  style: TextStyle(color: Colors.white),
                                  // ignore: prefer_const_constructors
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 0),
                                    prefixIcon: emailIcon,
                                    labelText: 'Email',
                                    // ignore: prefer_const_constructors
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                    alignLabelWithHint: true,
                                    hintText: 'Enter your email here',
                                    hintStyle: TextStyle(color: Colors.white38),
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
                                    if (function.emailIsEmpty(value)) {
                                      if (!function.gmailValidation(value)) {
                                        return 'Invalid email address';
                                      } else {
                                        if (_emailExists) {
                                          return 'User already exist with this email';
                                        }
                                      }
                                    } else {
                                      return 'Enter your email address';
                                    }
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: _controllers[2],
                                  cursorColor: Colors.red,
                                  style: TextStyle(color: Colors.white),
                                  obscureText: showPass,
                                  // ignore: prefer_const_constructors
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 0),
                                    prefixIcon: Icon(
                                      Icons.security,
                                      color: Colors.red,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: showPass ? visOn : visOff,
                                      onPressed: () {
                                        setState(() {
                                          showPass = !showPass;
                                        });
                                      },
                                    ),
                                    labelText: 'Password',
                                    // ignore: prefer_const_constructors
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                    alignLabelWithHint: true,
                                    hintText: 'Enter your password',
                                    hintStyle: TextStyle(color: Colors.white38),
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
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: (value) =>
                                      function.passwordValidation(value),
                                  onSaved: (value) => _Password = value,
                                  onChanged: (value) {
                                    setState(() {
                                      _Password = value;
                                    });
                                  },
                                  autovalidateMode: AutovalidateMode
                                      .onUserInteraction, // enable live validation
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  cursorColor: Colors.red,
                                  style: TextStyle(color: Colors.white),
                                  obscureText: confirmShowPass,
                                  // ignore: prefer_const_constructors
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 0),
                                    prefixIcon: Icon(
                                      Icons.security,
                                      color: Colors.red,
                                    ),
                                    suffixIcon: IconButton(
                                      //icon: showPass ? visOff: visOn,
                                      icon: confirmShowPass ? visOn : visOff,
                                      onPressed: () {
                                        setState(() {
                                          confirmShowPass = !confirmShowPass;
                                        });
                                      },
                                    ),
                                    labelText: 'Confirm Password',
                                    // ignore: prefer_const_constructors
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                    alignLabelWithHint: true,
                                    hintText: 'Confirm your password',
                                    hintStyle: TextStyle(color: Colors.white38),
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
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: (value) {
                                    if (value != _Password) {
                                      return 'Password does not match';
                                    }
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                SizedBox(
                                  width: 200,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        formKey.currentState!.save();
                                        //Send data to sqlite server
                                        insertUser(_controllers.cast<String>(),
                                            formKey);
                                        Fluttertoast.showToast(
                                            msg: "OTP sent to entered email",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.white54,
                                            textColor: Colors.black54,
                                            fontSize: 16.0);
                                        sendOTP(_controllers[1].text);
                                      }
                                    },
                                    child: Text(
                                      'Register',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.red),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: BorderSide(
                                              color: Colors.red,
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
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
                              'Already have an account? ',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  val = pi;
                                  registerTimer =
                                      Timer(Duration(milliseconds: 500), () {
                                    setState(() {
                                      switchScreen = false;
                                    });
                                  });
                                });
                              },
                              child: Text(
                                'Login Now',
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
                ),
                alignment: Alignment.bottomCenter,
              )
            : Login(),
      ),
    );
  }
}
