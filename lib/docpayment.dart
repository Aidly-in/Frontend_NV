import 'package:flutter/material.dart';
import 'package:flutter_aidly/BookProcess.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // THIS PREVENTS UI GLITCH WHEN KEYBOARD OPENS
      resizeToAvoidBottomInset: true,

      body: SafeArea(
        // LAYOUT BUILDER USED TO GET REAL AVAILABLE CONSTRAINTS
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // PAYMENT CONTENT AREA — UNCHANGED
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "Payment Page",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // EXPANDED PUSHES BUTTON TO BOTTOM — UNCHANGED
                      const Expanded(child: SizedBox()),

                      // CONFIRM BOOKING BUTTON
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,

                          child: ElevatedButton(
                            onPressed: () {
                              // CONFIRM BOOKING LOGIC — UNCHANGED
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookingLoadingScreen(),
                                ),
                              );
                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,

                              // FIX: EXPLICITLY SET FOREGROUND (TEXT/ICON) COLOR TO WHITE
                              // IN FLUTTER 3.x+, WITHOUT foregroundColor, THE BUTTON LABEL
                              // INHERITS AN INVISIBLE OR NEAR-INVISIBLE COLOR FROM THE THEME
                              // THIS MAKES THE "Confirm Booking" TEXT CLEARLY VISIBLE
                              foregroundColor: Colors.white,

                              // ADDED ELEVATION FOR VISUAL DEPTH AND CLEAR TAPPABILITY
                              elevation: 3,

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),

                            child: const Text(
                              "Confirm Booking",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),

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