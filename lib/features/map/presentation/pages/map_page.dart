import 'package:flutter/material.dart';
import 'package:flutter_aidly/features/home/presentation/pages/home_page.dart';

void main() => runApp(const AidlyApp());

class AidlyApp extends StatelessWidget {
  const AidlyApp({super.key});

  static const Color primary = Color(0xFF0E6B5B);
  static const Color mint = Color(0xFFD4F1ED);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Ambulance Booking",
      theme: ThemeData(
        scaffoldBackgroundColor: mint,
      ),
      home: const AmbulanceBookingScreen(),
    );
  }
}

class AmbulanceBookingScreen extends StatefulWidget {
  const AmbulanceBookingScreen({super.key});

  @override
  State<AmbulanceBookingScreen> createState() =>
      _AmbulanceBookingScreenState();
}

class _AmbulanceBookingScreenState
    extends State<AmbulanceBookingScreen> {

  final _pickupCtrl = TextEditingController();
  final _destCtrl = TextEditingController();

  String _selectedHospital = "St. Mary's General Hospital";
  String _ambulanceType = "Standard EMT";

  int _currentTab = 1;

  @override
  void dispose() {
    _pickupCtrl.dispose();
    _destCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    const primary = AidlyApp.primary;
    const mint = AidlyApp.mint;

    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: mint,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {

            final double availableWidth = constraints.maxWidth;
            final double availableHeight = constraints.maxHeight;

            final bool isLandscape = availableWidth > availableHeight;
            final bool isTablet = availableWidth > 600;

            final double horizontalPadding = isTablet
                ? availableWidth * 0.06
                : availableWidth * 0.03;

            final double verticalPadding = 12.0;

            final double mapHeight = isLandscape
                ? availableHeight * 0.38
                : (isTablet
                ? availableHeight * 0.32
                : availableHeight * 0.30);

            final double searchButtonHeight = isLandscape
                ? availableHeight * 0.10
                : 46.0;

            final double bottomSpacerHeight = bottomPadding + (isLandscape ? 60 : 70);

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Stack(
                      children: [
                        Container(
                          height: mapHeight,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFE6F5F2),
                                Color(0xFFCDEBE6),
                              ],
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.map,
                              size: 70,
                              color: Colors.black26,
                            ),
                          ),
                        ),
                        Positioned(
                          top: mapHeight / 2 - 17,
                          left: 0,
                          right: 0,
                          child: const Icon(
                            Icons.location_on,
                            size: 34,
                            color: primary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: _pickupCtrl,
                          decoration: const InputDecoration(
                            hintText: "Enter pick up location",
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                          ),
                        ),
                        const Divider(height: 1),
                        TextField(
                          controller: _destCtrl,
                          decoration: const InputDecoration(
                            hintText: "Enter destination location",
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),

                  SizedBox(
                    height: searchButtonHeight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Search Ambulance nearby",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 16,
                          offset: Offset(0, 6),
                          color: Color(0x1A000000),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _TitleRow(title: "Hospital Ambulance Booking"),
                        const SizedBox(height: 12),
                        const Text(
                          "Select Hospital",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 6),
                        _DropdownCard<String>(
                          value: _selectedHospital,
                          items: const [
                            "St. Mary's General Hospital",
                            "City Care Hospital",
                            "LifeLine Multispeciality",
                            "Sagar Avenue Clinic"
                          ],
                          onChanged: (v) {
                            if (v != null) {
                              setState(() => _selectedHospital = v);
                            }
                          },
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Type of ambulance",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 6),
                        _DropdownCard<String>(
                          value: _ambulanceType,
                          items: const [
                            "Standard EMT",
                            "ICU ambulance",
                            "Bariatric ambulance",
                            "Neonatal ambulance"
                          ],
                          onChanged: (v) {
                            if (v != null) {
                              setState(() => _ambulanceType = v);
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            OutlinedButton(
                              onPressed: () {},
                              child: const Text(
                                "Book in ₹ 299",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primary,
                              ),
                              onPressed: () {},
                              child: const Text(
                                "Confirm booking",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: bottomSpacerHeight),
                ],
              ),
            );
          },
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab,
        onTap: (i) {
          setState(() => _currentTab = i);

          if (i == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MergedHomePage(),
              ),
            );
          }
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: AidlyApp.primary,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.emergency), label: "Ambulance"),
          BottomNavigationBarItem(icon: Icon(Icons.health_and_safety), label: "Health care"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: "My order"),
        ],
      ),
    );
  }
}

class _TitleRow extends StatelessWidget {
  final String title;

  const _TitleRow({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Spacer(),
        const Icon(Icons.info_outline, size: 16),
      ],
    );
  }
}

class _DropdownCard<T> extends StatelessWidget {
  final T value;
  final List<T> items;
  final ValueChanged<T?> onChanged;

  const _DropdownCard({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12),
        color: const Color(0xFFF7FBFA),
      ),
      child: DropdownButton<T>(
        isExpanded: true,
        value: value,
        underline: const SizedBox(),
        icon: const Icon(Icons.keyboard_arrow_down),
        items: items.map((e) {
          return DropdownMenuItem<T>(
            value: e,
            child: Text(e.toString()),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
