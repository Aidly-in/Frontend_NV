import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_aidly/LoginAccount.dart';
import 'package:flutter_aidly/sendcode.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

/// MAIN APP
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(),
          home: const MyAccountPage(title: ''),
        );
      },
    );
  }
}

/// CREATE ACCOUNT PAGE
class MyAccountPage extends StatefulWidget {
  const MyAccountPage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {

  final TextEditingController phoneController = TextEditingController();

  bool keepLoggedIn = false;
  bool rememberME = false;

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
  Widget build(BuildContext context) {

    /// SCREEN SIZE DETECT KARO
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFD4F1ED),

      body: SafeArea(
        top: false,
        // LAYOUT BUILDER ADD KIYA — REAL AVAILABLE SPACE DETECT KARNE KE LIYE
        // ISSE LANDSCAPE, TABLET, SMALL SCREEN SAHI SE ADAPT HOTE HAIN
        child: LayoutBuilder(
          builder: (context, constraints) {

            final double availableHeight = constraints.maxHeight;
            final double availableWidth = constraints.maxWidth;

            // LANDSCAPE MODE DETECT KIYA — WIDTH > HEIGHT MATLAB LANDSCAPE
            // PEHLE SIRF HEIGHT < 700 THA JO LANDSCAPE IDENTIFY NAHI KARTA THA
            final bool isLandscape = availableWidth > availableHeight;

            // CHHOTI SCREEN CHECK — SIRF PORTRAIT ME RELEVANT HAI
            // LANDSCAPE BRANCH ALAG SE HANDLE HOTI HAI NEECHE
            final bool isSmallScreen = !isLandscape && screenHeight < 700;

            // RESPONSIVE HEADER HEIGHT
            // LANDSCAPE ME BAHUT CHOTA KIYA — PEHLE 100.h/150.h THA JO LANDSCAPE
            // ME BAHUT ZYADA HEIGHT LETA THA AUR CONTENT NEECHE PUSH HO JAATA THA
            final double headerHeight = isLandscape
                ? availableHeight * 0.22
                : (isSmallScreen ? 100.h : 150.h);

            // RESPONSIVE HEADER BORDER RADIUS — HARDCODED 200.r REPLACE KIYA
            // 200.r LANDSCAPE AUR CHHOTI SCREENS PE VISUAL DISTORTION KARTA THA
            final double headerRadius = isLandscape
                ? availableHeight * 0.28
                : availableWidth * 0.55;

            // RESPONSIVE GAP AFTER HEADER
            // PEHLE 80.h THA JO LANDSCAPE ME BAHUT BADA THA AUR OVERFLOW KARTA THA
            final double afterHeaderGap = isLandscape
                ? availableHeight * 0.04
                : (isSmallScreen ? 30.h : 80.h);

            // RESPONSIVE TITLE FONT SIZE
            final double titleFontSize = isLandscape
                ? availableHeight * 0.10
                : (isSmallScreen ? 28.sp : 40.sp);

            // RESPONSIVE SUBTITLE FONT SIZE
            final double subtitleFontSize = isLandscape
                ? availableHeight * 0.065
                : (isSmallScreen ? 16.sp : 20.sp);

            // RESPONSIVE LABEL FONT SIZE
            final double labelFontSize = isLandscape
                ? availableHeight * 0.07
                : (isSmallScreen ? 18.sp : 25.sp);

            // RESPONSIVE INPUT FONT SIZE
            final double inputFontSize = isLandscape
                ? availableHeight * 0.07
                : (isSmallScreen ? 16.sp : 18.sp);

            // RESPONSIVE SPACING BEFORE PHONE FIELD
            final double beforePhoneGap = isLandscape
                ? availableHeight * 0.03
                : (isSmallScreen ? 25.h : 50.h);

            // RESPONSIVE SPACING AFTER LABEL
            final double afterLabelGap = isLandscape
                ? availableHeight * 0.03
                : (isSmallScreen ? 20.h : 40.h);

            // RESPONSIVE SPACING AFTER PHONE FIELD
            final double afterPhoneGap = isLandscape
                ? availableHeight * 0.04
                : (isSmallScreen ? 30.h : 60.h);

            // RESPONSIVE VERIFY BUTTON DIMENSIONS
            // PEHLE FIXED 200.w AUR 50.h THA — NARROW LANDSCAPE SCREENS PE OVERFLOW HOTA THA
            final double verifyButtonWidth = availableWidth * 0.50;
            final double verifyButtonHeight = isLandscape
                ? availableHeight * 0.18
                : 50.h;

            // RESPONSIVE LOGIN TEXT FONT SIZE
            final double loginFontSize = isLandscape
                ? availableHeight * 0.065
                : (isSmallScreen ? 14.sp : 18.sp);

            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  /// TOP HEADER
                  Container(
                    width: double.infinity,
                    // RESPONSIVE HEIGHT — REPLACES FIXED isSmallScreen ? 100.h : 150.h
                    height: headerHeight,
                    decoration: BoxDecoration(
                      color: const Color(0xFF34C1AD),
                      borderRadius: BorderRadius.only(
                        // RESPONSIVE RADIUS — REPLACES HARDCODED 200.r
                        // 200.r LANDSCAPE PE VISUALLY DISTORTED DIKHTA THA
                        bottomLeft: Radius.circular(headerRadius),
                        bottomRight: Radius.circular(headerRadius),
                      ),
                    ),
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(
                      left: 10.w,
                      top: 20.h,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 24.sp,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),

                  // RESPONSIVE GAP — REPLACES FIXED isSmallScreen ? 30.h : 80.h
                  // 80.h LANDSCAPE ME ALMOST HALF SCREEN LETE THA
                  SizedBox(height: afterHeaderGap),

                  /// TITLE
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        "Create Account",
                        style: TextStyle(
                          // RESPONSIVE FONT SIZE
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 2.h),

                  Text(
                    "sign up to continue",
                    style: TextStyle(
                      // RESPONSIVE FONT SIZE
                      fontSize: subtitleFontSize,
                    ),
                  ),

                  // RESPONSIVE GAP BEFORE PHONE LABEL
                  SizedBox(height: beforePhoneGap),

                  /// MOBILE NUMBER TEXT
                  Padding(
                    padding: EdgeInsets.only(left: 40.w),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Enter Your Mobile Number",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          // RESPONSIVE FONT SIZE
                          fontSize: labelFontSize,
                        ),
                      ),
                    ),
                  ),

                  // RESPONSIVE GAP AFTER LABEL
                  SizedBox(height: afterLabelGap),

                  /// PHONE FIELD
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Row(
                      children: [

                        /// COUNTRY CODE DROPDOWN
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedCountryCode,
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size: 22.sp,
                              ),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                // RESPONSIVE FONT SIZE
                                fontSize: inputFontSize,
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

                        SizedBox(width: 12.w),

                        /// PHONE NUMBER FIELD
                        Expanded(
                          child: TextField(
                            controller: phoneController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            style: TextStyle(
                              // RESPONSIVE FONT SIZE
                              fontSize: inputFontSize,
                            ),
                            decoration: InputDecoration(
                              hintText: "9897100000",
                              hintStyle: TextStyle(
                                // RESPONSIVE FONT SIZE
                                fontSize: inputFontSize,
                              ),
                              border: const UnderlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // RESPONSIVE GAP AFTER PHONE FIELD
                  SizedBox(height: afterPhoneGap),

                  /// VERIFY BUTTON
                  SizedBox(
                    // RESPONSIVE WIDTH AND HEIGHT — REPLACES FIXED 200.w AND 50.h
                    // FIXED VALUES NARROW LANDSCAPE SCREENS PE OVERFLOW KA RISK LETE THE
                    width: verifyButtonWidth,
                    height: verifyButtonHeight,
                    child: ElevatedButton(
                      onPressed: () {

                        /// CHECK 10 DIGITS
                        if (phoneController.text.length != 10) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Please enter valid 10 digit mobile number",
                              ),
                            ),
                          );
                          return;
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MySendCode(title: ""),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF34C1AD),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                      ),
                      child: Text(
                        "Verify",
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 25.h),

                  /// LOGIN
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                          color: Colors.black54,
                          // RESPONSIVE FONT SIZE
                          fontSize: loginFontSize,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const LoginScreen(title: ""),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD4F1ED),
                          elevation: 0,
                        ),
                        child: Text(
                          "log in",
                          style: TextStyle(
                            // RESPONSIVE FONT SIZE
                            fontSize: loginFontSize,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}