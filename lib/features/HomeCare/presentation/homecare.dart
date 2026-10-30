import 'package:flutter/material.dart';
import 'package:flutter_aidly/Home.dart';
import 'package:flutter_aidly/features/HomeCare/presentation/quick_services.dart';
import 'package:flutter_aidly/homecare_plan.dart';
import 'package:flutter_aidly/quick_services.dart';

import '../../Home/presentation/Home.dart';
import 'homecare_plan.dart';

void main() {
  runApp(const MyApp());
}

/// MAIN APP
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeCarePage(),
    );
  }
}

/// HOME CARE PAGE
class HomeCarePage extends StatefulWidget {
  const HomeCarePage({super.key});

  @override
  State<HomeCarePage> createState() => _HomeCarePageState();
}

class _HomeCarePageState extends State<HomeCarePage> {
  int selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    /// RESPONSIVE SIZE — using LayoutBuilder for orientation-aware sizing
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    /// DETECT ORIENTATION — used to apply landscape-safe constraints
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    /// DETECT TABLET — screens wider than 600dp are treated as tablets
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFDDF1EC),
      body: SafeArea(
        child: Column(
          children: [
            /// SCROLLABLE BODY — Expanded ensures it fills space without overflow
            Expanded(
              child: SingleChildScrollView(
                /// PHYSICS ENSURES SMOOTH SCROLLING ON ALL DEVICES
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.045,
                    vertical: screenHeight * 0.015,
                  ),
                  child: Column(
                    children: [
                      /// TOP HEADER
                      /// FIX: CLAMPED VERTICAL PADDING TO PREVENT COLLAPSE IN LANDSCAPE
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          /// CLAMP PREVENTS OVERFLOW ON SMALL/LANDSCAPE SCREENS
                          vertical: (screenHeight * 0.05).clamp(20.0, 80.0),
                        ),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFFE4E4E4),
                              Color(0xFFBC21FF),
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Home care\nServices",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              /// FIX: CLAMPED FONT SIZE FOR TABLET AND LARGE SCREEN SAFETY
                              fontSize:
                              (screenWidth * (isTablet ? 0.06 : 0.095))
                                  .clamp(24.0, 52.0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.022),

                      /// IMAGE SECTION
                      /// FIX 1: CHANGED Image.network TO Image.asset — local asset was
                      ///         incorrectly loaded via network, causing image not to render.
                      /// FIX 2: REPLACED FIXED HEIGHT WITH ConstrainedBox TO PREVENT
                      ///         COLLAPSE IN LANDSCAPE AND OVERFLOW ON SMALL DEVICES.
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          /// MIN HEIGHT ENSURES IMAGE IS ALWAYS VISIBLE
                          minHeight: isLandscape ? 100 : 160,
                          /// MAX HEIGHT PREVENTS OVERSIZED IMAGE ON TABLETS/DESKTOPS
                          maxHeight: isLandscape
                              ? screenHeight * 0.5
                              : (isTablet
                              ? screenHeight * 0.38
                              : screenHeight * 0.32),
                        ),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            /// FIX: CORRECTED FROM Image.network TO Image.asset
                            /// BECAUSE "assets/images/Home_care.jpeg" IS A LOCAL ASSET
                            child: Image.asset(
                              "assets/images/Home_care.jpeg",
                              fit: BoxFit.cover,
                              /// ERROR BUILDER ADDED FOR GRACEFUL FALLBACK IF ASSET MISSING
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[200],
                                  child: const Center(
                                    child: Icon(
                                      Icons.image_not_supported,
                                      color: Colors.grey,
                                      size: 48,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.015),

                      /// SLIDER DOTS — unchanged, already responsive
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          6,
                              (index) => Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.01,
                            ),
                            /// CLAMPED DOT SIZE FOR VERY LARGE/SMALL SCREENS
                            height: (screenWidth * 0.03).clamp(8.0, 16.0),
                            width: (screenWidth * 0.03).clamp(8.0, 16.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                              index == 0 ? Colors.white : Colors.white70,
                              border: Border.all(color: Colors.white),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      /// QUICK SERVICE BUTTON
                      /// FIX: CLAMPED VERTICAL PADDING TO PREVENT OVERFLOW IN LANDSCAPE
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuickServicesPage(),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Quick Services Clicked"),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(40),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            /// CLAMPED TO PREVENT BUTTON OVERFLOW ON LANDSCAPE/SMALL SCREENS
                            vertical:
                            (screenHeight * 0.045).clamp(16.0, 60.0),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFFF5D3D3),
                                Color(0xFFE00000),
                                Color(0xFFF5D3D3),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Quick\nservices",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                /// FIX: CLAMPED FONT SIZE FOR TABLET AND LARGE SCREEN SAFETY
                                fontSize:
                                (screenWidth * (isTablet ? 0.06 : 0.09))
                                    .clamp(22.0, 48.0),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.032),

                      /// PLAN BUTTON
                      /// FIX: CLAMPED VERTICAL PADDING TO PREVENT OVERFLOW IN LANDSCAPE
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeCarePlanPage(),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Plan Clicked"),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(40),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            /// CLAMPED TO PREVENT BUTTON OVERFLOW ON LANDSCAPE/SMALL SCREENS
                            vertical:
                            (screenHeight * 0.055).clamp(18.0, 70.0),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFFD7DBFF),
                                Color(0xFF2143FF),
                                Color(0xFFD7DBFF),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "plan",
                              style: TextStyle(
                                color: Colors.white,
                                /// FIX: CLAMPED FONT SIZE FOR TABLET AND LARGE SCREEN SAFETY
                                fontSize:
                                (screenWidth * (isTablet ? 0.06 : 0.09))
                                    .clamp(22.0, 48.0),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),
                    ],
                  ),
                ),
              ),
            ),

            /// BOTTOM NAV BAR
            /// FIX: WRAPPED IN LayoutBuilder TO MAKE NAV BAR RESPONSIVE
            /// ACROSS PORTRAIT, LANDSCAPE, TABLET, AND DESKTOP
            LayoutBuilder(
              builder: (context, constraints) {
                /// NAV BAR IS ALWAYS VISIBLE — no fixed height that could overflow
                return Container(
                  padding: EdgeInsets.symmetric(
                    /// CLAMPED NAV BAR PADDING FOR LANDSCAPE AND TABLET SAFETY
                    vertical: (screenHeight * 0.018).clamp(8.0, 24.0),
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFF0E7A68),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      navItem(
                        context: context,
                        icon: Icons.home,
                        label: "Home",
                        index: 0,
                      ),
                      navItem(
                        context: context,
                        icon: Icons.emergency,
                        label: "Ambulance",
                        index: 1,
                      ),
                      navItem(
                        context: context,
                        icon: Icons.health_and_safety,
                        label: "Health care",
                        index: 2,
                      ),
                      navItem(
                        context: context,
                        icon: Icons.receipt_long,
                        label: "My Order",
                        index: 3,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// NAV ITEM
  Widget navItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required int index,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    /// DETECT TABLET FOR NAV ICON/FONT SCALING
    final isTablet = screenWidth > 600;

    bool isSelected = selectedIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        if (index == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MergedHomePage(),
            ),
          );
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("$label Clicked"),
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.white : Colors.white70,
            /// FIX: CLAMPED ICON SIZE TO PREVENT OVERFLOW ON LARGE/LANDSCAPE SCREENS
            size: (screenWidth * (isTablet ? 0.05 : 0.08)).clamp(20.0, 40.0),
          ),
          SizedBox(height: (screenWidth * 0.012).clamp(4.0, 10.0)),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white70,
              /// FIX: CLAMPED FONT SIZE FOR NAV LABELS ON TABLETS AND LANDSCAPE
              fontSize:
              (screenWidth * (isTablet ? 0.025 : 0.038)).clamp(10.0, 18.0),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}