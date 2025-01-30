// ignore_for_file: prefer_const_constructors
// import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class forgetPassword extends StatefulWidget {
  const forgetPassword({super.key});

  @override
  State<forgetPassword> createState() => _editProfileState();
}

class _editProfileState extends State<forgetPassword> {
  final _textController = TextEditingController(text: 'Default Value');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("Forget password"),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: SafeArea(
            child: Container(
                child: Form(
              //key: formkey
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SizedBox(
                        height: 120,
                        width: 120,
                        child: Stack(
                          fit: StackFit.expand,
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.red,
                              backgroundImage:
                                  AssetImage("assets/images/forget.png"),
                            ),
                            Positioned(
                              right: -16,
                              bottom: 0,
                              child: SizedBox(
                                height: 46,
                                width: 46,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        side: BorderSide(color: Colors.red),
                                      ),
                                      primary: Colors.white,
                                      backgroundColor:
                                          Colors.black //Color(0xFFF5F6F9),
                                      ),
                                  onPressed: () async {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SafeArea(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ListTile(
                                                leading:
                                                    Icon(Icons.photo_library),
                                                title:
                                                    Text('Choose from Gallery'),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  // _pickImage(ImageSource.gallery);
                                                },
                                              ),
                                              ListTile(
                                                leading: Icon(Icons.camera_alt),
                                                title: Text('Take a Photo'),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  // _pickImage(ImageSource.camera);
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Icon(
                                    Icons.email,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    SizedBox(height: 15),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Text(
                        "Enter the email address associated with vour accoun and we'll send vou a link to reset vour password",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        prefixIcon:
                            Icon(Icons.email_outlined, color: Colors.red),
                        labelText: 'Your Email',
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        alignLabelWithHint: true,
                        hintText: 'Your Email address',
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
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {
                              // if (_formKey.currentState!.validate()) {
                              //   // Perform password change logic here
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     const SnackBar(
                              //         content: Text('Password changed successfully')),
                              //   );
                              // }
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                      color: Colors.red,
                                    )),
                              ),
                            ),
                            child: const Text('Forgot Password'),
                          ),
                        )),
                      ],
                    )
                  ]),
            )),
          ),
        ));
  }
}
