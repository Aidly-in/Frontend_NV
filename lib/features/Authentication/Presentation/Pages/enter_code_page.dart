import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_aidly/features/home/presentation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

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

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  int remainingSeconds = 60;
  bool canResendOtp = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    controllers = List.generate(4, (index) => TextEditingController());
    focusNodes = List.generate(4, (index) => FocusNode());

    for (int i = 0; i < focusNodes.length; i++) {
      final int index = i;
      focusNodes[index].onKeyEvent = (node, event) {
        if (event is KeyDownEvent || event is KeyRepeatEvent) {
          if (event.logicalKey == LogicalKeyboardKey.backspace) {
            if (controllers[index].text.isEmpty && index > 0) {
              controllers[index - 1].clear();
              focusNodes[index - 1].requestFocus();
              setState(() {});
              return KeyEventResult.handled;
            }
          }
        }
        return KeyEventResult.ignored;
      };
    }

    startTimer();
  }

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

  void _onOtpFieldChanged(String value, int index) {
    if (value.length == 1) {
      if (index < 3) {
        focusNodes[index + 1].requestFocus();
      } else {
        focusNodes[index].unfocus();
      }
    } else if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }

    setState(() {});
  }

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
        child: LayoutBuilder(
          builder: (context, constraints) {
            final availableHeight = constraints.maxHeight;
            final availableWidth = constraints.maxWidth;
            final bool isLandscape = availableWidth > availableHeight;

            final double headerHeight = isLandscape
                ? availableHeight * 0.22
                : screenHeight * 0.18;

            final double headerRadius = isLandscape
                ? availableHeight * 0.30
                : availableWidth * 0.55;

            final double titleFontSize = isLandscape
                ? availableHeight * 0.09
                : screenWidth * 0.085;

            final double subtitleFontSize = isLandscape
                ? availableHeight * 0.055
                : screenWidth * 0.042;

            final double bodyFontSize = isLandscape
                ? availableHeight * 0.06
                : screenWidth * 0.05;

            final double otpBoxWidth = isLandscape
                ? availableHeight * 0.14
                : screenWidth * 0.13;

            final double otpBoxHeight = isLandscape
                ? availableHeight * 0.18
                : screenHeight * 0.08;

            final double buttonWidth = availableWidth * 0.5;
            final double buttonHeight = isLandscape
                ? availableHeight * 0.16
                : screenHeight * 0.065;

            final double afterHeaderSpacing = isLandscape
                ? availableHeight * 0.04
                : screenHeight * 0.12;

            final double sectionSpacing = isLandscape
                ? availableHeight * 0.03
                : screenHeight * 0.055;

            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: headerHeight,
                    decoration: BoxDecoration(
                      color: const Color(0xFF34C1AD),
                      borderRadius: BorderRadius.only(
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
                  SizedBox(height: afterHeaderSpacing),
                  Text(
                    'Enter your OTP',
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    "We've sent to +91-5400000000",
                    style: TextStyle(
                      fontSize: subtitleFontSize,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: sectionSpacing),
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
                  SizedBox(height: sectionSpacing),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "00:${remainingSeconds.toString().padLeft(2, '0')}",
                        style: TextStyle(
                          fontSize: bodyFontSize,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.04),
                      GestureDetector(
                        onTap: canResendOtp
                            ? () {
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
