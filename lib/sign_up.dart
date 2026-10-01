import 'package:flutter/material.dart';
import 'package:flutter_aidly/account_created.dart';
import 'package:flutter_aidly/welcometoaidly.dart';

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
      home: WelcomeAccount(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFD4F1ED),
      // appBar: AppBar(
      //   backgroundColor: Color(0xFF34C1AD),
      //   title: Text(''),
      // ),
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top curved header
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF34C1AD),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(500),
                  bottomRight: Radius.circular(500),
                ),
              ),
              // child: Align(
              //   alignment: Alignment.topLeft,
              //   child: Padding(
              //     padding: const EdgeInsets.all(16.0),
              //     child: IconButton(
              //       icon: const Icon(Icons.arrow_back, color: Colors.black),
              //       onPressed: () {
              //         Navigator.pop(context);
              //       },
              //     ),
              //   ),
              // ),
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 10, top: 20),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),

            SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Text(
                    "Sign up",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Sign up as Admin",
                    style: TextStyle(fontSize: 25, color: Colors.black54),
                  ),
                ],
              ),
            ),

            SizedBox(height: 50),

            // Name field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Name",
                  border: UnderlineInputBorder(),
                ),
              ),
            ),

            SizedBox(height: 40),

            // Unique ID field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Unique I’D",
                  border: UnderlineInputBorder(),
                ),
              ),
            ),

            SizedBox(height: 40),

            // Password field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: UnderlineInputBorder(),
                ),
              ),
            ),

            SizedBox(height: 40),

            // Sign up button
            Center(
              child: Container(
                width: 200,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF40C7B8),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyCreatedPage(title: ''),
                      ),
                    );
                  },
                  child: Text("Sign up", style: TextStyle(fontSize: 18)),
                ),
              ),
            ),

            SizedBox(height: 40),

            // Remember me
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Checkbox(value: false, onChanged: (val) {}),
                  Text("Remember me"),
                ],
              ),
            ),

            SizedBox(height: 50),

        //already have account
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const Text("Already have an account? "),
                Text(
                  "Already have an account?",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                GestureDetector(
                  onTap: () {},


                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFD4F1ED),
                      // padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      "log in ",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),

                ),
              ],
            ),
                ],
              ),
            ),
    );

  }
}
