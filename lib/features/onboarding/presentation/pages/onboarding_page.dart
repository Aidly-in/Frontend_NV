import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';
import 'package:flutter_aidly/features/services/presentation/pages/services_offered_page.dart';

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
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: AidlyPgae(
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
        builder: (context) => const ServicePage(title: ''),
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
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final availableHeight = constraints.maxHeight;
              final availableWidth = constraints.maxWidth;
              final isLandscape = availableWidth > availableHeight;

              final double topSpacing = isLandscape
                  ? availableHeight * 0.04
                  : availableHeight * 0.30;

              final double logoSize = isLandscape
                  ? availableHeight * 0.40
                  : availableWidth * 0.50;

              final double arcRadius = isLandscape
                  ? availableHeight * 0.22
                  : availableWidth * 0.38;

              final double bottomSpacing = isLandscape
                  ? availableHeight * 0.03
                  : availableHeight * 0.08;

              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: availableHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: topSpacing),
                        ArcText(
                          text: "AIDLY",
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
                        Container(
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
                        SizedBox(height: bottomSpacing),
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
