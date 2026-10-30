import 'package:flutter/material.dart';
import 'package:flutter_aidly/create_account.dart';
import 'package:flutter_aidly/aidly.dart';

import '../../Authentication/presentation/Aidly.dart';
import '../../Authentication/presentation/create_account.dart';


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
      theme: ThemeData(),
      home: AidlyPgae(title: ''),
    );
  }
}

class WelcomeAccount extends StatefulWidget {
  const WelcomeAccount({super.key, required this.title});
  final String title;

  @override
  State<WelcomeAccount> createState() => _MywellPageState();
}

class _MywellPageState extends State<WelcomeAccount> {
  @override
  Widget build(BuildContext context) {
    // Screen size detect karne ke liye
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive values calculate karo
    final topCurveHeight = screenHeight * 0.15; // Screen height ka 15%
    final horizontalPadding = screenWidth * 0.05; // Screen width ka 5%
    final verticalSpacing = screenHeight * 0.02; // Screen height ka 2%
    final buttonWidth = screenWidth * 0.6; // Screen width ka 60%

    return Scaffold(
      backgroundColor: Color(0xFFD4F1ED),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top curve - Responsive height
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF34C1AD),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(200), // Dynamic radius
                  bottomRight: Radius.circular(200),
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.03), // 8% of screen height

            // Welcome Text - Responsive font size
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Text(
                "Welcome to Aidly!",
                style: TextStyle(
                  fontSize: screenWidth * 0.10, // 8% of screen width
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: screenHeight * 0.01), // 6% of screen height

            // Subtitle - Responsive font size
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding * 2),
              child: Text(
                "More Than Just\nHealthcare",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.06, // 7% of screen width
                  color: Color(0xFF0D6F74),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.001),

            // GIF Below Welcome Text
            Center(
              child: Image.asset(
                'assets/images/QZokup9abG (1).gif', // <-- your gif file
                width: screenWidth * 0.9,
                height: screenHeight * 0.30,
                fit: BoxFit.contain,
              ),
            ),

            SizedBox(height: screenHeight * 0.025), // 10% of screen height

            // Sign Up Button (Rounded) - Responsive size
            SizedBox(
              width: buttonWidth,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF34C1AD),
                  shape: StadiumBorder(),
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.02, // 2% of screen height
                  ),
                ),
                onPressed: () {
                  print("Sign Up pressed");
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => MyHomePage(title: ''),
                  //   ),
                  // );
                },
                child: Text(
                  "SIGN UP",
                  style: TextStyle(
                    fontSize: screenWidth * 0.04, // 4% of screen width
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SizedBox(height: verticalSpacing * 2),

            // Admin Button - Responsive size
            SizedBox(
              width: buttonWidth,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00796B),
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.02, // 2% of screen height
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyAccountPage(title: ''),
                    ),
                  );
                },
                child: Text(
                  "ADMIN",
                  style: TextStyle(
                    fontSize: screenWidth * 0.04, // 4% of screen width
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SizedBox(height: verticalSpacing * 2),

            // User Button - Responsive size
            SizedBox(
              width: buttonWidth,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00796B),
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.02, // 2% of screen height
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  ),
                ),
                onPressed: () {
                  // print("User pressed");
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => MyAccountPage(title: '',),
                  //   ),
                  // );
                },
                child: Text(
                  "USER",
                  style: TextStyle(
                    fontSize: screenWidth * 0.04, // 4% of screen width
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Bottom spacing for small screens
            SizedBox(height: screenHeight * 0.05),
          ],
        ),
      ),
    );
  }
}

class MyHomePage {
}