import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_aidly/Home.dart';

void main() {
  runApp(const MyApp());
}

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
          home: const MyCreatedPage(title: ''),
        );
      },
    );
  }
}

class MyCreatedPage extends StatefulWidget {
  const MyCreatedPage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyCreatedPage> createState() => _MyCreatedState();
}

class _MyCreatedState extends State<MyCreatedPage> {

  bool rememberME = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFD4F1ED),

      body: SafeArea(
        top: false,
        // LAYOUT BUILDER ADD KIYA — REAL AVAILABLE SCREEN SPACE DETECT KARNE KE LIYE
        // BINA ISKE LANDSCAPE, TABLET, AUR SMALL SCREEN PE SIZING ADAPT NAHI HOTI
        child: LayoutBuilder(
          builder: (context, constraints) {

            final double availableHeight = constraints.maxHeight;
            final double availableWidth = constraints.maxWidth;

            // LANDSCAPE MODE DETECT — WIDTH > HEIGHT MATLAB LANDSCAPE
            final bool isLandscape = availableWidth > availableHeight;

            // SMALL SCREEN CHECK — SIRF PORTRAIT ME RELEVANT
            // LANDSCAPE KI ALAG SIZING HAI ISLIYE EXCLUDE KIYA
            final bool isSmallScreen = !isLandscape && availableHeight < 700;

            // RESPONSIVE HEADER HEIGHT
            // PEHLE FIXED 150.h THA — LANDSCAPE ME BAHUT ZYADA JAGAH LETA THA
            final double headerHeight = isLandscape
                ? availableHeight * 0.22
                : (isSmallScreen
                ? availableHeight * 0.14
                : 150.h);

            // RESPONSIVE HEADER BORDER RADIUS
            // PEHLE HARDCODED 200.r THA — CHHOTI AUR LANDSCAPE SCREENS PE
            // DISPROPORTIONATE DIKHTA THA
            final double headerRadius = isLandscape
                ? availableHeight * 0.28
                : availableWidth * 0.55;

            // RESPONSIVE IMAGE HEIGHT — SABSE BADA ISSUE YEH THA
            // PEHLE FIXED 300.h THA — LANDSCAPE ME ALMOST PURI SCREEN LE LETA THA
            // AUR BAAKI CONTENT OVERFLOW HO JAATA THA
            final double imageHeight = isLandscape
                ? availableHeight * 0.45
                : (isSmallScreen
                ? availableHeight * 0.28
                : availableHeight * 0.35);

            // RESPONSIVE TITLE FONT SIZE
            final double titleFontSize = isLandscape
                ? availableHeight * 0.10
                : (isSmallScreen ? 28.sp : 36.sp);

            // RESPONSIVE SUBTITLE FONT SIZE
            final double subtitleFontSize = isLandscape
                ? availableHeight * 0.07
                : (isSmallScreen ? 18.sp : 22.sp);

            // RESPONSIVE BODY FONT SIZE
            final double bodyFontSize = isLandscape
                ? availableHeight * 0.065
                : (isSmallScreen ? 16.sp : 20.sp);

            // RESPONSIVE SUCCESS TEXT FONT SIZE
            final double successFontSize = isLandscape
                ? availableHeight * 0.08
                : (isSmallScreen ? 20.sp : 26.sp);

            // RESPONSIVE BUTTON DIMENSIONS
            // PEHLE FIXED 200.w AUR 50.h THA — NARROW LANDSCAPE PE OVERFLOW RISK THA
            final double buttonWidth = availableWidth * 0.50;
            final double buttonHeight = isLandscape
                ? availableHeight * 0.18
                : 50.h;

            // RESPONSIVE SPACING — LANDSCAPE ME REDUCED TO PREVENT OVERFLOW
            final double sectionSpacing = isLandscape
                ? availableHeight * 0.03
                : 20.h;

            final double smallSpacing = isLandscape
                ? availableHeight * 0.015
                : 5.h;

            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  /// TOP CURVE
                  Container(
                    // RESPONSIVE HEIGHT — REPLACES FIXED 150.h
                    height: headerHeight,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF34C1AD),
                      borderRadius: BorderRadius.only(
                        // RESPONSIVE RADIUS — REPLACES HARDCODED 200.r
                        bottomLeft: Radius.circular(headerRadius),
                        bottomRight: Radius.circular(headerRadius),
                      ),
                    ),
                  ),

                  // RESPONSIVE SPACING
                  SizedBox(height: sectionSpacing),

                  /// TITLE
                  Text(
                    "Account Created!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      // RESPONSIVE FONT SIZE
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  // RESPONSIVE SMALL SPACING
                  SizedBox(height: smallSpacing),

                  /// SUBTITLE
                  Text(
                    "Welcome to Aidly.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      // RESPONSIVE FONT SIZE
                      fontSize: subtitleFontSize,
                      color: Colors.black87,
                    ),
                  ),

                  SizedBox(height: smallSpacing),

                  /// IMAGE
                  SizedBox(
                    // RESPONSIVE HEIGHT — REPLACES FIXED 300.h
                    // 300.h LANDSCAPE ME ALMOST PURI SCREEN LE LETA THA
                    // YEH OVERFLOW KA SABSE BADA CAUSE THA
                    height: imageHeight,
                    child: Image.asset(
                      "assets/images/Account_Created.png",
                      fit: BoxFit.contain,
                    ),
                  ),

                  // RESPONSIVE SMALL SPACING
                  SizedBox(height: smallSpacing),

                  /// INFO TEXT
                  Text(
                    "Your account has been created",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      // RESPONSIVE FONT SIZE
                      fontSize: bodyFontSize,
                      color: Colors.black87,
                    ),
                  ),

                  // RESPONSIVE SMALL SPACING
                  SizedBox(height: smallSpacing),

                  /// SUCCESS TEXT
                  Text(
                    "Successfully!",
                    style: TextStyle(
                      // RESPONSIVE FONT SIZE
                      fontSize: successFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),

                  // RESPONSIVE SPACING BEFORE BUTTON
                  SizedBox(height: sectionSpacing * 0.5),

                  /// CONTINUE BUTTON
                  SizedBox(
                    // RESPONSIVE WIDTH AND HEIGHT — REPLACES FIXED 200.w AND 50.h
                    width: buttonWidth,
                    height: buttonHeight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF34C1AD),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AidlyMergedDemo(),
                          ),
                              (Route<dynamic> route) => false,
                        );
                      },
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  // RESPONSIVE BOTTOM SPACING
                  SizedBox(height: sectionSpacing),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}