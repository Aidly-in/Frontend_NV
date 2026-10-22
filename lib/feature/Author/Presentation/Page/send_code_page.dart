import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_aidly/features/auth/presentation/pages/account_created_page.dart';

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
      home: MySendCode(title: ''),
    );
  }
}

class MySendCode extends StatefulWidget {
  const MySendCode({super.key, required this.title});
  final String title;

  @override
  State<MySendCode> createState() => _MySendCodeState();
}

class _MySendCodeState extends State<MySendCode> {
  final otpController1 = TextEditingController();
  final otpController2 = TextEditingController();
  final otpController3 = TextEditingController();
  final otpController4 = TextEditingController();

  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  late final List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = [
      otpController1,
      otpController2,
      otpController3,
      otpController4,
    ];

    for (int i = 0; i < _focusNodes.length; i++) {
      final int index = i;
      _focusNodes[index].onKeyEvent = (node, event) {
        if (event is KeyDownEvent || event is KeyRepeatEvent) {
          if (event.logicalKey == LogicalKeyboardKey.backspace) {
            if (_controllers[index].text.isEmpty && index > 0) {
              _controllers[index - 1].clear();
              _focusNodes[index - 1].requestFocus();
              setState(() {});
              return KeyEventResult.handled;
            }
          }
        }
        return KeyEventResult.ignored;
      };
    }
  }

  @override
  void dispose() {
    otpController1.dispose();
    otpController2.dispose();
    otpController3.dispose();
    otpController4.dispose();

    for (int i = 0; i < _focusNodes.length; i++) {
      _focusNodes[i].onKeyEvent = null;
    }

    for (var node in _focusNodes) {
      node.dispose();
    }
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double availableHeight = constraints.maxHeight;
            final double availableWidth = constraints.maxWidth;
            final bool isLandscape = availableWidth > availableHeight;
            final bool isSmallScreen = !isLandscape && availableHeight < 700;

            final double headerHeight = isLandscape
                ? availableHeight * 0.20
                : (isSmallScreen
                ? screenHeight * 0.13
                : screenHeight * 0.18);

            final double headerRadius = isLandscape
                ? availableHeight * 0.28
                : availableWidth * 0.55;

            final double imageHeight = isLandscape
                ? availableHeight * 0.35
                : (isSmallScreen
                ? screenHeight * 0.22
                : screenHeight * 0.28);

            final double titleFontSize = isLandscape
                ? availableHeight * 0.09
                : (isSmallScreen
                ? screenWidth * 0.07
                : screenWidth * 0.09);

            final double subtitleFontSize = isLandscape
                ? availableHeight * 0.055
                : (isSmallScreen
                ? screenWidth * 0.045
                : screenWidth * 0.06);

            final double bodyFontSize = isLandscape
                ? availableHeight * 0.06
                : (isSmallScreen
                ? screenWidth * 0.04
                : screenWidth * 0.05);

            final double otpBoxSize = isLandscape
                ? availableHeight * 0.15
                : (isSmallScreen
                ? screenWidth * 0.11
                : screenWidth * 0.13);

            final double buttonWidth = availableWidth * 0.5;
            final double buttonHeight = isLandscape
                ? availableHeight * 0.16
                : (isSmallScreen
                ? screenHeight * 0.055
                : screenHeight * 0.065);

            final double sectionSpacing = isLandscape
                ? availableHeight * 0.03
                : screenHeight * 0.02;

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
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  Text(
                    "Verification",
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.008),
                  Text(
                    "Enter the code to continue.",
                    style: TextStyle(
                      fontSize: subtitleFontSize,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: sectionSpacing),
                  SizedBox(
                    height: imageHeight,
                    child: Image.asset(
                      "assets/images/send_code.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: sectionSpacing),
                  Text(
                    "We sent a verification",
                    style: TextStyle(
                      fontSize: bodyFontSize,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "code on your phone",
                    style: TextStyle(
                      fontSize: bodyFontSize,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.025),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.08,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _otpBox(
                          controller: otpController1,
                          size: otpBoxSize,
                          currentFocus: _focusNodes[0],
                          nextFocus: _focusNodes[1],
                          previousFocus: null,
                        ),
                        _otpBox(
                          controller: otpController2,
                          size: otpBoxSize,
                          currentFocus: _focusNodes[1],
                          nextFocus: _focusNodes[2],
                          previousFocus: _focusNodes[0],
                        ),
                        _otpBox(
                          controller: otpController3,
                          size: otpBoxSize,
                          currentFocus: _focusNodes[2],
                          nextFocus: _focusNodes[3],
                          previousFocus: _focusNodes[1],
                        ),
                        _otpBox(
                          controller: otpController4,
                          size: otpBoxSize,
                          currentFocus: _focusNodes[3],
                          nextFocus: null,
                          previousFocus: _focusNodes[2],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.025),
                  SizedBox(
                    width: buttonWidth,
                    height: buttonHeight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyCreatedPage(title: ''),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF34C1AD),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: bodyFontSize,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.018),
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        "Didn't receive the code?",
                        style: TextStyle(
                          fontSize: bodyFontSize * 0.9,
                          color: Colors.black54,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Send again",
                          style: TextStyle(
                            fontSize: bodyFontSize * 0.9,
                            color: const Color(0xFF26A69A),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_back, size: screenWidth * 0.045),
                        SizedBox(width: screenWidth * 0.015),
                        Text(
                          "Back to Sign Up ?",
                          style: TextStyle(
                            fontSize: screenWidth * 0.038,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
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

  Widget _otpBox({
    required TextEditingController controller,
    required double size,
    required FocusNode currentFocus,
    required FocusNode? nextFocus,
    required FocusNode? previousFocus,
  }) {
    return SizedBox(
      width: size,
      height: size * 1.2,
      child: TextField(
        controller: controller,
        focusNode: currentFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: Colors.teal.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: size * 0.25,
          ),
        ),
        style: TextStyle(
          fontSize: size * 0.45,
          fontWeight: FontWeight.bold,
        ),
        onChanged: (value) {
          if (value.length == 1) {
            if (nextFocus != null) {
              FocusScope.of(context).requestFocus(nextFocus);
            } else {
              FocusScope.of(context).unfocus();
            }
          } else if (value.isEmpty && previousFocus != null) {
            FocusScope.of(context).requestFocus(previousFocus);
          }
        },
      ),
    );
  }
}
