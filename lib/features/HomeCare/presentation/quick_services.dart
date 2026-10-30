import 'package:flutter/material.dart';
import "package:flutter_aidly/Home.dart";

import '../../Home/presentation/Home.dart';

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
      home: QuickServicesPage(),
    );
  }
}

/// QUICK SERVICES PAGE
class QuickServicesPage extends StatefulWidget {
  const QuickServicesPage({super.key});

  @override
  State<QuickServicesPage> createState() => _QuickServicesPageState();
}

class _QuickServicesPageState extends State<QuickServicesPage> {
  int selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    /// RESPONSIVE SIZE
    final screenWidth = MediaQuery.of(context).size.width;

    /// FIX: USE OrientationBuilder TO DETECT PORTRAIT VS LANDSCAPE
    /// AND ADAPT LAYOUT ACCORDINGLY — PREVENTS COLLAPSE AND OVERFLOW
    return OrientationBuilder(
      builder: (context, orientation) {
        final isLandscape = orientation == Orientation.landscape;

        return Scaffold(
          backgroundColor: const Color(0xFFDDF1EC),
          body: SafeArea(
            child: Column(
              children: [
                /// SCROLLABLE BODY
                Expanded(
                  child: SingleChildScrollView(
                    /// FIX: KEYBOARD DISMISS ON DRAG FOR KEYBOARD-SAFE LAYOUT
                    keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Center(
                      child: ConstrainedBox(
                        /// FIX: TABLET/WIDE SCREEN CONSTRAINT — PREVENTS CONTENT
                        /// FROM STRETCHING EDGE-TO-EDGE ON LARGE DISPLAYS
                        constraints: const BoxConstraints(maxWidth: 720),
                        child: Column(
                          children: [
                            /// TOP HEADER
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                /// FIX: REPLACED screenHeight * 0.05 WITH ADAPTIVE VALUE
                                /// In landscape, screenHeight is very small (~360px) so
                                /// screenHeight * 0.05 = ~18px which is too compressed,
                                /// while in portrait it can be too tall.
                                /// Now uses screenWidth-based value in portrait for
                                /// proportional sizing, and a fixed small value in landscape
                                /// to prevent the header from dominating the screen.
                                vertical: isLandscape
                                    ? 16
                                    : screenWidth * 0.12,
                              ),
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xFFF3D4D4),
                                    Color(0xFFE00000),
                                  ],
                                ),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(40),
                                  bottomRight: Radius.circular(40),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Quick\nservices",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.1,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            /// FIX: REPLACED screenHeight * 0.03 WITH STABLE FIXED VALUE
                            /// TO PREVENT SPACING FROM COLLAPSING IN LANDSCAPE
                            const SizedBox(height: 20),

                            /// QUICK SERVICE BUTTONS
                            quickServiceCard(
                              context: context,
                              isLandscape: isLandscape,
                              title: "Doctor Visit",
                              icon: Icons.local_hospital,
                            ),
                            quickServiceCard(
                              context: context,
                              isLandscape: isLandscape,
                              title: "Emergency Care",
                              icon: Icons.emergency,
                            ),
                            quickServiceCard(
                              context: context,
                              isLandscape: isLandscape,
                              title: "Home Nurse",
                              icon: Icons.health_and_safety,
                            ),
                            quickServiceCard(
                              context: context,
                              isLandscape: isLandscape,
                              title: "Medicine Delivery",
                              icon: Icons.medication,
                            ),
                            quickServiceCard(
                              context: context,
                              isLandscape: isLandscape,
                              title: "Lab Test",
                              icon: Icons.science,
                            ),

                            /// FIX: REPLACED screenHeight * 0.025 WITH STABLE FIXED VALUE
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                /// BOTTOM NAVIGATION
                Container(
                  padding: const EdgeInsets.symmetric(
                    /// FIX: REPLACED screenHeight * 0.018 WITH STABLE FIXED VALUE
                    /// screenHeight * 0.018 in landscape = ~6px (near invisible)
                    /// and in portrait on large tablets = ~18px (too tall).
                    /// Fixed 12px gives consistent, stable nav bar height everywhere.
                    vertical: 12,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFF2FC3B4),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(26),
                      topRight: Radius.circular(26),
                    ),
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
                        label: "Ambulance\nBooking",
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
                        icon: Icons.person_outline,
                        label: "My profile",
                        index: 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// QUICK SERVICE CARD
  /// FIX: ADDED isLandscape PARAMETER TO ADAPT CARD PADDING PER ORIENTATION
  Widget quickServiceCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required bool isLandscape, // FIX: NEW PARAMETER FOR ORIENTATION-AWARE PADDING
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.045,
        /// FIX: REPLACED screenHeight * 0.01 WITH STABLE FIXED VERTICAL MARGIN
        /// 5 cards × screenHeight * 0.01 in landscape caused cumulative overflow
        vertical: 6,
      ),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("$title Clicked")),
          );
        },
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            /// FIX: REPLACED screenHeight * 0.028 WITH ADAPTIVE VALUE
            /// In landscape, screenHeight * 0.028 ≈ 10px (cards compress badly)
            /// In portrait on tall phones, it can be too generous.
            /// Now uses a fixed value in landscape and screenWidth-based in portrait
            /// so cards stay readable and proportional on all devices.
            vertical: isLandscape ? 12 : screenWidth * 0.04,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                height: screenWidth * 0.16,
                width: screenWidth * 0.16,
                decoration: BoxDecoration(
                  color: const Color(0xFFE9F8F5),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF2FC3B4),
                  size: screenWidth * 0.085,
                ),
              ),
              SizedBox(width: screenWidth * 0.045),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: screenWidth * 0.055,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: screenWidth * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// NAVIGATION ITEM
  Widget navItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required int index,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
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
          SnackBar(content: Text("$label Clicked")),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.black : Colors.white,
            size: screenWidth * 0.08,
          ),
          /// FIX: REPLACED screenHeight * 0.005 WITH STABLE FIXED VALUE
          /// Prevents spacing from collapsing to 0 in landscape
          const SizedBox(height: 3),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.white,
              fontSize: screenWidth * 0.033,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}