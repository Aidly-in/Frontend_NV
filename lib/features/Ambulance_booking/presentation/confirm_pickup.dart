import 'package:flutter/material.dart';
import 'package:flutter_aidly/ambulance_location.dart';
import 'dart:ui';

import 'ambulance_location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PickupMapPage(),
    );
  }
}

class PickupMapPage extends StatefulWidget {
  const PickupMapPage({super.key});

  @override
  State<PickupMapPage> createState() => _PickupMapPageState();
}

class _PickupMapPageState extends State<PickupMapPage> {
  bool isLocationSaved = false;

  final TextEditingController locationController = TextEditingController(
    text: "56\nA block bagsewaniya bhopal......",
  );

  /// FIX: GlobalKey ON THE BOTTOM CARD SO WE CAN MEASURE ITS ACTUAL
  /// RENDERED HEIGHT AND POSITION THE ZOOM BUTTONS ABOVE IT ACCURATELY
  /// INSTEAD OF RELYING ON THE BRITTLE screenHeight * 0.42 ESTIMATE
  final GlobalKey _bottomCardKey = GlobalKey();

  /// FIX: TRACK ACTUAL BOTTOM CARD HEIGHT AFTER FIRST FRAME SO ZOOM
  /// BUTTONS ARE ALWAYS POSITIONED JUST ABOVE THE CARD ON ALL SCREEN SIZES
  double _bottomCardHeight = 0;

  @override
  void initState() {
    super.initState();
    /// FIX: MEASURE THE CARD HEIGHT AFTER THE FIRST FRAME RENDERS
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _measureBottomCard();
    });
  }

  void _measureBottomCard() {
    final ctx = _bottomCardKey.currentContext;
    if (ctx != null) {
      final box = ctx.findRenderObject() as RenderBox?;
      if (box != null && box.hasSize) {
        final height = box.size.height;
        if (_bottomCardHeight != height) {
          setState(() {
            _bottomCardHeight = height;
          });
        }
      }
    }
  }

  @override
  void dispose() {
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final iconSize = screenWidth * 0.07;
    final titleFontSize = screenWidth * 0.062;
    final subtitleFontSize = screenWidth * 0.038;
    final bodyFontSize = screenWidth * 0.045;
    final buttonFontSize = screenWidth * 0.058;
    final avatarRadius = screenWidth * 0.055;
    final cardPadding = screenWidth * 0.045;

    /// FIX: REMOVED bottomCardHeight = screenHeight * 0.42
    /// THAT WAS THE PRIMARY CAUSE OF ALL OVERFLOW AND MISALIGNMENT ISSUES.
    /// THE BOTTOM CARD NOW SIZES ITSELF NATURALLY WITH mainAxisSize.min
    /// AND WE MEASURE ITS ACTUAL HEIGHT VIA GlobalKey FOR ZOOM BUTTON PLACEMENT.

    /// FIX: ZOOM BUTTON BOTTOM OFFSET — USE MEASURED CARD HEIGHT WITH A
    /// SAFE MINIMUM OF 200 SO BUTTONS NEVER OVERLAP THE CARD OR GO OFF-SCREEN
    final zoomButtonBottom =
        (_bottomCardHeight > 0 ? _bottomCardHeight : 200.0) +
            screenHeight * 0.02;

    return Scaffold(
      backgroundColor: Colors.white,

      /// FIX: resizeToAvoidBottomInset TRUE (DEFAULT) ENSURES THE LAYOUT
      /// SHIFTS UP WHEN THE KEYBOARD APPEARS SO TEXTFIELD IS NOT HIDDEN
      resizeToAvoidBottomInset: true,

      body: SafeArea(
        child: Stack(
          children: [
            /// MAP SECTION — full screen
            Positioned.fill(
              child: Container(
                color: const Color(0xFFEAEAEA),
                child: Image.network(
                  "https://upload.wikimedia.org/wikipedia/commons/6/69/OpenStreetMap_Mapnik.png",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),

            /// TOP BACK BUTTON — screen ke top pe
            Positioned(
              top: screenHeight * 0.02,
              left: screenWidth * 0.04,
              child: GestureDetector(
                onTap: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_back,
                        size: iconSize * 0.8, color: Colors.black),
                    SizedBox(width: screenWidth * 0.015),
                  ],
                ),
              ),
            ),

            /// ZOOM BUTTONS — map ke right side pe
            /// FIX: NOW USES MEASURED _bottomCardHeight INSTEAD OF THE
            /// HARDCODED screenHeight * 0.42 ESTIMATE — ZOOM BUTTONS STAY
            /// CORRECTLY ABOVE THE BOTTOM CARD ON ALL SCREEN SIZES AND ORIENTATIONS
            Positioned(
              right: screenWidth * 0.04,
              bottom: zoomButtonBottom,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _mapButton(Icons.zoom_in, avatarRadius),
                  /// FIX: REPLACED screenHeight * 0.015 WITH STABLE FIXED VALUE
                  /// TO PREVENT SPACING BETWEEN ZOOM BUTTONS FROM COLLAPSING IN LANDSCAPE
                  const SizedBox(height: 12),
                  _mapButton(Icons.zoom_out, avatarRadius),
                ],
              ),
            ),

            /// BOTTOM CARD
            /// FIX: ATTACHED GlobalKey SO WE CAN MEASURE THE CARD'S ACTUAL
            /// RENDERED HEIGHT FOR ACCURATE ZOOM BUTTON POSITIONING
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                key: _bottomCardKey,
                width: double.infinity,

                /// FIX: REMOVED FIXED bottomCardHeight CONSTRAINT.
                /// THE CARD NOW USES mainAxisSize.min (ALREADY SET) AND A
                /// SingleChildScrollView SO IT ADAPTS TO AVAILABLE HEIGHT
                /// WITHOUT OVERFLOWING ON SMALL SCREENS OR IN LANDSCAPE MODE.
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),

                /// FIX: WRAPPED CARD CONTENT IN SingleChildScrollView SO THAT
                /// ON SMALL PHONES AND IN LANDSCAPE MODE (WHERE screenHeight IS ~360px)
                /// THE CARD CONTENT CAN SCROLL INSTEAD OF CLIPPING OR OVERFLOWING
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Padding(
                    padding: EdgeInsets.all(cardPadding),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        /// PICKUP TITLE ROW
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: const Color(0xFF2FC3B4),
                              size: iconSize * 1.1,
                            ),
                            SizedBox(width: screenWidth * 0.025),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Check your pickup point",
                                    style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  /// FIX: REPLACED screenHeight * 0.004 WITH STABLE
                                  /// FIXED VALUE — PREVENTS COLLAPSE IN LANDSCAPE
                                  const SizedBox(height: 4),
                                  Text(
                                    "Select a nearby point for easier pickup",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: subtitleFontSize,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        /// FIX: REPLACED screenHeight * 0.022 WITH STABLE FIXED VALUE
                        const SizedBox(height: 16),

                        /// LOCATION FIELD
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04,
                            /// FIX: REPLACED screenHeight * 0.005 (≈1.8px IN LANDSCAPE)
                            /// WITH STABLE FIXED VALUE SO TEXTFIELD IS ALWAYS USABLE
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFF2FC3B4),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: TextField(
                            controller: locationController,
                            maxLines: 2,
                            style: TextStyle(fontSize: bodyFontSize),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),

                        /// FIX: REPLACED screenHeight * 0.018 WITH STABLE FIXED VALUE
                        const SizedBox(height: 14),

                        /// SAVE LOCATION BUTTON
                        InkWell(
                          onTap: () {
                            setState(() {
                              isLocationSaved = !isLocationSaved;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Location Saved")),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.04,
                              /// FIX: REPLACED screenHeight * 0.012 WITH STABLE FIXED VALUE
                              /// PREVENTS BUTTON FROM BECOMING INVISIBLE IN LANDSCAPE
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2FC3B4),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.bookmark,
                                  color: isLocationSaved
                                      ? Colors.black
                                      : Colors.white,
                                  size: iconSize * 0.8,
                                ),
                                SizedBox(width: screenWidth * 0.025),
                                Text(
                                  "Save location",
                                  style: TextStyle(
                                    color: isLocationSaved
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: bodyFontSize,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        /// FIX: REPLACED screenHeight * 0.022 WITH STABLE FIXED VALUE
                        const SizedBox(height: 16),

                        /// CONFIRM PICKUP BUTTON
                        SizedBox(
                          width: double.infinity,
                          /// FIX: REPLACED screenHeight * 0.072 WITH clampDouble
                          /// screenHeight * 0.072 IN LANDSCAPE ≈ 26px — FAR TOO SMALL
                          /// clampDouble ENSURES BUTTON IS ALWAYS AT LEAST 48px (MATERIAL
                          /// MINIMUM TAP TARGET) AND AT MOST 72px ON VERY TALL SCREENS
                          height: clampDouble(
                            screenHeight * 0.80, 48, 72,),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AmbulanceBookingScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF49C9BB),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              "Confirm Pickup",
                              style: TextStyle(
                                fontSize: buttonFontSize,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        /// FIX: REPLACED screenHeight * 0.012 WITH STABLE FIXED VALUE
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// MAP BUTTON — responsive size
  Widget _mapButton(IconData icon, double avatarRadius) {
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("$icon clicked")),
        );
      },
      child: Container(
        height: avatarRadius * 2,
        width: avatarRadius * 2,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: Colors.black,
          size: screenWidth * 0.06,
        ),
      ),
    );
  }
}