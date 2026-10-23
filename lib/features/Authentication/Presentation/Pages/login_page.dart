import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_aidly/features/auth/presentation/pages/enter_code_page.dart';

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

  String selectedCountryCode = "+91";

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
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double availableWidth = constraints.maxWidth;
            final double availableHeight = constraints.maxHeight;

            final bool isLandscape = availableWidth > availableHeight;
            final bool isTablet = availableWidth > 600;

            final double headerHeight = isLandscape
                ? availableHeight * 0.26
                : screenHeight * 0.18;

            final double headerRadius = isLandscape
                ? availableHeight * 0.30
                : screenWidth * 0.55;

            final double fontWidthBase = isTablet
                ? availableWidth * 0.5
                : availableWidth;

            final double titleFontSize = fontWidthBase * 0.095;
            final double subtitleFontSize = fontWidthBase * 0.062;
            final double labelFontSize = fontWidthBase * 0.058;
            final double bodyFontSize = fontWidthBase * 0.05;

            final double buttonWidth = availableWidth * 0.5;
            final double buttonHeight = isLandscape
                ? availableHeight * 0.14
                : screenHeight * 0.065;

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
                  Container(
                    height: headerHeight,
                    width: double.infinity,
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
                  SizedBox(height: afterHeaderGap),
                  Text(
                    "Login Account",
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.008),
                  Text(
                    "Welcome Back!",
                    style: TextStyle(
                      fontSize: subtitleFontSize,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: afterSubtitleGap),
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
                          fontSize: labelFontSize,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: afterLabelGap),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1,
                    ),
                    child: Row(
                      children: [
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
                        Expanded(
                          child: TextField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            style: TextStyle(
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
                  SizedBox(height: afterInputGap),
                  SizedBox(
                    width: buttonWidth,
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
                            builder: (context) => const OtpScreen(),
                          ),
                        );
                      }
                          : null,
                      child: Text(
                        "GET OTP",
                        style: TextStyle(
                          color: Colors.black,
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
