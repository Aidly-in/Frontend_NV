import 'package:flutter/material.dart';
import 'package:flutter_aidly/features/map/presentation/pages/map_page.dart';
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

  final GlobalKey _bottomCardKey = GlobalKey();
  double _bottomCardHeight = 0;

  @override
  void initState() {
    super.initState();
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

    final zoomButtonBottom =
        (_bottomCardHeight > 0 ? _bottomCardHeight : 200.0) +
            screenHeight * 0.02;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
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
            Positioned(
              right: screenWidth * 0.04,
              bottom: zoomButtonBottom,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _mapButton(Icons.zoom_in, avatarRadius),
                  const SizedBox(height: 12),
                  _mapButton(Icons.zoom_out, avatarRadius),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                key: _bottomCardKey,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Padding(
                    padding: EdgeInsets.all(cardPadding),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        const SizedBox(height: 16),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04,
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
                        const SizedBox(height: 14),
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
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: clampDouble(
                            screenHeight * 0.80, 48, 72,),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                  const AmbulanceBookingScreen(),
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
