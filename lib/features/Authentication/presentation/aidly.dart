import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';
import 'package:flutter_aidly/service_offered.dart';

import '../../Welcome_page/presentation/service_offered.dart';

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
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const AidlyPgae(
            title: 'Aildy',
          ),
        );
      },
    );
  }
}

class AidlyPgae extends StatefulWidget {
  const AidlyPgae({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<AidlyPgae> createState() => _MyAidlyPageState();
}

class _MyAidlyPageState extends State<AidlyPgae> {
  Timer? _autoTimer;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _autoTimer = Timer(
      const Duration(seconds: 3),
          () {
        if (!_navigated && mounted) {
          _goToServicePage();
        }
      },
    );
  }

  void _goToServicePage() {
    if (_navigated) return;
    _navigated = true;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ServicePage(title: ''),
      ),
    );
  }

  @override
  void dispose() {
    _autoTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // THIS MANUALLY INITIALIZES SCREENUTIL
    ScreenUtil.init(context);

    return Scaffold(
      extendBody: true,

      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/Aidly_background_2.png',
            ),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),

        // WRAPPED IN SAFE AREA TO PREVENT CONTENT RENDERING UNDER
        // SYSTEM UI ELEMENTS LIKE NOTCH, STATUS BAR, AND NAVIGATION BAR
        child: SafeArea(

          // USED LAYOUT BUILDER TO DETECT AVAILABLE SCREEN HEIGHT AND WIDTH
          // SO SPACING AND SIZING CAN ADAPT ACROSS ALL DEVICE SIZES AND ORIENTATIONS
          child: LayoutBuilder(
            builder: (context, constraints) {
              final availableHeight = constraints.maxHeight;
              final availableWidth = constraints.maxWidth;

              // DETECT LANDSCAPE MODE BY COMPARING WIDTH TO HEIGHT
              final isLandscape = availableWidth > availableHeight;

              // RESPONSIVE TOP SPACING — REDUCED SIGNIFICANTLY IN LANDSCAPE
              // TO PREVENT OVERFLOW ON SMALL AND ROTATED SCREENS
              // PREVIOUSLY HARDCODED TO 350.h WHICH CAUSED OVERFLOW IN LANDSCAPE
              final double topSpacing = isLandscape
                  ? availableHeight * 0.04
                  : availableHeight * 0.30;

              // RESPONSIVE LOGO SIZE — SCALES DOWN IN LANDSCAPE AND ON SMALL SCREENS
              // TO PREVENT OVERFLOW. PREVIOUSLY FIXED AT 200.h / 200.w
              final double logoSize = isLandscape
                  ? availableHeight * 0.40
                  : availableWidth * 0.50;

              // RESPONSIVE ARC TEXT RADIUS — SMALLER IN LANDSCAPE TO FIT WITHIN BOUNDS
              final double arcRadius = isLandscape
                  ? availableHeight * 0.22
                  : availableWidth * 0.38;

              // RESPONSIVE BOTTOM SPACING — REDUCED IN LANDSCAPE
              final double bottomSpacing = isLandscape
                  ? availableHeight * 0.03
                  : availableHeight * 0.08;

              // SINGLE CHILD SCROLL VIEW ENSURES ALL CONTENT REMAINS REACHABLE
              // EVEN WHEN KEYBOARD OPENS OR SCREEN HEIGHT IS VERY SMALL
              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: ConstrainedBox(

                  // CONSTRAINED BOX ENSURES THE COLUMN FILLS AT LEAST THE FULL
                  // AVAILABLE HEIGHT, KEEPING LAYOUT STABLE ON LARGE SCREENS
                  constraints: BoxConstraints(
                    minHeight: availableHeight,
                  ),

                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        // RESPONSIVE TOP SPACER — REPLACES THE HARDCODED 350.h
                        // WHICH CAUSED OVERFLOW IN LANDSCAPE AND ON SMALL DEVICES
                        SizedBox(height: topSpacing),

                        // THIS DISPLAYS THE CURVED AIDLY TEXT
                        ArcText(
                          text: "AIDLY",
                          // RESPONSIVE RADIUS PREVENTS ARC TEXT FROM OVERFLOWING
                          // IN LANDSCAPE OR ON SMALL-HEIGHT SCREENS
                          radius: arcRadius,
                          startAngle: -5.40 / 5.40,
                          placement: Placement.outside,
                          textStyle: TextStyle(
                            fontSize: 100.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF00695C),
                            letterSpacing: -0.8,
                          ),
                        ),

                        // THIS DISPLAYS THE LOGO BOX
                        Container(
                          // RESPONSIVE LOGO HEIGHT AND WIDTH PREVENTS OVERFLOW
                          // ON SMALL SCREENS AND IN LANDSCAPE ORIENTATION
                          // PREVIOUSLY FIXED AT 200.h AND 200.w
                          height: logoSize,
                          width: logoSize,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: Colors.white,
                              width: 2.w,
                            ),
                          ),
                          child: Center(
                            child: Image.asset(
                              "assets/images/oldlogo.png",
                              height: logoSize,
                              width: logoSize * 0.95,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),

                        // RESPONSIVE BOTTOM SPACER BEFORE BUTTON
                        SizedBox(height: bottomSpacing),

                        // THIS DISPLAYS THE GET STARTED BUTTON
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 70.w,
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _goToServicePage,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF00695C),
                                padding: EdgeInsets.symmetric(
                                  vertical: 10.h,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.r),
                                ),
                              ),
                              child: Text(
                                "Get Started",
                                style: TextStyle(
                                  fontSize: 30.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // BOTTOM PADDING TO KEEP BUTTON AWAY FROM SYSTEM NAVIGATION BAR
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}