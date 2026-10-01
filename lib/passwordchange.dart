import 'package:flutter/material.dart';
import 'package:flutter_aidly/account_created.dart';
import 'package:flutter_aidly/setnewpassword.dart';
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
      home: MyNewpasswordPage(title: ''),
    );
  }
}

class MyChangepasswordPage extends StatefulWidget {
  const MyChangepasswordPage({super.key, required this.title});



  final String title;

  @override
  State<MyChangepasswordPage> createState() => _MyChangepasswordState();
}

class _MyChangepasswordState extends State<MyChangepasswordPage> {
  bool rememberME = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Color(0xFFD4F1ED),

    body: SingleChildScrollView(
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
                  bottomLeft: Radius.circular(200),
                  bottomRight: Radius.circular(200),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Title
            const Text(
              "Password changed!",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),

            // Subtitle
            const Text(
              "No hassle anymore.",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
                height: 400,
                child: Image.asset(
                  "assets/images/password_change.png",
                )
              // Image.asset(
              //   "assets/images/forgotpassword.svg",
              //   fit: BoxFit.contain,
              // ),
            ),

            const SizedBox(height: 25),

            // Info text
            const Text(
              "Your password has been reset",
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
                fontSize: 26,
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
                   Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyCreatedPage(title: ''),
                     )
                  );
                },
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
    ),
    );
  }
}