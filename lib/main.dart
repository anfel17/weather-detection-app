import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _image;
  final picker = ImagePicker();

  Future<void> getImageGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No image picked");
      }
    });
  }

  Future<void> getImageCamera() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No image picked");
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              "assets/sun_1400310.png",
              // Replace with the path to your icon image
              width: 35, // Adjust the width of the icon as needed
              height: 35, // Adjust the height of the icon as needed
            ),
            const SizedBox(width: 8),
            // Adjust the spacing between the icon and the title text
            const Text(
              "Weather Detection",
              style: TextStyle(
                fontSize: 24, // Adjust the font size as needed
                fontWeight: FontWeight.bold,
                color: Colors.black,
                // Adjust the color as needed
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        // Set the background color of the app bar to transparent
        elevation: 0,
        // Remove the shadow below the app bar
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF0684F5),
                Color(0xFFC9D9EC), // Light blue
              ],
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFFC9D9EC),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 90,),
            InkWell(
              onTap: getImageGallery, // Function to pick image from gallery
              child: Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: _image != null
                    ? Image.file(_image!, fit: BoxFit.cover)
                    : Center(
                  child: Icon(Icons.add_photo_alternate_outlined, size: 75),
                ),
              ),
            ),
            SizedBox(height: 35),
            Center( // Center the row containing buttons
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // Center the buttons horizontally
                children: [
                  InkWell(
                    onTap: getImageGallery,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Color(0xFF7EB4E1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text("Upload",
                          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold,)),
                    ),
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: getImageCamera, // Function to pick image from camera
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 8, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Color(0xFF7EB4E1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text("Take Photo",
                          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold,)),
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
}


