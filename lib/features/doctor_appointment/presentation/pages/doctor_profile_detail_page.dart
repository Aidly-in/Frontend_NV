import 'package:flutter/material.dart';
import 'package:flutter_aidly/features/payment/presentation/pages/checkout_page.dart';

void main() {
  runApp(const MyApp());
}

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
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double effectiveWidth =
            constraints.maxWidth.clamp(280.0, 600.0);

            final double hPadding =
            (screenWidth * 0.05).clamp(12.0, 28.0);
            final double vPadding =
            (screenHeight * 0.02).clamp(10.0, 24.0);

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
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
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
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
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
                                SizedBox(height: vSpaceTiny),
                                Text(
                                  widget.experience,
                                  style: TextStyle(
                                    fontSize: effectiveWidth * 0.042,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                SizedBox(height: vSpaceTiny),
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
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CheckoutPage(),
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

  Widget specialityButton(
      String text,
      bool selected,
      BuildContext context,
      double effectiveWidth,
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
