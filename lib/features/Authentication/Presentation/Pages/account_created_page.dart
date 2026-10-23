import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_aidly/features/home/presentation/pages/home_page.dart';

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
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double availableHeight = constraints.maxHeight;
            final double availableWidth = constraints.maxWidth;
            final bool isLandscape = availableWidth > availableHeight;
            final bool isSmallScreen = !isLandscape && availableHeight < 700;

            final double headerHeight = isLandscape
                ? availableHeight * 0.22
                : (isSmallScreen
                ? availableHeight * 0.14
                : 150.h);

            final double headerRadius = isLandscape
                ? availableHeight * 0.28
                : availableWidth * 0.55;

            final double imageHeight = isLandscape
                ? availableHeight * 0.45
                : (isSmallScreen
                ? availableHeight * 0.28
                : availableHeight * 0.35);

            final double titleFontSize = isLandscape
                ? availableHeight * 0.10
                : (isSmallScreen ? 28.sp : 36.sp);

            final double subtitleFontSize = isLandscape
                ? availableHeight * 0.07
                : (isSmallScreen ? 18.sp : 22.sp);

            final double bodyFontSize = isLandscape
                ? availableHeight * 0.065
                : (isSmallScreen ? 16.sp : 20.sp);

            final double successFontSize = isLandscape
                ? availableHeight * 0.08
                : (isSmallScreen ? 20.sp : 26.sp);

            final double buttonWidth = availableWidth * 0.50;
            final double buttonHeight = isLandscape
                ? availableHeight * 0.18
                : 50.h;

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
                  ),
                  SizedBox(height: sectionSpacing),
                  Text(
                    "Account Created!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: smallSpacing),
                  Text(
                    "Welcome to Aidly.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: subtitleFontSize,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: smallSpacing),
                  SizedBox(
                    height: imageHeight,
                    child: Image.asset(
                      "assets/images/Account_Created.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: smallSpacing),
                  Text(
                    "Your account has been created",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: bodyFontSize,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: smallSpacing),
                  Text(
                    "Successfully!",
                    style: TextStyle(
                      fontSize: successFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: sectionSpacing * 0.5),
                  SizedBox(
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
