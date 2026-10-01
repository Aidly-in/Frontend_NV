import 'package:flutter/material.dart';
import 'package:flutter_aidly/Home.dart';
import 'dart:ui';

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
      home: HomeCarePlanPage(),
    );
  }
}

/// HOME CARE PLAN PAGE
class HomeCarePlanPage extends StatefulWidget {
  const HomeCarePlanPage({super.key});

  @override
  State<HomeCarePlanPage> createState() => _HomeCarePlanPageState();
}

class _HomeCarePlanPageState extends State<HomeCarePlanPage> {
  int selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // RESPONSIVE: Detect landscape so header padding and font shrink
    // to prevent the header alone from consuming the full viewport height
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    // RESPONSIVE: Cap header vertical padding — in landscape screenHeight is
    // much smaller, so a raw * 0.05 would make header too tall and cause overflow
    final double headerVerticalPadding = isLandscape
        ? clampDouble(screenHeight * 0.03, 10, 24)
        : clampDouble(screenHeight * 0.05, 20, 60);

    // RESPONSIVE: Cap header font size — screenWidth * 0.1 on tablet landscape
    // (~900px wide) = 90px font, which is enormous and causes layout breakage
    final double headerFontSize = isLandscape
        ? clampDouble(screenWidth * 0.055, 22, 38)
        : clampDouble(screenWidth * 0.1, 28, 48);

    return Scaffold(
      backgroundColor: const Color(0xFFDDF1EC),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                // RESPONSIVE: Align scroll content to top-center so on wide
                // screens (tablets/desktops) content doesn't stretch edge-to-edge
                child: Center(
                  child: ConstrainedBox(
                    // RESPONSIVE: Cap max content width for tablets and desktops
                    // so percentage-based sizes don't become absurdly large
                    constraints: const BoxConstraints(maxWidth: 640),
                    child: Column(
                      children: [
                        /// TOP HEADER
                        Container(
                          width: double.infinity,
                          // RESPONSIVE: Use clamped adaptive padding instead of
                          // raw screenHeight * 0.05 which overflows in landscape
                          padding: EdgeInsets.symmetric(
                            vertical: headerVerticalPadding,
                          ),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFFE4E4E4),
                                Color(0xFF2143FF),
                              ],
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Home care\nplan",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                // RESPONSIVE: Clamped font size prevents
                                // enormous text on tablets / landscape mode
                                fontSize: headerFontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.025),

                        /// 7 DAYS PLAN
                        planCard(
                          context: context,
                          title: "7 days trial",
                          oldPrice: "",
                          newPrice: "Free",
                          showOldPrice: false,
                        ),

                        SizedBox(height: screenHeight * 0.018),

                        /// 15 DAYS PLAN
                        planCard(
                          context: context,
                          title: "15 days plan",
                          oldPrice: "₹299",
                          newPrice: "₹199",
                          showOldPrice: true,
                        ),

                        SizedBox(height: screenHeight * 0.018),

                        /// 28 DAYS PLAN
                        planCard(
                          context: context,
                          title: "28 days plan",
                          oldPrice: "₹499",
                          newPrice: "₹399",
                          showOldPrice: true,
                        ),

                        SizedBox(height: screenHeight * 0.03),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            /// BOTTOM NAVIGATION BAR
            Container(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.018,
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
  }

  /// PLAN CARD
  Widget planCard({
    required BuildContext context,
    required String title,
    required String oldPrice,
    required String newPrice,
    required bool showOldPrice,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // RESPONSIVE: Clamp card content width reference so font sizes and paddings
    // are based on a capped width — prevents oversized text on tablets/desktops
    // Uses the smaller of actual screenWidth and the 640 content cap
    final double refWidth = screenWidth.clamp(0.0, 640.0);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.045,
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(refWidth * 0.045),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF1F1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            /// TITLE
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: TextStyle(
                  // RESPONSIVE: Clamp title font — screenWidth * 0.07 on a
                  // 900px tablet = 63px, which breaks the card layout
                  fontSize: clampDouble(refWidth * 0.07, 18, 32),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.012),

            Container(height: 1, color: Colors.black54),

            SizedBox(height: screenHeight * 0.012),

            /// PRICE ROW
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (showOldPrice)
                  Text(
                    oldPrice,
                    style: TextStyle(
                      // RESPONSIVE: Clamp old-price font size
                      fontSize: clampDouble(refWidth * 0.05, 14, 24),
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                SizedBox(width: refWidth * 0.04),
                Text(
                  newPrice,
                  style: TextStyle(
                    color: Colors.green,
                    // RESPONSIVE: Clamp new-price font — raw * 0.085 on a wide
                    // screen caused the price to overflow its row container
                    fontSize: clampDouble(refWidth * 0.085, 22, 42),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.018),

            /// DETAILS + BUTTON ROW
            Row(
              children: [
                Expanded(
                  child: Text(
                    "+ About\n+ offers",
                    style: TextStyle(
                      // RESPONSIVE: Clamp detail text font size
                      fontSize: clampDouble(refWidth * 0.045, 13, 22),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                /// BOOK BUTTON
                InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("$title Selected")),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: refWidth * 0.065,
                      vertical: screenHeight * 0.018,
                    ),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF4BCF56),
                          Color(0xFF7CFF72),
                        ],
                      ),
                    ),
                    child: Text(
                      "Book\nnow",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        // RESPONSIVE: Clamp button label font size
                        fontSize: clampDouble(refWidth * 0.045, 13, 22),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
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
    final screenHeight = MediaQuery.of(context).size.height;

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
            // RESPONSIVE: Clamp nav icon size — screenWidth * 0.08 on a 900px
            // tablet = 72px icons, making the nav bar excessively tall
            size: clampDouble(screenWidth * 0.08, 22, 36),
          ),
          SizedBox(height: screenHeight * 0.005),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.white,
              // RESPONSIVE: Clamp nav label font size — prevents oversized
              // labels on wide screens that wrap and break the nav bar height
              fontSize: clampDouble(screenWidth * 0.033, 9, 14),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}