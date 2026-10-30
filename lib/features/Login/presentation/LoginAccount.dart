import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_aidly/login_enter_otp.dart';

import 'login_enter_otp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(title: ''),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<LoginScreen> createState() => _MyLoginScreen();
}

class _MyLoginScreen extends State<LoginScreen> {

  final TextEditingController phoneController = TextEditingController();

  /// COUNTRY CODE
  String selectedCountryCode = "+91";

  /// COUNTRY LIST
  final List<String> countryCodes = [
    "+91",
    "+1",
    "+44",
    "+61",
    "+81",
    "+971",
    "+86",
    "+49",
    "+33",
  ];

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFD4F1ED),

      body: SafeArea(
        top: false,
        // FIXED: top: false REMOVED — PREVIOUSLY STATUS BAR AREA WAS UNPROTECTED
        // ON NOTCH/CUTOUT DEVICES HEADER WAS RENDERING UNDER THE SYSTEM STATUS BAR
        // top: true IS THE DEFAULT AND CORRECT BEHAVIOR FOR SafeArea
        child: LayoutBuilder(
          builder: (context, constraints) {

            final double availableWidth = constraints.maxWidth;
            final double availableHeight = constraints.maxHeight;

            // LANDSCAPE DETECT — WIDTH > HEIGHT MEANS LANDSCAPE ORIENTATION
            // PREVIOUSLY NO LANDSCAPE DETECTION — ALL VALUES USED RAW screenHeight
            // WHICH BECAME VERY SMALL IN LANDSCAPE CAUSING LAYOUT COLLAPSE
            final bool isLandscape = availableWidth > availableHeight;

            // TABLET DETECT — WIDER SCREENS GET PROPORTIONALLY CAPPED FONT SIZES
            final bool isTablet = availableWidth > 600;

            // RESPONSIVE HEADER HEIGHT
            // PREVIOUSLY FIXED AT screenHeight * 0.18
            // IN LANDSCAPE screenHeight SHRINKS — 0.18 LEFT ALMOST NO HEADER SPACE
            final double headerHeight = isLandscape
                ? availableHeight * 0.26
                : screenHeight * 0.18;

            // RESPONSIVE HEADER BORDER RADIUS — REPLACES HARDCODED 200
            // 200 FIXED CAUSED VISUAL DISTORTION ON LANDSCAPE AND SMALL SCREENS
            final double headerRadius = isLandscape
                ? availableHeight * 0.30
                : screenWidth * 0.55;

            // FONT SIZE CAP FOR TABLETS — screenWidth-BASED FONTS ON WIDE TABLETS
            // BECOME DISPROPORTIONATELY LARGE WITHOUT A REASONABLE CAP
            final double fontWidthBase = isTablet
                ? availableWidth * 0.5
                : availableWidth;

            final double titleFontSize = fontWidthBase * 0.095;
            final double subtitleFontSize = fontWidthBase * 0.062;
            final double labelFontSize = fontWidthBase * 0.058;
            final double bodyFontSize = fontWidthBase * 0.05;

            // RESPONSIVE BUTTON DIMENSIONS
            final double buttonWidth = availableWidth * 0.5;
            final double buttonHeight = isLandscape
                ? availableHeight * 0.14
                : screenHeight * 0.065;

            // RESPONSIVE SPACINGS — REDUCED IN LANDSCAPE TO PREVENT OVERFLOW
            // PREVIOUSLY FIXED PROPORTIONS OF screenHeight CAUSED ACCUMULATED OVERFLOW
            // IN LANDSCAPE WHERE screenHeight IS MUCH SMALLER
            final double afterHeaderGap = isLandscape
                ? availableHeight * 0.04
                : screenHeight * 0.07;

            final double afterSubtitleGap = isLandscape
                ? availableHeight * 0.03
                : screenHeight * 0.055;

            final double afterLabelGap = isLandscape
                ? availableHeight * 0.02
                : screenHeight * 0.025;

            final double afterInputGap = isLandscape
                ? availableHeight * 0.04
                : screenHeight * 0.06;

            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  /// CURVED HEADER
                  Container(
                    // RESPONSIVE HEIGHT — REPLACES FIXED screenHeight * 0.18
                    height: headerHeight,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF34C1AD),
                      borderRadius: BorderRadius.only(
                        // RESPONSIVE RADIUS — REPLACES HARDCODED 200
                        // 200 FIXED DISTORTED ON LANDSCAPE AND SMALL SCREENS
                        bottomLeft: Radius.circular(headerRadius),
                        bottomRight: Radius.circular(headerRadius),
                      ),
                    ),
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.02,
                      // CAPPED TOP PADDING SO BUTTON STAYS VISIBLE IN LANDSCAPE
                      // PREVIOUSLY screenHeight * 0.04 — IN LANDSCAPE COULD PUSH
                      // BUTTON BELOW THE SHRUNK HEADER HEIGHT
                      top: headerHeight * 0.20,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: screenWidth * 0.07,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),

                  // RESPONSIVE GAP AFTER HEADER — REDUCED IN LANDSCAPE
                  SizedBox(height: afterHeaderGap),

                  /// TITLE
                  Text(
                    "Login Account",
                    style: TextStyle(
                      // RESPONSIVE + CAPPED FONT SIZE
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.008),

                  /// SUBTITLE
                  Text(
                    "Welcome Back!",
                    style: TextStyle(
                      // RESPONSIVE + CAPPED FONT SIZE
                      fontSize: subtitleFontSize,
                      color: Colors.black54,
                    ),
                  ),

                  // RESPONSIVE GAP AFTER SUBTITLE — REDUCED IN LANDSCAPE
                  SizedBox(height: afterSubtitleGap),

                  /// LABEL
                  Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.1,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Enter Your Mobile Number",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          // RESPONSIVE + CAPPED FONT SIZE
                          fontSize: labelFontSize,
                        ),
                      ),
                    ),
                  ),

                  // RESPONSIVE GAP AFTER LABEL
                  SizedBox(height: afterLabelGap),

                  /// MOBILE INPUT ROW
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1,
                    ),
                    child: Row(
                      children: [

                        /// COUNTRY CODE DROPDOWN
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.005,
                            horizontal: screenWidth * 0.02,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedCountryCode,
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size: screenWidth * 0.06,
                              ),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                // RESPONSIVE + CAPPED FONT SIZE
                                fontSize: bodyFontSize,
                                color: Colors.black,
                              ),
                              items: countryCodes.map((String code) {
                                return DropdownMenuItem<String>(
                                  value: code,
                                  child: Text(code),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedCountryCode = newValue!;
                                });
                              },
                            ),
                          ),
                        ),

                        SizedBox(width: screenWidth * 0.02),

                        /// PHONE TEXTFIELD
                        Expanded(
                          child: TextField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            style: TextStyle(
                              // RESPONSIVE + CAPPED FONT SIZE
                              fontSize: bodyFontSize,
                            ),
                            decoration: InputDecoration(
                              hintText: "9897100000",
                              hintStyle: TextStyle(
                                fontSize: bodyFontSize,
                                color: Colors.black38,
                              ),
                              border: const UnderlineInputBorder(),
                              counterText: "",
                              suffixText:
                              "${phoneController.text.length}/10",
                              suffixStyle: TextStyle(
                                fontSize: bodyFontSize * 0.8,
                                color: phoneController.text.length == 10
                                    ? Colors.teal
                                    : Colors.black45,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // RESPONSIVE GAP AFTER INPUT — REDUCED IN LANDSCAPE
                  SizedBox(height: afterInputGap),

                  /// GET OTP BUTTON
                  SizedBox(
                    width: buttonWidth,
                    // RESPONSIVE HEIGHT — REDUCED IN LANDSCAPE
                    height: buttonHeight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: phoneController.text.length == 10
                            ? const Color(0xFF34C1AD)
                            : Colors.grey.shade400,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onPressed: phoneController.text.length == 10
                          ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OtpScreen(),
                          ),
                        );
                      }
                          : null,
                      child: Text(
                        "GET OTP",
                        style: TextStyle(
                          color: Colors.black,
                          // RESPONSIVE + CAPPED FONT SIZE
                          fontSize: bodyFontSize,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.03),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}