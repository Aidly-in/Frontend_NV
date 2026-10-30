import 'package:flutter/material.dart';
import 'package:flutter_aidly/top_doctors.dart';
import 'package:flutter_aidly/checkout.dart';
import 'package:flutter_aidly/docpayment.dart';
import '../../Payment_Page/presentation/checkout.dart';

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
      home: DoctorPreferenceScreen(
        name: "Dr. Alen Morgan",
        speciality: "MBBS, MD (Medicine), DM (Cardiology)",
        price: 400,
        experience: "12 Years Experience",
        rating: 4.5,
        reviews: 2750,
      ),
    );
  }
}

/// DOCTOR PREFERENCE SCREEN
class DoctorPreferenceScreen extends StatefulWidget {
  final String name;
  final String speciality;
  final int price;
  final String experience;
  final double rating;
  final int reviews;

  const DoctorPreferenceScreen({
    super.key,
    required this.name,
    required this.speciality,
    required this.price,
    required this.experience,
    required this.rating,
    required this.reviews,
  });

  @override
  State<DoctorPreferenceScreen> createState() =>
      _DoctorPreferenceScreenState();
}

class _DoctorPreferenceScreenState
    extends State<DoctorPreferenceScreen> {

  bool cardiologistSelected = true;
  bool heartSelected = false;

  final TextEditingController dateController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFE8FFF6),

      body: SafeArea(
        // LAYOUTBUILDER ADDED TO GET REAL AVAILABLE CONSTRAINTS
        // ENABLES RESPONSIVE BEHAVIOR ON ALL SCREEN SIZES AND ORIENTATIONS
        child: LayoutBuilder(
          builder: (context, constraints) {

            // CAPPED EFFECTIVE WIDTH PREVENTS OVERSIZED FONTS/WIDGETS ON TABLETS
            // AND DESKTOP. clamp ENSURES READABLE LAYOUTS FROM 280px TO 600px.
            final double effectiveWidth =
            constraints.maxWidth.clamp(280.0, 600.0);

            // CLAMPED OUTER PADDING: PREVENTS EXCESSIVE PADDING ON LARGE SCREENS
            // AND TOO-TIGHT PADDING ON VERY SMALL SCREENS
            final double hPadding =
            (screenWidth * 0.05).clamp(12.0, 28.0);
            final double vPadding =
            (screenHeight * 0.02).clamp(10.0, 24.0);

            // CLAMPED VERTICAL SPACERS: PREVENTS COLLAPSE IN LANDSCAPE
            // (WHEN screenHeight IS ~320px) AND OVERFLOW ON SMALL PHONES
            final double vSpaceXL =
            (screenHeight * 0.06).clamp(14.0, 48.0);
            final double vSpaceLarge =
            (screenHeight * 0.045).clamp(12.0, 36.0);
            final double vSpaceMedium =
            (screenHeight * 0.04).clamp(10.0, 32.0);
            final double vSpaceNormal =
            (screenHeight * 0.03).clamp(8.0, 24.0);
            final double vSpaceSmall =
            (screenHeight * 0.018).clamp(6.0, 16.0);
            final double vSpaceTiny =
            (screenHeight * 0.015).clamp(4.0, 14.0);
            final double vSpaceMicro =
            (screenHeight * 0.01).clamp(4.0, 10.0);
            final double vSpaceXS =
            (screenHeight * 0.004).clamp(2.0, 6.0);

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: hPadding,
                  vertical: vPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// HEADER — effectiveWidth USED FOR ICON/FONT SIZING
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            // CAPPED ICON SIZE: PREVENTS OVERFLOW ON SMALL SCREENS
                            size: effectiveWidth * 0.075,
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "Doctor Profile",
                              style: TextStyle(
                                fontSize: effectiveWidth * 0.06,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: effectiveWidth * 0.07),
                      ],
                    ),

                    SizedBox(height: vSpaceNormal),

                    /// DOCTOR CARD
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(effectiveWidth * 0.04),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          /// DOCTOR IMAGE — effectiveWidth USED SO IMAGE DOESN'T
                          /// OVERFLOW ON SMALL SCREENS OR BECOME HUGE ON TABLETS
                          ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: Image.network(
                              "https://images.pexels.com/photos/8460157/pexels-photo-8460157.jpeg",
                              height: effectiveWidth * 0.23,
                              width: effectiveWidth * 0.23,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: effectiveWidth * 0.23,
                                  width: effectiveWidth * 0.23,
                                  color: Colors.grey.shade300,
                                  child: const Icon(Icons.person, size: 40),
                                );
                              },
                            ),
                          ),

                          SizedBox(width: effectiveWidth * 0.04),

                          /// DETAILS
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(
                                  widget.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    // FIX: CAPPED FONT SIZE PREVENTS HUGE TEXT ON
                                    // TABLETS (screenWidth * 0.065 = 42px on 650px tablet)
                                    // effectiveWidth CAPS THIS AT A READABLE MAX SIZE
                                    fontSize: effectiveWidth * 0.055,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                SizedBox(height: vSpaceXS),

                                Text(
                                  widget.speciality,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: effectiveWidth * 0.038,
                                  ),
                                ),

                                SizedBox(height: vSpaceMicro),

                                Text(
                                  widget.experience,
                                  style: TextStyle(
                                    fontSize: effectiveWidth * 0.042,
                                    color: Colors.grey.shade700,
                                  ),
                                ),

                                SizedBox(height: vSpaceMicro),

                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: effectiveWidth * 0.055,
                                    ),
                                    SizedBox(width: effectiveWidth * 0.015),
                                    Expanded(
                                      child: Text(
                                        "${widget.rating} (${widget.reviews} Reviews)",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: effectiveWidth * 0.04,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: vSpaceNormal),

                    /// SPECIALITY BUTTONS — PASSES effectiveWidth FOR CONSISTENT SIZING
                    Row(
                      children: [
                        Expanded(
                          child: specialityButton(
                            "Cardiologist",
                            cardiologistSelected,
                            context,
                            effectiveWidth,
                          ),
                        ),
                        SizedBox(width: effectiveWidth * 0.03),
                        Expanded(
                          child: specialityButton(
                            "Heart Specialist",
                            heartSelected,
                            context,
                            effectiveWidth,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: vSpaceMedium),

                    /// ABOUT DOCTOR
                    Text(
                      "About Dr. Alen Morgan",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: effectiveWidth * 0.055,
                      ),
                    ),

                    SizedBox(height: vSpaceTiny),

                    Text(
                      "Dr. Alen Morgan is a compassionate Cardiologist "
                          "with 12 years of experience in treating heart "
                          "and vascular conditions. He believes in early "
                          "diagnosis, lifestyle-based prevention and "
                          "personalized treatment plans.",
                      style: TextStyle(
                        height: 1.5,
                        fontSize: effectiveWidth * 0.042,
                      ),
                    ),

                    SizedBox(height: vSpaceLarge),

                    /// ADD PREFERENCE
                    Text(
                      "Add Preference",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: effectiveWidth * 0.055,
                      ),
                    ),

                    SizedBox(height: vSpaceSmall),

                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: effectiveWidth * 0.04,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: TextField(
                        controller: dateController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Date & Time",
                          hintStyle: TextStyle(
                            fontSize: effectiveWidth * 0.04,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: vSpaceMedium),

                    /// ADDITIONAL NOTE
                    Text(
                      "Additional Note",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: effectiveWidth * 0.055,
                      ),
                    ),

                    SizedBox(height: vSpaceSmall),

                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: effectiveWidth * 0.04,
                        // CLAMPED VERTICAL PADDING: PREVENTS COLLAPSE IN LANDSCAPE
                        vertical: (screenHeight * 0.018).clamp(8.0, 18.0),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: TextField(
                        controller: noteController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Write additional note",
                          hintStyle: TextStyle(
                            fontSize: effectiveWidth * 0.04,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: vSpaceXL),

                    /// BOOK BUTTON
                    SizedBox(
                      width: double.infinity,

                      // FIX: REPLACED screenHeight * 0.07 WITH FIXED 56px
                      // IN LANDSCAPE screenHeight * 0.07 = ~22px ON PHONES — UNUSABLE
                      // 56px IS THE MATERIAL DESIGN STANDARD FOR PRIMARY ACTION BUTTONS
                      // AND REMAINS COMFORTABLE ON ALL SCREEN SIZES AND ORIENTATIONS
                      height: 56,

                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,

                          // FIX: ADDED foregroundColor — FLUTTER 3.x REQUIRES EXPLICIT
                          // TEXT COLOR ON ElevatedButton OR LABEL MAY RENDER INVISIBLE
                          foregroundColor: Colors.white,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckoutPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Book Appointment",
                          style: TextStyle(
                            fontSize: effectiveWidth * 0.048,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: vSpaceNormal),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// SPECIALITY BUTTON
  /// SIGNATURE UPDATED: ACCEPTS effectiveWidth INSTEAD OF CALLING MediaQuery
  /// DIRECTLY — ENSURES CONSISTENT CLAMPED SIZING ACROSS ALL SCREEN SIZES
  Widget specialityButton(
      String text,
      bool selected,
      BuildContext context,
      double effectiveWidth, // ADDED PARAMETER — REPLACES INTERNAL MediaQuery CALL
      ) {
    return InkWell(
      onTap: () {
        setState(() {
          cardiologistSelected = text == "Cardiologist";
          heartSelected = text == "Heart Specialist";
        });
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          vertical: effectiveWidth * 0.03,
        ),
        decoration: BoxDecoration(
          color: selected ? Colors.teal : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.teal),
        ),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: selected ? Colors.white : Colors.teal,
            fontSize: effectiveWidth * 0.038,
          ),
        ),
      ),
    );
  }
}