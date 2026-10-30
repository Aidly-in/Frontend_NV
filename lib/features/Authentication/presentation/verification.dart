import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_aidly/account_created.dart';

import 'account_created.dart';

// FORGOT PASSWORD IMPORT REMOVE KIYA — AB IS PAGE KI ZAROORAT NAHI
// KYUNKI APP SEEDHA VERIFICATION PAGE PE OPEN HOGI

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

      // HOME SEEDHA MySendCode PE SET KIYA
      // PEHLE MyForgotPage THA JO FORGOT PASSWORD PAGE KHOL RAHA THA
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

  final List<FocusNode> _focusNodes =
  List.generate(4, (_) => FocusNode());

  // CONTROLLERS LIST BANAYA TAAKI INDEX SE ACCESS KARNA AASAN HO
  // YEH BACKSPACE NAVIGATION KE LIYE ZAROORAT HAI
  late final List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();

    // CONTROLLERS KO LIST ME RAKHA TAAKI INDEX-BASED ACCESS HO SAKE
    // BACKSPACE HANDLER ME HUM PICHLE FIELD KO CLEAR KARTE HAIN
    _controllers = [
      otpController1,
      otpController2,
      otpController3,
      otpController4,
    ];

    // FOCUS NODE KEY LISTENERS INITSTATE ME ATTACH KIYE
    // BUILD ME ATTACH KARNE SE HAR REBUILD PE DUPLICATE LISTENERS LAGTE HAIN
    // onKeyEvent BACKSPACE KO RAW LEVEL PE PAKADTA HAI JAB FIELD PEHLE SE EMPTY HO
    // onChanged TAB FIRE NAHI HOTA JAB FIELD ALREADY EMPTY HO — YEH FLUTTER KI LIMITATION HAI
    for (int i = 0; i < _focusNodes.length; i++) {
      final int index = i;
      _focusNodes[index].onKeyEvent = (node, event) {

        // SIRF KEY DOWN YA REPEAT PE REACT KARO — KEY UP PE NAHI
        // YAHI ANDROID AUR IOS DONO PE CONSISTENT BEHAVIOR DETA HAI
        if (event is KeyDownEvent || event is KeyRepeatEvent) {

          // CHECK KARO KI BACKSPACE PRESS HUA HAI
          if (event.logicalKey == LogicalKeyboardKey.backspace) {

            // AGAR CURRENT FIELD EMPTY HAI AUR YEH PEHLA FIELD NAHI HAI
            // TAB PICHLE FIELD PE FOCUS LE JAO AUR USSE CLEAR KARO
            if (_controllers[index].text.isEmpty && index > 0) {

              // PICHLA FIELD CLEAR KARO TAAKI USER DOBARA DIGIT ENTER KAR SAKE
              _controllers[index - 1].clear();

              // PICHLE FIELD PE FOCUS LE JAO
              _focusNodes[index - 1].requestFocus();

              // REBUILD TRIGGER KARO TAAKI UI STATE UPDATE HO
              setState(() {});

              // HANDLED RETURN KARO TAAKI FLUTTER IS EVENT KO DOBARA PROCESS NA KARE
              return KeyEventResult.handled;
            }
          }
        }

        // BAAKI SABHI KEY EVENTS FLUTTER KO NORMALLY HANDLE KARNE DO
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

    // KEY EVENT LISTENERS DISPOSE SE PEHLE CLEAR KARO — MEMORY LEAK BACHANE KE LIYE
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

      // SAFEAREA ADD KIYA — CONTENT NOTCH AUR STATUS BAR KE NEECHE NA JAYE
      // PEHLE SAFEAREA NAHI THA ISLIYE CONTENT SYSTEM UI KE NEECHE RENDER HO SAKTA THA
      body: SafeArea(
        top: false,
        // LAYOUT BUILDER ADD KIYA — REAL AVAILABLE SPACE DETECT KARNE KE LIYE
        // ISSE LANDSCAPE, TABLET, AUR SMALL SCREEN PE SIZING ADAPT HOTI HAI
        child: LayoutBuilder(
          builder: (context, constraints) {

            final double availableHeight = constraints.maxHeight;
            final double availableWidth = constraints.maxWidth;

            // LANDSCAPE DETECT KIYA — WIDTH > HEIGHT MATLAB LANDSCAPE MODE
            // PEHLE SIRF HEIGHT < 700 CHECK THA JO LANDSCAPE DETECT NAHI KARTA THA
            final bool isLandscape = availableWidth > availableHeight;

            // CHHOTI SCREEN CHECK — REDMI JAISE OLD MODELS KE LIYE
            // AB LANDSCAPE ME BHI CORRECTLY SMALL SCREEN BEHAVE KAREGA
            final bool isSmallScreen =
                !isLandscape && availableHeight < 700;

            // RESPONSIVE HEADER HEIGHT
            // LANDSCAPE ME BAHUT CHOTA RAKHA TAAKI CONTENT NEECHE FIT HO SAKE
            final double headerHeight = isLandscape
                ? availableHeight * 0.20
                : (isSmallScreen
                ? screenHeight * 0.13
                : screenHeight * 0.18);

            // RESPONSIVE HEADER BORDER RADIUS — HARDCODED 200 HATA DIYA
            // 200 FIXED HONE SE CHHOTI AUR LANDSCAPE SCREENS PE VISUAL DISTORTION AATA THA
            final double headerRadius = isLandscape
                ? availableHeight * 0.28
                : availableWidth * 0.55;

            // IMAGE HEIGHT — LANDSCAPE ME BAHUT KAM KIYA TAAKI SCROLL KAM HO
            final double imageHeight = isLandscape
                ? availableHeight * 0.35
                : (isSmallScreen
                ? screenHeight * 0.22
                : screenHeight * 0.28);

            // RESPONSIVE FONT SIZES
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

            // OTP BOX SIZE — LANDSCAPE ME AVAILABLEHEIGHT SE SCALE KIYA
            // PORTRAIT ME PEHLE JAISA HI RAHEGA
            final double otpBoxSize = isLandscape
                ? availableHeight * 0.15
                : (isSmallScreen
                ? screenWidth * 0.11
                : screenWidth * 0.13);

            // RESPONSIVE BUTTON DIMENSIONS
            final double buttonWidth = availableWidth * 0.5;
            final double buttonHeight = isLandscape
                ? availableHeight * 0.16
                : (isSmallScreen
                ? screenHeight * 0.055
                : screenHeight * 0.065);

            // RESPONSIVE SECTION SPACING — LANDSCAPE ME REDUCE KIYA
            final double sectionSpacing = isLandscape
                ? availableHeight * 0.03
                : screenHeight * 0.02;

            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  /// HEADER
                  Container(
                    width: double.infinity,
                    height: headerHeight,
                    decoration: BoxDecoration(
                      color: const Color(0xFF34C1AD),
                      borderRadius: BorderRadius.only(
                        // RESPONSIVE RADIUS — REPLACES HARDCODED 200
                        bottomLeft: Radius.circular(headerRadius),
                        bottomRight: Radius.circular(headerRadius),
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.015),

                  /// TITLE
                  Text(
                    "Verification",
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.008),

                  /// SUBTITLE
                  Text(
                    "Enter the code to continue.",
                    style: TextStyle(
                      fontSize: subtitleFontSize,
                      color: Colors.black54,
                    ),
                  ),

                  SizedBox(height: sectionSpacing),

                  /// IMAGE
                  SizedBox(
                    height: imageHeight,
                    child: Image.asset(
                      "assets/images/send_code.png",
                      fit: BoxFit.contain,
                    ),
                  ),

                  SizedBox(height: sectionSpacing),

                  /// INFO TEXT
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

                  /// OTP BOXES
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.08,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // UPDATED _otpBox CALLS — AB PREVIOUSFOCUS BHI PASS KIYA
                        // TAAKI BACKWARD NAVIGATION KAM KARE
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

                  /// SIGN UP BUTTON
                  SizedBox(
                    width: buttonWidth,
                    height: buttonHeight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyCreatedPage(title: ''),
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

                  /// RESEND CODE
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

                  /// BACK BUTTON
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

  /// OTP BOX — BACKSPACE BACKWARD NAVIGATION ADD KI GAYI HAI
  /// AB previousFocus PARAMETER BHI ACCEPT KARTA HAI
  /// onKeyEvent THROUGH BACKSPACE HANDLE HOTA HAI (initState ME ATTACH HAI)
  /// YEH METHOD SIRF FORWARD NAVIGATION AUR UI RENDER KE LIYE HAI
  Widget _otpBox({
    required TextEditingController controller,
    required double size,
    required FocusNode currentFocus,
    required FocusNode? nextFocus,

    // NEW PARAMETER — PICHLE FIELD KA FOCUS NODE
    // BACKSPACE PE ISKO USE KIYA JAATA HAI (initState ME onKeyEvent THROUGH)
    required FocusNode? previousFocus,
  }) {
    return SizedBox(
      width: size,

      /// HEIGHT THODI ZYADA RAKHI TAAKI TEXT CUT OFF NA HO
      height: size * 1.2,

      child: TextField(
        controller: controller,
        focusNode: currentFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,

        // DIGITS ONLY INPUT FORMATTER ADD KIYA
        // TAAKI USER SIRF NUMBERS ENTER KAR SAKE
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],

        /// TEXT VERTICALLY CENTER KARNE KE LIYE
        textAlignVertical: TextAlignVertical.center,

        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: Colors.teal.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),

          /// PADDING BALANCE KARTA HAI TEXT POSITION KO
          contentPadding: EdgeInsets.symmetric(
            vertical: size * 0.25,
          ),
        ),

        style: TextStyle(
          /// FONT SIZE THODA KAM KIYA TAAKI BOX ME FIT HO
          fontSize: size * 0.45,
          fontWeight: FontWeight.bold,
        ),

        /// FORWARD NAVIGATION — JAB DIGIT ENTER HO TAB AGLA FIELD FOCUS HO
        /// BACKWARD NAVIGATION initState ME onKeyEvent THROUGH HANDLE HOTI HAI
        onChanged: (value) {
          if (value.length == 1) {
            if (nextFocus != null) {
              FocusScope.of(context).requestFocus(nextFocus);
            } else {
              FocusScope.of(context).unfocus();
            }
          }
          // FALLBACK BACKWARD — KUCH DEVICES PE onChanged EMPTY VALUE PE BHI FIRE HOTA HAI
          // initState WALA onKeyEvent ZYADA RELIABLE HAI LEKIN YEH FALLBACK SAFE HAI
          else if (value.isEmpty && previousFocus != null) {
            FocusScope.of(context).requestFocus(previousFocus);
          }
        },
      ),
    );
  }
}