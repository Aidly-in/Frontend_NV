import 'package:flutter/material.dart';
import 'package:flutter_aidly/AppointBooked.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BookingLoadingScreen(),
    );
  }
}

class BookingLoadingScreen extends StatefulWidget {
  const BookingLoadingScreen({super.key});

  @override
  State<BookingLoadingScreen> createState() => _BookingLoadingScreenState();
}

class _BookingLoadingScreenState extends State<BookingLoadingScreen> {

  @override
  void initState() {
    super.initState();

    /// 3 seconds baad next page open hoga
    Future.delayed(const Duration(seconds: 3), () {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AppointmentBookedScreen(),
        ),
      );

    });
  }

  @override
  Widget build(BuildContext context) {
    // RESPONSIVE: Read orientation so vertical spacing shrinks in landscape
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    // RESPONSIVE: Read screen height to scale spacing and indicator size
    final screenHeight = MediaQuery.of(context).size.height;

    // RESPONSIVE: Indicator box shrinks on compact / landscape screens
    // to prevent the column from overflowing available vertical space
    final double indicatorSize = isLandscape
        ? screenHeight * 0.22
        : (screenHeight < 600 ? 55.0 : 70.0);

    // RESPONSIVE: Gap between indicator and text shrinks in landscape / small screens
    final double gapHeight = isLandscape
        ? screenHeight * 0.04
        : (screenHeight < 600 ? 18.0 : 30.0);

    return Scaffold(
      backgroundColor: const Color(0xFFE8FFF6),

      // RESPONSIVE: SafeArea added to protect layout from notch / status bar
      // on all device types (phones, tablets, foldables, desktop emulators)
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              // RESPONSIVE: SingleChildScrollView wrapping the Center content
              // prevents RenderFlex overflow when vertical space is constrained
              // (landscape mode, small phones, foldables in compact posture)
              child: SingleChildScrollView(
                // RESPONSIVE: AlwaysScrollableScrollPhysics ensures scroll
                // is available even when content barely fits the viewport
                physics: const AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  // RESPONSIVE: Minimum height = full available height so the
                  // column stays truly centered when content is shorter than screen
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Center(
                    // RESPONSIVE: Cap content width on tablets and desktops
                    // so the text and indicator don't stretch across wide screens
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 480),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          /// LOADING INDICATOR
                          // RESPONSIVE: Replaced fixed 70x70 SizedBox with
                          // a dynamically computed indicatorSize so it scales
                          // correctly across small phones, tablets, and landscape
                          SizedBox(
                            height: indicatorSize,
                            width: indicatorSize,
                            child: const CircularProgressIndicator(
                              strokeWidth: 6,
                              valueColor:
                              AlwaysStoppedAnimation(Colors.teal),
                            ),
                          ),

                          // RESPONSIVE: Replaced fixed SizedBox(height:30)
                          // with a computed gap that shrinks in landscape mode
                          SizedBox(height: gapHeight),

                          /// MAIN TEXT — design/content unchanged
                          const Text(
                            "We are booking"
                                "\n   your appointment...",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 10),

                          /// SUB TEXT — design/content unchanged
                          const Text(
                            "This could take a few seconds",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black38,
                            ),
                          ),
                        ],
                      ),
                    ),
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