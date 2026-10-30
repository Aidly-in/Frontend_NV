import 'package:flutter/material.dart';
import 'package:flutter_aidly/account_created.dart';

import '../../Authentication/presentation/account_created.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      ),
      home: MyCreatedPage(title: ''),
    );
  }
}

class MylogincompletePage extends StatefulWidget {
  const MylogincompletePage({super.key, required this.title});



  final String title;

  @override
  State<MylogincompletePage> createState() => _MylogincompleteState();
}

class _MylogincompleteState extends State<MylogincompletePage> {
  bool rememberME = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFD4F1ED),

      body:SingleChildScrollView(
          // padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top curve
              Container(
                height: 150,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF34C1AD),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(500),
                    bottomRight: Radius.circular(500),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Title
              const Text(
                "Login Completed!",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),

              // Subtitle
              const Text(
                "Welcome to Aidly.",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),

              // Illustration Image
              SizedBox(
                  height: 400,
                  child: Image.asset(
                    "assets/images/Login_complete.png",
                    height: 800,
                    width: 600,
                  )
              ),
              const SizedBox(height: 25),

              // Info text
              const Text(
                "Thank you! Go To Profile",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),

              // Success Text
              const Text(
                "Successfully!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 30),

              // Continue Button
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () {
                    // Navigate to Profile/Home screen
                  },
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}