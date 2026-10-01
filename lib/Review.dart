import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// MAIN APPLICATION
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HearAboutUsScreen(),
    );
  }
}

/// MAIN SCREEN
class HearAboutUsScreen extends StatefulWidget {
  const HearAboutUsScreen({super.key});

  @override
  State<HearAboutUsScreen> createState() => _HearAboutUsScreenState();
}

class _HearAboutUsScreenState extends State<HearAboutUsScreen> {
  String selectedOption = "";

  /// OPTIONS LIST
  final List<String> options = [
    "In office",
    "Social Media",
    "News Story",
    "Family/Friends",
    "Other"
  ];

  @override
  Widget build(BuildContext context) {
    /// FIX: USE OrientationBuilder TO DETECT LANDSCAPE VS PORTRAIT
    /// AND ADAPT FIXED SPACERS AND LOGO SIZE ACCORDINGLY.
    /// WITHOUT THIS, THE FIXED 90px TOP SPACER + 200px LOGO IN LANDSCAPE
    /// (~360px total height) CONSUMES MOST OF THE SCREEN BEFORE ANY OPTIONS RENDER.
    return OrientationBuilder(
      builder: (context, orientation) {
        final isLandscape = orientation == Orientation.landscape;

        return Scaffold(
          backgroundColor: const Color(0xFFE8FFF6),
          body: SafeArea(
            child: SingleChildScrollView(
              /// FIX: KEYBOARD DISMISS ON DRAG FOR KEYBOARD-SAFE LAYOUT
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Center(
                child: ConstrainedBox(
                  /// FIX: TABLET AND WIDE-SCREEN CONSTRAINT — PREVENTS OPTION
                  /// BUTTONS FROM STRETCHING UNCOMFORTABLY WIDE ON TABLETS,
                  /// FOLDABLES, AND DESKTOP EMULATORS
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [

                        /// FIX: REDUCED TOP SPACER IN LANDSCAPE FROM 90 TO 20
                        /// THE FIXED 90px SPACER IN LANDSCAPE (~360px height) CONSUMED
                        /// 25% OF SCREEN HEIGHT BEFORE ANY CONTENT EVEN STARTED
                        SizedBox(height: isLandscape ? 20 : 90),

                        /// LOGO IMAGE
                        /// FIX: REDUCED LOGO SIZE IN LANDSCAPE FROM 200 TO 100
                        /// THE FIXED 200px LOGO IN LANDSCAPE IS TOO TALL AND
                        /// LEAVES LITTLE ROOM FOR THE OPTIONS AND BUTTON BELOW
                        Container(
                          height: isLandscape ? 100 : 200,
                          width: isLandscape ? 100 : 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset(
                            "assets/images/logo.png",
                            fit: BoxFit.contain,
                          ),
                        ),

                        /// FIX: REDUCED SPACING AFTER LOGO IN LANDSCAPE
                        SizedBox(height: isLandscape ? 16 : 30),

                        /// TITLE
                        const Text(
                          "How did you hear about us?",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        /// FIX: REDUCED SPACING AFTER TITLE IN LANDSCAPE
                        SizedBox(height: isLandscape ? 12 : 30),

                        /// OPTION BUTTONS
                        ...options.map((option) => _optionButton(option)).toList(),

                        /// FIX: REDUCED SPACING BEFORE CONTINUE BUTTON IN LANDSCAPE
                        SizedBox(height: isLandscape ? 20 : 40),

                        /// CONTINUE BUTTON
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              print("Selected option: $selectedOption");
                            },
                            child: const Text(
                              "Continue",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// OPTION BUTTON WIDGET
  Widget _optionButton(String text) {
    bool isSelected = selectedOption == text;

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {
          setState(() {
            selectedOption = text;
          });
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? Colors.teal : Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.teal),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 5,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}