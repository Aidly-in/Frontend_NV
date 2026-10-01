import 'package:flutter/material.dart';
import 'package:flutter_aidly/MedDashboard.dart';
import 'package:flutter_aidly/homecare.dart';
import 'package:flutter_aidly/pickup1.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_aidly/Aidly.dart';
// import 'package:flutter_aidly/LoginAccount.dart';
// import 'package:flutter_aidly/account_created.dart';
import 'package:flutter_aidly/cr_account.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
          home: AidlyPgae(title: ''),
        );
      },
    );
  }
}

class ServicePage extends StatefulWidget {
  const ServicePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<ServicePage> createState() => _MyServicesOfferedPage();
}

class _MyServicesOfferedPage extends State<ServicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD4F1ED),

      body: SafeArea(
         top: false,
        // LAYOUT BUILDER ADDED TO DETECT AVAILABLE SCREEN DIMENSIONS
        // THIS ALLOWS ALL SIZING TO ADAPT BASED ON REAL AVAILABLE SPACE
        // ACROSS PORTRAIT, LANDSCAPE, TABLETS, FOLDABLES, AND DESKTOPS
        child: LayoutBuilder(
          builder: (context, constraints) {
            final availableHeight = constraints.maxHeight;
            final availableWidth = constraints.maxWidth;

            // DETECT LANDSCAPE MODE TO APPLY REDUCED SPACINGS AND SIZES
            final bool isLandscape = availableWidth > availableHeight;

            // RESPONSIVE HEADER HEIGHT — PREVIOUSLY FIXED AT 150.h WHICH
            // CAUSED OVERFLOW AND DISPROPORTIONATE SIZING IN LANDSCAPE MODE
            final double headerHeight = isLandscape
                ? availableHeight * 0.20
                : availableHeight * 0.17;

            // RESPONSIVE HEADER BORDER RADIUS — PREVIOUSLY FIXED AT 200.r
            // WHICH CAUSED VISUAL DISTORTION ON SMALL AND LANDSCAPE SCREENS
            final double headerRadius = isLandscape
                ? availableHeight * 0.30
                : availableWidth * 0.55;

            // RESPONSIVE SERVICE BUTTON HEIGHT — PREVIOUSLY FIXED AT 70.h
            // WHICH CAUSED OVERFLOW IN LANDSCAPE AND ON SMALL SCREEN HEIGHTS
            final double buttonHeight = isLandscape
                ? availableHeight * 0.14
                : availableHeight * 0.09;

            // RESPONSIVE SPACING BETWEEN ELEMENTS — REDUCED IN LANDSCAPE
            // TO PREVENT CONTENT FROM BEING PUSHED OFF SCREEN
            final double sectionSpacing = isLandscape
                ? availableHeight * 0.03
                : availableHeight * 0.035;

            // RESPONSIVE CONTINUE BUTTON HEIGHT — SCALES WITH SCREEN
            final double continueButtonHeight = isLandscape
                ? availableHeight * 0.14
                : availableHeight * 0.07;

            // RESPONSIVE CONTINUE BUTTON WIDTH — SCALES WITH SCREEN WIDTH
            final double continueButtonWidth = availableWidth * 0.50;

            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [

                  /// TOP HEADER
                  Container(
                    // RESPONSIVE HEIGHT REPLACES FIXED 150.h
                    height: headerHeight,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF34C1AD),
                      borderRadius: BorderRadius.only(
                        // RESPONSIVE RADIUS REPLACES FIXED 200.r
                        // PREVENTS VISUAL DISTORTION IN LANDSCAPE AND SMALL SCREENS
                        bottomLeft: Radius.circular(headerRadius),
                        bottomRight: Radius.circular(headerRadius),
                      ),
                    ),
                  ),

                  SizedBox(height: sectionSpacing),

                  /// TITLE
                  Text(
                    "Services Offered",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 34.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: sectionSpacing),

                  /// AMBULANCE BUTTON
                  _serviceButton(
                    context: context,
                    title: "Ambulance Booking",
                    icon: FontAwesomeIcons.ambulance,
                    color: const Color(0xFFD8F3DC),
                    // PASSING RESPONSIVE BUTTON HEIGHT TO REUSABLE WIDGET
                    buttonHeight: buttonHeight,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PickupMapPage(),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: sectionSpacing),

                  /// HOME CARE BUTTON
                  _serviceButton(
                    context: context,
                    title: "Home Care Service",
                    icon: FontAwesomeIcons.userNurse,
                    color: const Color(0xFFB7E4C7),
                    buttonHeight: buttonHeight,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeCarePage(),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: sectionSpacing),

                  /// DOCTOR BUTTON
                  _serviceButton(
                    context: context,
                    title: "Doctor Appointment",
                    icon: Icons.local_hospital,
                    color: const Color(0xFF95D5B2),
                    buttonHeight: buttonHeight,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: sectionSpacing),

                  /// STORE BUTTON
                  _serviceButton(
                    context: context,
                    title: "Store",
                    icon: Icons.store,
                    color: const Color(0xFF74C69D),
                    buttonHeight: buttonHeight,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyAccountPage(title: ""),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: sectionSpacing),

                  /// CONTINUE BUTTON
                  Padding(
                    padding: EdgeInsets.all(20.w),
                    child: SizedBox(
                      // RESPONSIVE WIDTH AND HEIGHT REPLACE FIXED 200.w AND 50.h
                      // PREVENTS OVERFLOW ON SMALL SCREENS AND IN LANDSCAPE MODE
                      width: continueButtonWidth,
                      height: continueButtonHeight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF34C1AD),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyAccountPage(title: ' '),
                            ),
                          );
                        },
                        child: Text(
                          "Continue →",
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.black,
                          ),
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

  /// REUSABLE SERVICE BUTTON — UPDATED TO ACCEPT RESPONSIVE buttonHeight
  /// PARAMETER INSTEAD OF USING THE PREVIOUSLY FIXED 70.h INTERNALLY
  Widget _serviceButton({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    // NEW REQUIRED PARAMETER TO RECEIVE RESPONSIVE HEIGHT FROM LAYOUT BUILDER
    required double buttonHeight,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 18.w,
      ),
      child: SizedBox(
        width: double.infinity,
        // USES PASSED-IN RESPONSIVE HEIGHT INSTEAD OF FIXED 70.h
        height: buttonHeight,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 10.h,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          onPressed: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.sp,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Icon(
                icon,
                color: Colors.black,
                size: 22.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}