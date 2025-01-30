// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Reset Password'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        backgroundImage: AssetImage("assets/images/reset.png"),
                      ),
                      Positioned(
                        right: -16,
                        bottom: 0,
                        child: SizedBox(
                          height: 46,
                          width: 46,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 46),
              TextFormField(
                controller: _oldPasswordController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  prefixIcon: Icon(Icons.security, color: Colors.red),
                  labelText: 'Old Password',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  alignLabelWithHint: true,
                  hintText: 'Old Password',
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
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your old password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _newPasswordController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  prefixIcon: Icon(Icons.password, color: Colors.red),
                  labelText: 'New Password',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  alignLabelWithHint: true,
                  hintText: 'Enter email or username',
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
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a new password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _confirmPasswordController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  prefixIcon: Icon(Icons.password, color: Colors.red),
                  labelText: 'Confirm Password',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  alignLabelWithHint: true,
                  hintText: 'Confirm Password',
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
                    return 'Please confirm your new password';
                  }
                  if (value != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32.0),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Perform password change logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Password changed successfully')),
                      );
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(
                            color: Colors.red,
                          )),
                    ),
                  ),
                  child: const Text('Reset Password'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
