import 'package:flutter/material.dart';
import 'package:flutter_aidly/features/home/presentation/pages/home_page.dart';
import 'dart:ui';

void main() {
  runApp(const MyApp());
}

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

    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final double headerVerticalPadding = isLandscape
        ? clampDouble(screenHeight * 0.03, 10, 24)
        : clampDouble(screenHeight * 0.05, 20, 60);

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
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 640),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
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
                                fontSize: headerFontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.025),

                        planCard(
                          context: context,
                          title: "7 days trial",
                          oldPrice: "",
                          newPrice: "Free",
                          showOldPrice: false,
                        ),

                        SizedBox(height: screenHeight * 0.018),

                        planCard(
                          context: context,
                          title: "15 days plan",
                          oldPrice: "₹299",
                          newPrice: "₹199",
                          showOldPrice: true,
                        ),

                        SizedBox(height: screenHeight * 0.018),

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

  Widget planCard({
    required BuildContext context,
    required String title,
    required String oldPrice,
    required String newPrice,
    required bool showOldPrice,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: clampDouble(refWidth * 0.07, 18, 32),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.012),

            Container(height: 1, color: Colors.black54),

            SizedBox(height: screenHeight * 0.012),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (showOldPrice)
                  Text(
                    oldPrice,
                    style: TextStyle(
                      fontSize: clampDouble(refWidth * 0.05, 14, 24),
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                SizedBox(width: refWidth * 0.04),
                Text(
                  newPrice,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: clampDouble(refWidth * 0.085, 22, 42),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.018),

            Row(
              children: [
                Expanded(
                  child: Text(
                    "+ About\n+ offers",
                    style: TextStyle(
                      fontSize: clampDouble(refWidth * 0.045, 13, 22),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

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
            size: clampDouble(screenWidth * 0.08, 22, 36),
          ),
          SizedBox(height: screenHeight * 0.005),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.white,
              fontSize: clampDouble(screenWidth * 0.033, 9, 14),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
