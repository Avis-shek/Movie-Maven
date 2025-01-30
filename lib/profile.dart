// ignore_for_file: prefer_const_constructors, must_be_immutable, unused_import
import 'package:flutter/material.dart';
import 'package:movie_maveen/widgets/cusNavBar.dart';
import 'package:file_picker/file_picker.dart';

import 'MyDatabse/connection.dart';

class ProfilePage extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            SizedBox(
              height: 120,
              width: 120,
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/EDV.jpg"),
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
                            backgroundColor: Colors.black //Color(0xFFF5F6F9),
                            ),
                        onPressed: () {},
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            ProfileMenu(
              text: "My Account",
              icon: Icon(Icons.person, color: Colors.red, size: 30),
              press: () => {Navigator.pushNamed(context, '/editProfile')},
            ),
            ProfileMenu(
              text: "Settings",
              icon: Icon(Icons.settings, color: Colors.red, size: 30),
              press: () {},
            ),
            ProfileMenu(
              text: "Payments",
              icon: Icon(Icons.payment, color: Colors.red, size: 30),
              press: () {
                Navigator.pushNamed(context, '/Payment');
              },
            ),
            ProfileMenu(
              text: "Subscriptions",
              icon: Icon(Icons.subscriptions, color: Colors.red, size: 30),
              press: () {
                Navigator.pushNamed(context, '/Subscription');
              },
            ),
            ProfileMenu(
              text: "Reset Password",
              icon: Icon(Icons.password, color: Colors.red, size: 30),
              press: () {
                Navigator.pushNamed(context, '/ChangePasswordPage');
              },
            ),
            ProfileMenu(
              text: "Log Out",
              icon: Icon(Icons.logout_sharp, color: Colors.red, size: 30),
              press: () {
                userId = -1;
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      // bottomNavigationBar: CustomNavBar(index: 0,),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  Icon icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextButton(
        style: TextButton.styleFrom(
          side: BorderSide(
            // color: Colors.redAccent,
            width: 1,
          ),
          //primary: kPrimaryColor,
          padding: EdgeInsets.all(15),

          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Color(0xFF292B37),
        ),
        onPressed: press,
        child: Row(
          children: [
            icon,
            SizedBox(width: 20),
            Expanded(
                child: Text(
              text,
              style: TextStyle(color: Colors.white),
            )),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
