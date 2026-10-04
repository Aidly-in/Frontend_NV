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
      home: DoctorProfileScreen(
        name: "Dr. Alen Morgan",
        speciality: "Cardiologist",
        price: 500,
      ),
    );
  }
}

class DoctorProfileScreen extends StatefulWidget {
  final String name;
  final String speciality;
  final int price;

  const DoctorProfileScreen({
    super.key,
    required this.name,
    required this.speciality,
    required this.price,
  });

  @override
  State<DoctorProfileScreen> createState() =>
      _DoctorProfileScreenState();
}

class _DoctorProfileScreenState
    extends State<DoctorProfileScreen> {

  String selectedShift = "Morning";
  int selectedTimeIndex = 0;

  bool isCardiologistSelected = true;
  bool isHeartSelected = false;

  DateTime selectedDate = DateTime.now();
  DateTime currentMonth = DateTime.now();

  final List<String> times = [
    "09-10 AM",
    "10-11 AM",
    "11-12 PM"
  ];

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFE8FFF6),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {

            final double effectiveWidth =
            constraints.maxWidth.clamp(280.0, 600.0);

            final double outerPadding =
            (width * 0.04).clamp(12.0, 24.0);

            final double vSpaceLarge =
            (height * 0.03).clamp(10.0, 28.0);

            final double vSpaceMedium =
            (height * 0.025).clamp(8.0, 22.0);

            final double vSpaceSmall =
            (height * 0.01).clamp(6.0, 14.0);

            final double vSpaceTiny =
            (height * 0.008).clamp(4.0, 10.0);

            return Padding(
              padding: EdgeInsets.all(outerPadding),

              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [

                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: effectiveWidth * 0.06,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),

                        Expanded(
                          child: Center(
                            child: Text(
                              "Doctor Profile",
                              style: TextStyle(
                                fontSize: effectiveWidth * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: effectiveWidth * 0.12),
                      ],
                    ),

                    SizedBox(height: vSpaceLarge),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            "https://i.pravatar.cc/150?img=3",
                            height: effectiveWidth * 0.22,
                            width: effectiveWidth * 0.22,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: effectiveWidth * 0.22,
                                width: effectiveWidth * 0.22,
                                decoration: BoxDecoration(
                                  color: Colors.teal.shade100,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Icon(
                                  Icons.person,
                                  size: effectiveWidth * 0.12,
                                  color: Colors.teal,
                                ),
                              );
                            },
                          ),
                        ),

                        SizedBox(width: effectiveWidth * 0.05),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                widget.name,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: effectiveWidth * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              SizedBox(height: vSpaceTiny),

                              Text(
                                widget.speciality,
                                style: TextStyle(
                                  fontSize: effectiveWidth * 0.038,
                                ),
                              ),

                              SizedBox(height: vSpaceTiny),

                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: effectiveWidth * 0.045,
                                  ),
                                  SizedBox(width: effectiveWidth * 0.01),
                                  Text(
                                    "₹${widget.price}",
                                    style: TextStyle(
                                      fontSize: effectiveWidth * 0.032,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: vSpaceMedium),

                    Wrap(
                      spacing: effectiveWidth * 0.03,
                      runSpacing: 10,
                      children: [
                        _specialButton("Cardiologist", isCardiologistSelected, effectiveWidth),
                        _specialButton("Heart Specialist", isHeartSelected, effectiveWidth),
                      ],
                    ),

                    SizedBox(height: vSpaceMedium),

                    Text(
                      "About Dr. Alen Morgan",
                      style: TextStyle(
                        fontSize: effectiveWidth * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: vSpaceSmall),

                    Text(
                      "Dr. Alen Morgan is a compassionate "
                          "Cardiologist with 12 years of "
                          "experience in treating heart "
                          "and vascular conditions.",
                      style: TextStyle(
                        fontSize: effectiveWidth * 0.034,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),

                    SizedBox(height: vSpaceLarge),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          "Schedule",
                          style: TextStyle(
                            fontSize: effectiveWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        InkWell(
                          onTap: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: currentMonth,
                              firstDate: DateTime(2023),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) {
                              setState(() {
                                currentMonth = DateTime(picked.year, picked.month);
                                selectedDate = picked;
                              });
                            }
                          },
                          child: Row(
                            children: [
                              Text(
                                "${_monthName(currentMonth.month)} ${currentMonth.year}",
                                style: TextStyle(
                                  fontSize: effectiveWidth * 0.032,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: effectiveWidth * 0.01),
                              Icon(
                                Icons.keyboard_arrow_down,
                                size: effectiveWidth * 0.05,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: vSpaceMedium),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          _daysInMonth(currentMonth),
                              (index) => _dateButton(index + 1, effectiveWidth),
                        ),
                      ),
                    ),

                    SizedBox(height: vSpaceLarge),

                    Text(
                      "Choose shifts",
                      style: TextStyle(
                        fontSize: effectiveWidth * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: vSpaceMedium),

                    Wrap(
                      spacing: effectiveWidth * 0.04,
                      runSpacing: 10,
                      children: [
                        _shiftButton("Morning", effectiveWidth),
                        _shiftButton("Evening", effectiveWidth),
                      ],
                    ),

                    SizedBox(height: vSpaceLarge),

                    Text(
                      "Timings",
                      style: TextStyle(
                        fontSize: effectiveWidth * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: vSpaceMedium),

                    Wrap(
                      spacing: effectiveWidth * 0.03,
                      runSpacing: 10,
                      children: List.generate(
                        times.length,
                            (index) => _timeButton(index, effectiveWidth),
                      ),
                    ),

                    SizedBox(height: (height * 0.05).clamp(16.0, 48.0)),

                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
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
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: effectiveWidth * 0.045,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _specialButton(String text, bool selected, double width) {
    return InkWell(
      onTap: () {
        setState(() {
          isCardiologistSelected = text == "Cardiologist";
          isHeartSelected = text == "Heart Specialist";
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.06,
          vertical: width * 0.025,
        ),
        decoration: BoxDecoration(
          color: selected ? Colors.teal : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.teal),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: width * 0.032,
            color: selected ? Colors.white : Colors.teal,
          ),
        ),
      ),
    );
  }

  Widget _dateButton(int day, double width) {
    bool isSelected = selectedDate.day == day &&
        selectedDate.month == currentMonth.month &&
        selectedDate.year == currentMonth.year;

    return InkWell(
      onTap: () {
        setState(() {
          selectedDate = DateTime(
            currentMonth.year,
            currentMonth.month,
            day,
          );
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: width * 0.02),
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.045,
          vertical: width * 0.035,
        ),
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.teal),
        ),
        child: Text(
          "$day",
          style: TextStyle(
            fontSize: width * 0.032,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _shiftButton(String shift, double width) {
    final bool selected = selectedShift == shift;
    return InkWell(
      onTap: () {
        setState(() {
          selectedShift = shift;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.12,
          vertical: width * 0.03,
        ),
        decoration: BoxDecoration(
          color: selected ? Colors.teal : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.teal),
        ),
        child: Text(
          shift,
          style: TextStyle(
            fontSize: width * 0.034,
            color: selected ? Colors.white : Colors.teal,
          ),
        ),
      ),
    );
  }

  Widget _timeButton(int index, double width) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedTimeIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.06,
          vertical: width * 0.025,
        ),
        decoration: BoxDecoration(
          color: selectedTimeIndex == index ? Colors.teal : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.teal),
        ),
        child: Text(
          times[index],
          style: TextStyle(
            fontSize: width * 0.032,
            color: selectedTimeIndex == index ? Colors.white : Colors.teal,
          ),
        ),
      ),
    );
  }

  int _daysInMonth(DateTime date) {
    final firstDayNextMonth = DateTime(date.year, date.month + 1, 1);
    return firstDayNextMonth.subtract(const Duration(days: 1)).day;
  }

  String _monthName(int month) {
    const months = [
      "Jan","Feb","Mar","Apr","May","Jun",
      "Jul","Aug","Sep","Oct","Nov","Dec"
    ];
    return months[month - 1];
  }
}
