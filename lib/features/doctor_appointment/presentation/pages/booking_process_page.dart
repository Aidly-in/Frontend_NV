import 'package:flutter/material.dart';
import 'package:flutter_aidly/features/doctor_appointment/presentation/pages/appointment_booked_page.dart';

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

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AppointmentBookedScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final screenHeight = MediaQuery.of(context).size.height;

    final double indicatorSize = isLandscape
        ? screenHeight * 0.22
        : (screenHeight < 600 ? 55.0 : 70.0);

    final double gapHeight = isLandscape
        ? screenHeight * 0.04
        : (screenHeight < 600 ? 18.0 : 30.0);

    return Scaffold(
      backgroundColor: const Color(0xFFE8FFF6),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 480),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: indicatorSize,
                            width: indicatorSize,
                            child: const CircularProgressIndicator(
                              strokeWidth: 6,
                              valueColor:
                              AlwaysStoppedAnimation(Colors.teal),
                            ),
                          ),
                          SizedBox(height: gapHeight),
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
