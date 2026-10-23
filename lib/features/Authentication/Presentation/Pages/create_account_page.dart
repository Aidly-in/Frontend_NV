import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_aidly/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_aidly/features/auth/presentation/pages/send_code_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          home: const MyAccountPage(title: ''),
        );
      },
    );
  }
}

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
  Widget build(BuildContext context) {
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
            final bool isSmallScreen = !isLandscape && screenHeight < 700;

            final double headerHeight = isLandscape
                ? availableHeight * 0.22
                : (isSmallScreen ? 100.h : 150.h);

            final double headerRadius = isLandscape
                ? availableHeight * 0.28
                : availableWidth * 0.55;

            final double afterHeaderGap = isLandscape
                ? availableHeight * 0.04
                : (isSmallScreen ? 30.h : 80.h);

            final double titleFontSize = isLandscape
                ? availableHeight * 0.10
                : (isSmallScreen ? 28.sp : 40.sp);

            final double subtitleFontSize = isLandscape
                ? availableHeight * 0.065
                : (isSmallScreen ? 16.sp : 20.sp);

            final double labelFontSize = isLandscape
                ? availableHeight * 0.07
                : (isSmallScreen ? 18.sp : 25.sp);

            final double inputFontSize = isLandscape
                ? availableHeight * 0.07
                : (isSmallScreen ? 16.sp : 18.sp);

            final double beforePhoneGap = isLandscape
                ? availableHeight * 0.03
                : (isSmallScreen ? 25.h : 50.h);

            final double afterLabelGap = isLandscape
                ? availableHeight * 0.03
                : (isSmallScreen ? 20.h : 40.h);

            final double afterPhoneGap = isLandscape
                ? availableHeight * 0.04
                : (isSmallScreen ? 30.h : 60.h);

            final double verifyButtonWidth = availableWidth * 0.50;
            final double verifyButtonHeight = isLandscape
                ? availableHeight * 0.18
                : 50.h;

            final double loginFontSize = isLandscape
                ? availableHeight * 0.065
                : (isSmallScreen ? 14.sp : 18.sp);

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
                  SizedBox(height: afterHeaderGap),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        "Create Account",
                        style: TextStyle(
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
                      fontSize: subtitleFontSize,
                    ),
                  ),
                  SizedBox(height: beforePhoneGap),
                  Padding(
                    padding: EdgeInsets.only(left: 40.w),
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
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Row(
                      children: [
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
                        Expanded(
                          child: TextField(
                            controller: phoneController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            style: TextStyle(
                              fontSize: inputFontSize,
                            ),
                            decoration: InputDecoration(
                              hintText: "9897100000",
                              hintStyle: TextStyle(
                                fontSize: inputFontSize,
                              ),
                              border: const UnderlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: afterPhoneGap),
                  SizedBox(
                    width: verifyButtonWidth,
                    height: verifyButtonHeight,
                    child: ElevatedButton(
                      onPressed: () {
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                          color: Colors.black54,
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
