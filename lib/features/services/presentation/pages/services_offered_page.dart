import 'package:flutter/material.dart';
import 'package:flutter_aidly/features/pharmacy/presentation/pages/medicine_dashboard_page.dart';
import 'package:flutter_aidly/features/pickup_homecare/presentation/pages/home_care_page.dart';
import 'package:flutter_aidly/features/pickup_homecare/presentation/pages/pickup_details_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_aidly/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:flutter_aidly/features/auth/presentation/pages/create_account_page.dart';
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
        return const MaterialApp(
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            final availableHeight = constraints.maxHeight;
            final availableWidth = constraints.maxWidth;
            final bool isLandscape = availableWidth > availableHeight;

            final double headerHeight = isLandscape
                ? availableHeight * 0.20
                : availableHeight * 0.17;

            final double headerRadius = isLandscape
                ? availableHeight * 0.30
                : availableWidth * 0.55;

            final double buttonHeight = isLandscape
                ? availableHeight * 0.14
                : availableHeight * 0.09;

            final double sectionSpacing = isLandscape
                ? availableHeight * 0.03
                : availableHeight * 0.035;

            final double continueButtonHeight = isLandscape
                ? availableHeight * 0.14
                : availableHeight * 0.07;

            final double continueButtonWidth = availableWidth * 0.50;

            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
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
                    "Services Offered",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 34.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: sectionSpacing),
                  _serviceButton(
                    context: context,
                    title: "Ambulance Booking",
                    icon: FontAwesomeIcons.truckMedical,
                    color: const Color(0xFFD8F3DC),
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
                  Padding(
                    padding: EdgeInsets.all(20.w),
                    child: SizedBox(
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
                              builder: (context) => const MyAccountPage(title: ' '),
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

  Widget _serviceButton({
    required BuildContext context,
    required String title,
    required dynamic icon,
    required Color color,
    required VoidCallback onTap,
    required double buttonHeight,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 18.w,
      ),
      child: SizedBox(
        width: double.infinity,
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
              icon is IconData
                  ? Icon(
                icon,
                color: Colors.black,
                size: 22.sp,
              )
                  : FaIcon(
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
