import 'package:flutter/material.dart';
import 'package:flutter_aidly/features/payment/presentation/pages/payment_page.dart';
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
      home: CheckoutPage(),
    );
  }
}

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  String selectedPayment = "BHIM";
  bool showPaymentOptions = false;

  double dragPosition = 0;
  bool paymentDone = false;

  int subtotal = 2400;
  int couponDiscount = 945;
  int finalPay = 2000;
  int savedAmount = 0;
  bool showSavedBanner = true;

  String pickupLocation = "Ayodhya ByPass Road, Bhopal";
  String dropLocation = "People's Mall, Bhopal";

  @override
  void initState() {
    super.initState();
    savedAmount = subtotal - finalPay;
    Future.delayed(
      const Duration(seconds: 3),
          () {
        if (mounted) {
          setState(() {
            showSavedBanner = false;
          });
        }
      },
    );
  }

  Future<void> pickDateTime() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime,
      );
      if (pickedTime != null) {
        setState(() {
          selectedDate = pickedDate;
          selectedTime = pickedTime;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final double refWidth = screenWidth.clamp(0.0, 600.0);

    final double slideTrackHeight =
    clampDouble(screenHeight * 0.085, 56, 72);

    final double thumbSize = slideTrackHeight * 0.78;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F3),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.045,
            vertical: screenHeight * 0.015,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Padding(
                      padding: EdgeInsets.all(screenWidth * 0.02),
                      child: Icon(
                        Icons.arrow_back,
                        size: clampDouble(screenWidth * 0.07, 20, 32),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Text(
                    "Checkout",
                    style: TextStyle(
                      fontSize: clampDouble(screenWidth * 0.085, 24, 38),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                height: showSavedBanner ? screenHeight * 0.06 : 0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFDDF4EE),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  "₹$savedAmount Saved!",
                  style: TextStyle(
                    color: const Color(0xFF2DBE9D),
                    fontWeight: FontWeight.bold,
                    fontSize: clampDouble(screenWidth * 0.055, 16, 26),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.025),
              Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(refWidth * 0.045),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Trip Date & Time",
                                      style: TextStyle(
                                        fontSize: clampDouble(
                                            refWidth * 0.055, 15, 24),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: pickDateTime,
                                      child: Text(
                                        "Change >",
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: clampDouble(
                                              refWidth * 0.038, 12, 18),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: screenHeight * 0.022),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_month,
                                      size: clampDouble(
                                          refWidth * 0.09, 24, 40),
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: refWidth * 0.03),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                                          style: TextStyle(
                                            fontSize: clampDouble(
                                                refWidth * 0.05, 14, 22),
                                          ),
                                        ),
                                        Text(
                                          selectedTime.format(context),
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: clampDouble(
                                                refWidth * 0.038, 12, 18),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: screenHeight * 0.03),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Pickup & Return",
                                      style: TextStyle(
                                        fontSize: clampDouble(
                                            refWidth * 0.055, 15, 24),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                "Pickup change clickable"),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Change >",
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: clampDouble(
                                              refWidth * 0.038, 12, 18),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: screenHeight * 0.022),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: clampDouble(
                                          refWidth * 0.05, 18, 28),
                                      backgroundColor: Colors.grey,
                                      child: Icon(
                                        Icons.location_on,
                                        color: Colors.white,
                                        size: clampDouble(
                                            refWidth * 0.06, 18, 28),
                                      ),
                                    ),
                                    SizedBox(width: refWidth * 0.03),
                                    Expanded(
                                      child: Text(
                                        pickupLocation,
                                        style: TextStyle(
                                          fontSize: clampDouble(
                                              refWidth * 0.042, 13, 20),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.022),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final double trackWidth = constraints.maxWidth;
                              final double dragMax =
                                  trackWidth - thumbSize - 8;
                              final double dragThreshold = dragMax * 0.85;

                              return Container(
                                height: slideTrackHeight,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF3CC7B2),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Text(
                                        paymentDone
                                            ? "Payment Successful"
                                            : "Slide to Pay | ₹2000",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: clampDouble(
                                              refWidth * 0.055, 14, 22),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    AnimatedPositioned(
                                      duration: const Duration(
                                          milliseconds: 100),
                                      left: dragPosition,
                                      top: (slideTrackHeight - thumbSize) / 2,
                                      child: GestureDetector(
                                        onHorizontalDragUpdate: (details) {
                                          setState(() {
                                            dragPosition +=
                                                details.delta.dx;
                                            if (dragPosition < 0) {
                                              dragPosition = 0;
                                            }
                                            if (dragPosition > dragMax) {
                                              dragPosition = dragMax;
                                            }
                                          });
                                        },
                                        onHorizontalDragEnd: (details) {
                                          if (dragPosition > dragThreshold) {
                                            setState(() {
                                              paymentDone = true;
                                            });
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PaymentOptionPage(
                                                      payableAmount:
                                                      finalPay.toString(),
                                                      pickupLocation:
                                                      pickupLocation,
                                                      dropLocation: dropLocation,
                                                    ),
                                              ),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    "Payment Continued"),
                                              ),
                                            );
                                          }
                                          setState(() {
                                            dragPosition = 0;
                                          });
                                        },
                                        child: Container(
                                          height: thumbSize,
                                          width: thumbSize,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.double_arrow,
                                            size: thumbSize * 0.55,
                                            color: const Color(0xFF3CC7B2),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(height: screenHeight * 0.03),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
