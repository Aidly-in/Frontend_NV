import 'package:flutter/material.dart';
import 'package:flutter_aidly/features/home/presentation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

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

class QuickServicesPage extends StatefulWidget {
  const QuickServicesPage({super.key});

  @override
  State<QuickServicesPage> createState() => _QuickServicesPageState();
}

class _QuickServicesPageState extends State<QuickServicesPage> {
  int selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return OrientationBuilder(
      builder: (context, orientation) {
        final isLandscape = orientation == Orientation.landscape;

        return Scaffold(
          backgroundColor: const Color(0xFFDDF1EC),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 720),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
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
                            const SizedBox(height: 20),
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
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
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

  Widget quickServiceCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required bool isLandscape,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.045,
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
