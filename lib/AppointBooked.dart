import 'package:flutter/material.dart';
import 'package:flutter_aidly/Review.dart';

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
  // RESPONSIVE: Accept size parameter so icon scales with screen
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
        // RESPONSIVE: Use dynamic size passed from parent instead of fixed 80
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
    // RESPONSIVE: Capture screen dimensions to drive all adaptive sizing
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // RESPONSIVE: Detect landscape orientation to reduce vertical spacing
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    // RESPONSIVE: Scale the success icon — smaller on compact/landscape screens
    final double iconSize = isLandscape
        ? screenHeight * 0.18
        : (screenHeight < 600 ? 60.0 : 80.0);

    // RESPONSIVE: Scale the icon container circle proportionally with icon
    final double iconContainerSize = iconSize * 1.5;

    // RESPONSIVE: Top spacing — shrink drastically in landscape / small screens
    final double topSpacing = isLandscape
        ? screenHeight * 0.04
        : (screenHeight < 600 ? 30.0 : 80.0);

    // RESPONSIVE: Gap between sections — proportional to screen height
    final double sectionGap = isLandscape
        ? screenHeight * 0.03
        : (screenHeight < 600 ? 20.0 : 35.0);

    // RESPONSIVE: Card inner padding — use screen width % to prevent overflow
    //             OLD: EdgeInsets.all(50) caused horizontal overflow on small phones
    final double cardHorizontalPad = screenWidth * 0.08;
    final double cardVerticalPad = isLandscape ? 16.0 : 28.0;

    // RESPONSIVE: Button height — slightly smaller on compact screens
    final double buttonHeight = screenHeight < 600 ? 48.0 : 55.0;

    // RESPONSIVE: Gap before buttons section
    final double preButtonGap = isLandscape
        ? screenHeight * 0.03
        : (screenHeight < 600 ? 25.0 : 45.0);

    return Scaffold(
      backgroundColor: const Color(0xFFE8FFF6),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // RESPONSIVE: On tablets/desktops, cap content width so it doesn't
            //             stretch across the full wide screen — center it instead
            final double maxContentWidth =
            constraints.maxWidth > 600 ? 520.0 : double.infinity;

            return Center(
              child: SizedBox(
                // RESPONSIVE: Constrain max width for tablet / desktop layouts
                width: maxContentWidth,
                child: SingleChildScrollView(
                  // RESPONSIVE: physics ensures scroll always works — prevents
                  //             overflow errors when content taller than viewport
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    // RESPONSIVE: Reduce bottom padding on landscape
                    vertical: isLandscape ? 8 : 0,
                  ),
                  child: Column(
                    children: [

                      // RESPONSIVE: Replaced fixed SizedBox(height:80) with
                      //             a dynamic value that shrinks on small screens
                      SizedBox(height: topSpacing),

                      /// SUCCESS ICON
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          // RESPONSIVE: Container size now scales with icon
                          Container(
                            height: iconContainerSize,
                            width: iconContainerSize,
                            decoration: BoxDecoration(
                              color: Colors.teal.withOpacity(0.15),
                              shape: BoxShape.circle,
                            ),
                          ),
                          // RESPONSIVE: Pass computed icon size into widget
                          AnimatedSuccessIcon(size: iconSize),
                        ],
                      ),

                      // RESPONSIVE: Dynamic gap
                      SizedBox(height: sectionGap),

                      /// TITLE — unchanged
                      const Text(
                        "Appointment Booked!",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // RESPONSIVE: Dynamic gap
                      SizedBox(height: sectionGap),

                      /// APPOINTMENT CARD
                      Container(
                        width: double.infinity,
                        // RESPONSIVE: Replaced fixed EdgeInsets.all(50) with
                        //             screen-proportional padding — fixes
                        //             horizontal overflow on narrow phones
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
                        // RESPONSIVE: Removed 'const' from Column since padding
                        //             values are now runtime-computed
                        child: Column(
                          children: const [

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

                      // RESPONSIVE: Dynamic gap before buttons
                      SizedBox(height: preButtonGap),

                      /// ADD TO CALENDAR BUTTON
                      SizedBox(
                        width: double.infinity,
                        // RESPONSIVE: Adaptive button height
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

                      /// MAYBE LATER BUTTON
                      SizedBox(
                        width: double.infinity,
                        // RESPONSIVE: Adaptive button height
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
                                    HearAboutUsScreen(),
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

                      // RESPONSIVE: Bottom breathing room so last button
                      //             isn't flush against screen edge
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