import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_aidly/Home.dart';

import '../../Home/presentation/Home.dart';

void main() {
  runApp(const MyApp());
}

/// MAIN APP
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OTP Verification',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.teal,
      ),
      home: const OtpScreen(),
    );
  }
}

/// OTP SCREEN
class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  /// TIMER
  int remainingSeconds = 60;
  bool canResendOtp = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    controllers = List.generate(4, (index) => TextEditingController());
    focusNodes = List.generate(4, (index) => FocusNode());

    // ATTACH KEY EVENT LISTENERS TO EACH FOCUS NODE
    // THIS IS REQUIRED TO DETECT BACKSPACE ON AN ALREADY-EMPTY FIELD
    // onChanged DOES NOT FIRE WHEN THE FIELD IS ALREADY EMPTY AND BACKSPACE IS PRESSED
    // FocusNode onKeyEvent INTERCEPTS THE RAW KEY EVENT BEFORE THE TEXTFIELD HANDLES IT
    for (int i = 0; i < focusNodes.length; i++) {
      final int index = i;
      focusNodes[index].onKeyEvent = (node, event) {

        // ONLY REACT ON KEY-DOWN OR KEY-REPEAT EVENTS, NOT KEY-UP
        // THIS PREVENTS DOUBLE FIRING ON SOME ANDROID DEVICES
        if (event is KeyDownEvent || event is KeyRepeatEvent) {

          // CHECK IF THE KEY PRESSED IS BACKSPACE
          if (event.logicalKey == LogicalKeyboardKey.backspace) {

            // IF CURRENT FIELD IS EMPTY AND WE ARE NOT ON THE FIRST FIELD
            // MOVE FOCUS BACK TO THE PREVIOUS FIELD AND CLEAR IT
            if (controllers[index].text.isEmpty && index > 0) {

              // CLEAR THE PREVIOUS FIELD SO USER CAN RE-ENTER THE DIGIT
              controllers[index - 1].clear();

              // MOVE FOCUS TO PREVIOUS FIELD
              focusNodes[index - 1].requestFocus();

              // TRIGGER REBUILD SO _isOtpComplete UPDATES CORRECTLY
              setState(() {});

              // RETURN HANDLED SO FLUTTER DOES NOT PROCESS THIS EVENT AGAIN
              return KeyEventResult.handled;
            }
          }
        }

        // ALL OTHER KEY EVENTS — LET FLUTTER HANDLE THEM NORMALLY
        return KeyEventResult.ignored;
      };
    }

    startTimer();
  }

  /// START TIMER
  void startTimer() {
    remainingSeconds = 60;
    canResendOtp = false;
    timer?.cancel();
    timer = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        if (remainingSeconds > 0) {
          setState(() {
            remainingSeconds--;
          });
        } else {
          setState(() {
            canResendOtp = true;
          });
          timer.cancel();
        }
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();

    // CLEAR KEY EVENT LISTENERS BEFORE DISPOSING TO AVOID MEMORY LEAKS
    for (int i = 0; i < focusNodes.length; i++) {
      focusNodes[i].onKeyEvent = null;
    }

    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  /// OTP FIELD CONTROL — FORWARD NAVIGATION PRESERVED, BACKWARD NOW HANDLED
  /// VIA focusNode.onKeyEvent ABOVE FOR RELIABLE CROSS-PLATFORM BEHAVIOR
  void _onOtpFieldChanged(String value, int index) {
    if (value.length == 1) {

      // MOVE FORWARD TO NEXT FIELD WHEN A DIGIT IS ENTERED
      if (index < 3) {
        focusNodes[index + 1].requestFocus();
      } else {
        // LAST FIELD — DISMISS KEYBOARD
        focusNodes[index].unfocus();
      }

    } else if (value.isEmpty && index > 0) {
      // THIS HANDLES THE CASE WHERE onChanged DOES FIRE ON EMPTY
      // KEPT AS FALLBACK FOR DEVICES WHERE onKeyEvent MAY NOT TRIGGER
      focusNodes[index - 1].requestFocus();
    }

    setState(() {});
  }

  /// OTP COMPLETE CHECK
  bool get _isOtpComplete =>
      controllers.every((c) => c.text.length == 1);

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFD4F1ED),

      body: SafeArea(
        top: false,
        // LAYOUT BUILDER ADDED TO DETECT REAL AVAILABLE SPACE
        // ENABLES LANDSCAPE AND SMALL SCREEN ADAPTATION
        child: LayoutBuilder(
          builder: (context, constraints) {

            final availableHeight = constraints.maxHeight;
            final availableWidth = constraints.maxWidth;

            // DETECT LANDSCAPE TO APPLY REDUCED SPACINGS AND SIZES
            final bool isLandscape = availableWidth > availableHeight;

            // RESPONSIVE HEADER HEIGHT — REDUCED IN LANDSCAPE TO PREVENT OVERFLOW
            final double headerHeight = isLandscape
                ? availableHeight * 0.22
                : screenHeight * 0.18;

            // RESPONSIVE HEADER BORDER RADIUS — SCALES WITH WIDTH NOT HARDCODED 200
            // HARDCODED 200 CAUSED VISUAL DISTORTION ON SMALL AND LANDSCAPE SCREENS
            final double headerRadius = isLandscape
                ? availableHeight * 0.30
                : availableWidth * 0.55;

            // RESPONSIVE TITLE FONT
            final double titleFontSize = isLandscape
                ? availableHeight * 0.09
                : screenWidth * 0.085;

            // RESPONSIVE SUBTITLE FONT
            final double subtitleFontSize = isLandscape
                ? availableHeight * 0.055
                : screenWidth * 0.042;

            // RESPONSIVE BODY FONT
            final double bodyFontSize = isLandscape
                ? availableHeight * 0.06
                : screenWidth * 0.05;

            // RESPONSIVE OTP BOX WIDTH
            final double otpBoxWidth = isLandscape
                ? availableHeight * 0.14
                : screenWidth * 0.13;

            // RESPONSIVE OTP BOX HEIGHT — PREVIOUSLY FIXED AT screenHeight * 0.08
            // WHICH WAS TOO TALL IN LANDSCAPE AND CAUSED ROW OVERFLOW
            final double otpBoxHeight = isLandscape
                ? availableHeight * 0.18
                : screenHeight * 0.08;

            // RESPONSIVE BUTTON WIDTH AND HEIGHT
            final double buttonWidth = availableWidth * 0.5;
            final double buttonHeight = isLandscape
                ? availableHeight * 0.16
                : screenHeight * 0.065;

            // RESPONSIVE SPACING AFTER HEADER — PREVIOUSLY FIXED AT screenHeight * 0.12
            // THIS LARGE GAP CAUSED CONTENT TO OVERFLOW IN LANDSCAPE MODE
            final double afterHeaderSpacing = isLandscape
                ? availableHeight * 0.04
                : screenHeight * 0.12;

            // RESPONSIVE GENERAL SPACING BETWEEN ELEMENTS
            final double sectionSpacing = isLandscape
                ? availableHeight * 0.03
                : screenHeight * 0.055;

            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  /// TOP HEADER
                  Container(
                    width: double.infinity,
                    height: headerHeight,
                    decoration: BoxDecoration(
                      color: const Color(0xFF34C1AD),
                      borderRadius: BorderRadius.only(
                        // RESPONSIVE RADIUS REPLACES HARDCODED 200
                        bottomLeft: Radius.circular(headerRadius),
                        bottomRight: Radius.circular(headerRadius),
                      ),
                    ),
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.02,
                      top: screenHeight * 0.04,
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

                  // RESPONSIVE SPACING AFTER HEADER — REPLACES FIXED screenHeight * 0.12
                  // WHICH CAUSED OVERFLOW IN LANDSCAPE BY PUSHING CONTENT TOO FAR DOWN
                  SizedBox(height: afterHeaderSpacing),

                  /// TITLE
                  Text(
                    'Enter your OTP',
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.01),

                  /// SUBTITLE
                  Text(
                    "We've sent to +91-5400000000",
                    style: TextStyle(
                      fontSize: subtitleFontSize,
                      color: Colors.black,
                    ),
                  ),

                  // RESPONSIVE SPACING — REPLACES FIXED screenHeight * 0.055
                  SizedBox(height: sectionSpacing),

                  /// OTP BOXES
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        4,
                            (index) => SizedBox(
                          width: otpBoxWidth,
                          // RESPONSIVE OTP BOX HEIGHT USED HERE
                          height: otpBoxHeight,
                          child: TextField(
                            controller: controllers[index],
                            focusNode: focusNodes[index],
                            onChanged: (value) {
                              _onOtpFieldChanged(value, index);
                            },
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,
                            maxLength: 1,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: const Color(0xFF4DB8A8)
                                  .withOpacity(0.3),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.zero,
                            ),
                            style: TextStyle(
                              fontSize: otpBoxWidth * 0.45,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // RESPONSIVE SPACING
                  SizedBox(height: sectionSpacing),

                  /// TIMER + RESEND OTP
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      /// TIMER
                      Text(
                        "00:${remainingSeconds.toString().padLeft(2, '0')}",
                        style: TextStyle(
                          fontSize: bodyFontSize,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),

                      SizedBox(width: screenWidth * 0.04),

                      /// RESEND OTP
                      GestureDetector(
                        onTap: canResendOtp
                            ? () {
                          /// CLEAR OTP
                          for (var c in controllers) {
                            c.clear();
                          }
                          focusNodes[0].requestFocus();
                          setState(() {});
                          startTimer();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'OTP Resent',
                                style: TextStyle(
                                  fontSize: bodyFontSize * 0.85,
                                ),
                              ),
                            ),
                          );
                        }
                            : null,
                        child: Text(
                          'Resend OTP',
                          style: TextStyle(
                            fontSize: bodyFontSize,
                            color: canResendOtp ? Colors.black : Colors.grey,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  /// CONTINUE BUTTON
                  SizedBox(
                    width: buttonWidth,
                    height: buttonHeight,
                    child: ElevatedButton(
                      onPressed: _isOtpComplete
                          ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const MergedHomePage(),
                          ),
                        );
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isOtpComplete
                            ? const Color(0xFF34C1AD)
                            : Colors.grey.shade400,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text(
                        "continue",
                        style: TextStyle(
                          fontSize: bodyFontSize,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.04),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}