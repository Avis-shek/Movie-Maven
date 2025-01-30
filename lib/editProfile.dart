// ignore_for_file: prefer_const_constructors, must_be_immutable, use_build_context_synchronously
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_maveen/widgets/cusNavBar.dart';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _editProfileState();
}

class _editProfileState extends State<EditProfilePage> {
  static String routeName = "/profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Edit Profile"),
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
                        child: GestureDetector(
                          onTap: () {},
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: BorderSide(color: Colors.red),
                              ),
                              primary: Colors.white,
                              backgroundColor: Colors.black,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return FractionallySizedBox(
                                    widthFactor: 0.8,
                                    child: AlertDialog(
                                      title: Text('Choose From'),
                                      content: SingleChildScrollView(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                final pickedFile =
                                                    await ImagePicker()
                                                        .getImage(
                                                            source: ImageSource
                                                                .camera);
                                                if (pickedFile != null) {
                                                  // TODO: Implement logic to store the image in the database
                                                  // You can access the image file using pickedFile.path
                                                  // await moveImageToFileSystem(pickedFile.path);
                                                }
                                                Navigator.pop(context);
                                              },
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/Camera.jpg',
                                                    width: 65,
                                                    height: 65,
                                                  ),
                                                  Text('Camera'),
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                // TODO: Implement logic for selecting a photo from the gallery

                                                final pickedFile =
                                                    await ImagePicker()
                                                        .getImage(
                                                            source: ImageSource
                                                                .gallery);
                                                if (pickedFile != null) {
                                                  // TODO: Implement logic to store the image in the database
                                                  // You can access the image file using pickedFile.path
                                                }
                                                // TODO: Implement logic for taking a photo using the camera

                                                Navigator.pop(context);
                                              },
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/gallery.png',
                                                    width: 65,
                                                    height: 65,
                                                  ),
                                                  Text('Gallery'),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
            SizedBox(height: 20),
            TextField(
              style: TextStyle(color: Colors.white),
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                prefixIcon: Icon(Icons.person, color: Colors.red),
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
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              style: TextStyle(color: Colors.white),
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                prefixIcon: Icon(Icons.email, color: Colors.red),
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
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              style: TextStyle(color: Colors.white),
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                prefixIcon: Icon(Icons.phone, color: Colors.red),
                labelText: 'Number',
                // ignore: prefer_const_constructors
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                alignLabelWithHint: true,
                hintText: 'Enter your number',
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
              keyboardType: TextInputType.phone,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              style: TextStyle(color: Colors.white),
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                prefixIcon: Icon(Icons.location_city, color: Colors.red),
                labelText: 'Address',
                // ignore: prefer_const_constructors
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                alignLabelWithHint: true,
                hintText: 'Enter your address here',
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
              keyboardType: TextInputType.streetAddress,
            ),
            SizedBox(height: 50),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Update',
                  style: TextStyle(fontSize: 19),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(
                          color: Colors.red,
                        )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: CustomNavBar(index: 0,),
    );
  }
}

