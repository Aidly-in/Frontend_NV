import 'package:flutter/material.dart';
import 'package:flutter_aidly/features/doctor_appointment/presentation/pages/doctor_review_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppointmentBookedScreen(),
    );
  }
}

class AnimatedSuccessIcon extends StatefulWidget {
  final double size;
  const AnimatedSuccessIcon({super.key, this.size = 80});

  @override
  State<AnimatedSuccessIcon> createState() => _AnimatedSuccessIconState();
}

class _AnimatedSuccessIconState extends State<AnimatedSuccessIcon>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Icon(
        Icons.check_circle,
        color: Colors.teal,
        size: widget.size,
      ),
    );
  }
}

class AppointmentBookedScreen extends StatefulWidget {
  const AppointmentBookedScreen({super.key});

  @override
  State<AppointmentBookedScreen> createState() =>
      _AppointmentBookedScreenState();
}

class _AppointmentBookedScreenState
    extends State<AppointmentBookedScreen> {

  String selectedAction = "";

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final double iconSize = isLandscape
        ? screenHeight * 0.18
        : (screenHeight < 600 ? 60.0 : 80.0);

    final double iconContainerSize = iconSize * 1.5;

    final double topSpacing = isLandscape
        ? screenHeight * 0.04
        : (screenHeight < 600 ? 30.0 : 80.0);

    final double sectionGap = isLandscape
        ? screenHeight * 0.03
        : (screenHeight < 600 ? 20.0 : 35.0);

    final double cardHorizontalPad = screenWidth * 0.08;
    final double cardVerticalPad = isLandscape ? 16.0 : 28.0;

    final double buttonHeight = screenHeight < 600 ? 48.0 : 55.0;

    final double preButtonGap = isLandscape
        ? screenHeight * 0.03
        : (screenHeight < 600 ? 25.0 : 45.0);

    return Scaffold(
      backgroundColor: const Color(0xFFE8FFF6),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double maxContentWidth =
            constraints.maxWidth > 600 ? 520.0 : double.infinity;

            return Center(
              child: SizedBox(
                width: maxContentWidth,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: isLandscape ? 8 : 0,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: topSpacing),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: iconContainerSize,
                            width: iconContainerSize,
                            decoration: BoxDecoration(
                              color: Colors.teal.withOpacity(0.15),
                              shape: BoxShape.circle,
                            ),
                          ),
                          AnimatedSuccessIcon(size: iconSize),
                        ],
                      ),
                      SizedBox(height: sectionGap),
                      const Text(
                        "Appointment Booked!",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: sectionGap),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: cardHorizontalPad,
                          vertical: cardVerticalPad,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              color: Colors.grey.shade200,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Column(
                          children: [
                            Text(
                              "Dr. Ema Watson",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 9),
                            Text(
                              "12 March 2026  •  5:30 PM",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 25),
                            Text(
                              "City Care Clinic",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "Bhopal",
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 25),
                            Text(
                              "Appointment ID : AID_20391",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: preButtonGap),
                      SizedBox(
                        width: double.infinity,
                        height: buttonHeight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedAction == "calendar"
                                ? Colors.teal
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              selectedAction = "calendar";
                            });
                          },
                          child: Text(
                            "Add to Calendar",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: selectedAction == "calendar"
                                  ? Colors.white
                                  : Colors.teal,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        height: buttonHeight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedAction == "later"
                                ? Colors.teal
                                : Colors.white,
                            side: const BorderSide(
                                color: Colors.transparent),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const HearAboutUsScreen(),
                              ),
                            );
                            setState(() {
                              selectedAction = "later";
                            });
                          },
                          child: Text(
                            "Maybe later",
                            style: TextStyle(
                              fontSize: 16,
                              color: selectedAction == "later"
                                  ? Colors.white
                                  : Colors.teal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
