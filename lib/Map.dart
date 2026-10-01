import 'package:flutter/material.dart';
import 'package:flutter_aidly/Home.dart';

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

    // MEDIQUERY USED ONLY FOR BOTTOM PADDING (SYSTEM UI SAFE AREA)
    // ALL OTHER SIZING IS HANDLED BY LAYOUTBUILDER BELOW
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: mint,

      body: SafeArea(

        // LAYOUT BUILDER ADDED — DETECTS REAL AVAILABLE SPACE AFTER SAFEAREA
        // THIS ENABLES LANDSCAPE, TABLET, AND SMALL SCREEN ADAPTATION
        // PREVIOUSLY ALL SIZES WERE HARDCODED PIXELS WITH NO ORIENTATION AWARENESS
        child: LayoutBuilder(
          builder: (context, constraints) {

            final double availableWidth = constraints.maxWidth;
            final double availableHeight = constraints.maxHeight;

            // LANDSCAPE DETECTED — WIDTH > HEIGHT MEANS LANDSCAPE ORIENTATION
            // USED TO REDUCE MAP HEIGHT AND OTHER FIXED SIZES IN LANDSCAPE
            final bool isLandscape = availableWidth > availableHeight;

            // TABLET DETECTED — WIDER SCREENS GET MORE COMFORTABLE PADDING
            final bool isTablet = availableWidth > 600;

            // RESPONSIVE SCROLL PADDING — TABLETS GET MORE HORIZONTAL SPACE
            // PREVIOUSLY FIXED EdgeInsets.all(12) FOR ALL SCREEN SIZES
            final double horizontalPadding = isTablet
                ? availableWidth * 0.06
                : availableWidth * 0.03;

            final double verticalPadding = 12.0;

            // RESPONSIVE MAP HEIGHT — LARGEST FIXED VALUE, MOST IMPACTFUL IN LANDSCAPE
            // PREVIOUSLY HARDCODED 260px — IN LANDSCAPE THIS CONSUMED ALMOST
            // THE ENTIRE AVAILABLE HEIGHT LEAVING NO ROOM FOR CONTENT BELOW
            final double mapHeight = isLandscape
                ? availableHeight * 0.38
                : (isTablet
                ? availableHeight * 0.32
                : availableHeight * 0.30);

            // RESPONSIVE SEARCH BUTTON HEIGHT — REPLACES FIXED 46px
            // ON VERY SMALL LANDSCAPE SCREENS 46px WAS DISPROPORTIONATE
            final double searchButtonHeight = isLandscape
                ? availableHeight * 0.10
                : 46.0;

            // RESPONSIVE PRICE+CONFIRM STACK HEIGHT — REPLACES FIXED 100px
            // 100px FIXED CAUSED CLIPPING ON SMALL SCREENS AND WAS OVERSIZED ON TABLETS
            final double priceConfirmHeight = isLandscape
                ? availableHeight * 0.22
                : (isTablet ? 120.0 : 100.0);

            // RESPONSIVE BOTTOM SPACER — REPLACES HARDCODED 70px
            // 70px WAS NOT ACCOUNTING FOR VARYING BOTTOM NAV BAR HEIGHTS
            final double bottomSpacerHeight = bottomPadding + (isLandscape ? 60 : 70);

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                // RESPONSIVE PADDING — REPLACES FIXED EdgeInsets.all(12)
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  /// MAP
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Stack(
                      children: [

                        Container(
                          // RESPONSIVE MAP HEIGHT — REPLACES HARDCODED 260
                          // 260px IN LANDSCAPE WAS CONSUMING MOST AVAILABLE HEIGHT
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
                          // CENTERED VERTICALLY IN THE MAP CONTAINER
                          // PREVIOUSLY HARDCODED top: 110 WHICH BROKE IN LANDSCAPE
                          // NOW CALCULATED AS HALF MAP HEIGHT MINUS HALF ICON SIZE
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

                  /// SEARCH BOX — UNCHANGED, WORKS CORRECTLY ACROSS ALL SIZES
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

                  /// SEARCH BUTTON
                  SizedBox(
                    // RESPONSIVE HEIGHT — REPLACES FIXED 46px
                    // LANDSCAPE PE SCREEN HEIGHT RELATIVE SIZING DETA HAI
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

                  /// BOOKING CARD
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

                        _TitleRow(title: "Hospital Ambulance Booking"),

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

                        /// PRICE + CONFIRM BUTTON SECTION
                        /// REPLACED FIXED-HEIGHT Stack WITH A Column
                        /// PREVIOUSLY SizedBox(height: 100) WITH Positioned BUTTONS
                        /// CAUSED CLIPPING ON SMALL SCREENS AND OVERLAP IN LANDSCAPE
                        /// Column NATURALLY SIZES TO ITS CONTENT — NO OVERFLOW RISK
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [

                            // PRICE BUTTON — WAS Positioned(top: 0) INSIDE FIXED Stack
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

                            // CONFIRM BUTTON — WAS Positioned(bottom: 0) INSIDE FIXED Stack
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

                  // RESPONSIVE BOTTOM SPACER — REPLACES HARDCODED + 70
                  // ENSURES CONTENT CLEARS THE BOTTOM NAVIGATION BAR ON ALL DEVICES
                  SizedBox(height: bottomSpacerHeight),
                ],
              ),
            );
          },
        ),
      ),

      /// BOTTOM NAVIGATION — UNCHANGED, WORKS CORRECTLY
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

        // FLEXIBLE ADDED — PREVENTS TITLE TEXT FROM OVERFLOWING ON NARROW SCREENS
        // PREVIOUSLY BARE Text WITH NO CONSTRAINT COULD CAUSE RENDERFLEX OVERFLOW
        // ON SMALL PHONES OR WHEN FONT SCALING IS HIGH
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