import 'package:flutter/material.dart';
import 'package:flutter_aidly/passwordchange.dart';
import 'package:flutter_aidly/sendcode.dart';
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
      home: MySendCode(title: ''),
    );
  }
}

class MyNewpasswordPage extends StatefulWidget {
  const MyNewpasswordPage({super.key, required this.title});



  final String title;

  @override
  State<MyNewpasswordPage> createState() => _MyNewpasswordState();
}

class _MyNewpasswordState extends State<MyNewpasswordPage> {
  bool rememberME = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Color(0xFFD4F1ED),
    // appBar: AppBar(
    //   backgroundColor: Color(0xFF34C1AD),
    // title: Text(''),
    // ),
    body:SingleChildScrollView(
        // padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top curve (optional design element)
            Container(
              height: 140,
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
              "Set New Password",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            // Subtitle
            const Text(
              "Create an unique password.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),

            // Illustration Image
            SizedBox(
              height: 300,
              child: Image.asset(
                "assets/images/set_new_password.png",
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 30),

            // New Password
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 30),
              child: Text(
                "New Password",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ),
            ),
            const SizedBox(height: 5),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child:TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Enter input",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              ),
            ),
          ),
            const SizedBox(height: 10),

            // Confirm Password
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 30),
              child: Text(
                "Confirm Password",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ),
            ),
            const SizedBox(height: 5),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Enter password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
            ),
      ),
            const SizedBox(height: 20),

            // Reset password button
            SizedBox(
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF34C1AD),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyChangepasswordPage(title: '',),
                     )
                  );// Reset password action
                },
                child: const Text(
                  "Reset password",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Skip text with arrow
            GestureDetector(
              onTap: () {
                Navigator.pop(context);// Skip action
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back, size: 20, color: Colors.black54),
                  SizedBox(width: 6),
                  Text(
                    "skip?",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
    ),
    );
  }
}