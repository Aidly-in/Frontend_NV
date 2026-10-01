import 'package:flutter/material.dart';
import 'package:flutter_aidly/MedDashboard.dart';
import 'package:flutter_aidly/homecare.dart';
import 'package:flutter_aidly/pickup1.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const AidlyMergedDemo());
}

class AidlyMergedDemo extends StatelessWidget {
  const AidlyMergedDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aidly',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFD4F1ED),
        fontFamily: 'Roboto',
      ),
      home: const MergedHomePage(),
    );
  }
}

class MergedHomePage extends StatefulWidget {
  const MergedHomePage({super.key});

  @override
  State<MergedHomePage> createState() => _MergedHomePageState();
}

class _MergedHomePageState extends State<MergedHomePage> {

  int selectedIndex = 0;
  String? userAddress;

  // THIS VARIABLE STORES USER TAP COUNT
  int tapCount = 0;

  // THIS FUNCTION SHOWS UPDATE PROFILE POPUP
  void showUpdatePopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                // TITLE
                const Text(
                  'UPDATE YOUR PROFILE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                // SUBTITLE
                const Text(
                  'TO AVAIL MORE FEATURES',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 15),

                // SMILE
                const Text(
                  ':)',
                  style: TextStyle(fontSize: 24),
                ),

                const SizedBox(height: 20),

                // UPDATE BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF62D4C8),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'UPDATE NOW',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // LATER BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF62D4C8),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'DO IT LATER',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    /// ================= RESPONSIVE VALUES =================
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final bool isTablet = screenWidth > 600;

    // LANDSCAPE DETECT — ADDED TO ENABLE ORIENTATION-AWARE SIZING
    // PREVIOUSLY NO LANDSCAPE DETECTION EXISTED — ALL VALUES USED FULL screenHeight
    // WHICH CAUSED CARDS AND GAPS TO BE DISPROPORTIONATE IN LANDSCAPE
    final bool isLandscape = screenWidth > screenHeight;

    double scale(double mobile, double tablet) {
      return isTablet ? tablet : mobile;
    }

    const teal = Color(0xFF0E6B5B);

    // RESPONSIVE CARD GAP — REDUCED IN LANDSCAPE TO PREVENT ACCUMULATED OVERFLOW
    // PREVIOUSLY FIXED AT screenHeight * 0.06 FOR ALL THREE INTER-CARD GAPS
    // THREE GAPS OF 0.06 = 0.18 OF SCREEN HEIGHT JUST IN SPACING — TOO MUCH IN LANDSCAPE
    final double cardGap = isLandscape
        ? screenHeight * 0.04
        : screenHeight * 0.06;

    // RESPONSIVE IMAGE OFFSET Y FOR CARD 1 — REDUCED IN LANDSCAPE
    // PREVIOUSLY -screenHeight * 0.09 WHICH PULLED IMAGE TOO FAR OUT IN LANDSCAPE
    final double card1ImageOffsetY = isLandscape
        ? -screenHeight * 0.06
        : -screenHeight * 0.09;

    // RESPONSIVE TESTIMONIAL LIST HEIGHT — REDUCED IN LANDSCAPE
    // PREVIOUSLY FIXED AT screenHeight * 0.18 WHICH WAS OVERSIZED IN LANDSCAPE
    final double testimonialHeight = isLandscape
        ? screenHeight * 0.28
        : screenHeight * 0.18;

    return GestureDetector(

      // THIS DETECTS USER TAPS
      onTap: () {
        // INCREASE TAP COUNT
        tapCount++;

        // SHOW POPUP AFTER 5 TAPS
        if (tapCount == 5) {
          // RESET TAP COUNT
          tapCount = 0;
          // SHOW POPUP
          showUpdatePopup();
        }
      },

      child: Scaffold(

        /// ================= BOTTOM NAV =================
        bottomNavigationBar: SafeArea(
          child: Container(
            color: teal,
            padding: EdgeInsets.symmetric(
              vertical: scale(
                screenHeight * 0.012,
                screenHeight * 0.018,
              ),
              horizontal: scale(
                screenWidth * 0.03,
                screenWidth * 0.05,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                BottomNavItem(
                  icon: Icons.home,
                  label: 'Home',
                  selected: selectedIndex == 0,
                  onTap: () {
                    setState(() { selectedIndex = 0; });
                  },
                ),

                BottomNavItem(
                  icon: Icons.emergency,
                  label: 'Ambulance',
                  selected: selectedIndex == 1,
                  onTap: () {
                    setState(() { selectedIndex = 1; });
                  },
                ),

                BottomNavItem(
                  icon: Icons.health_and_safety,
                  label: 'Health',
                  selected: selectedIndex == 2,
                  onTap: () {
                    setState(() { selectedIndex = 2; });
                  },
                ),

                BottomNavItem(
                  icon: Icons.list_alt,
                  label: 'Orders',
                  selected: selectedIndex == 3,
                  onTap: () {
                    setState(() { selectedIndex = 3; });
                  },
                ),
              ],
            ),
          ),
        ),

        /// ================= BODY =================
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: scale(
                  screenWidth * 0.04,
                  screenWidth * 0.06,
                ),
                vertical: scale(
                  screenHeight * 0.015,
                  screenHeight * 0.025,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// ================= TOP BAR =================
                  Row(
                    children: [

                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.black54,
                        size: scale(
                          screenWidth * 0.06,
                          screenWidth * 0.04,
                        ),
                      ),

                      SizedBox(width: screenWidth * 0.02),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              'Home',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: scale(
                                  screenWidth * 0.045,
                                  screenWidth * 0.03,
                                ),
                              ),
                            ),

                            SizedBox(height: screenHeight * 0.002),

                            Text(
                              userAddress ?? 'Tap profile & add your address',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: scale(
                                  screenWidth * 0.03,
                                  screenWidth * 0.02,
                                ),
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),

                      GestureDetector(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ProfilePage(),
                            ),
                          );
                          if (result != null) {
                            setState(() {
                              userAddress = result;
                            });
                          }
                        },
                        child: CircleAvatar(
                          radius: scale(
                            screenWidth * 0.05,
                            screenWidth * 0.035,
                          ),
                          backgroundColor: teal,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: scale(
                              screenWidth * 0.055,
                              screenWidth * 0.03,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  /// ================= SEARCH =================
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.03,
                      vertical: screenHeight * 0.003,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(screenWidth * 0.035),
                    ),
                    child: Row(
                      children: [

                        Icon(
                          Icons.search,
                          color: Colors.black45,
                          size: screenWidth * 0.06,
                        ),

                        SizedBox(width: screenWidth * 0.02),

                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search services',
                              hintStyle: TextStyle(
                                fontSize: screenWidth * 0.035,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.035),

                  /// ================= CARD 1 =================
                  Center(
                    child: ThreeDImageCard(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      title: 'Ambulance\nBooking',
                      ctaText: 'Book now',
                      gradient: const LinearGradient(
                        colors: [Color(0xFF40916C), Color(0xFF40916C)],
                      ),
                      imagePath: 'assets/images/Ambulance.png',
                      imageWidthFactor: 0.62,
                      imageOffsetX: screenWidth * -0.03,
                      // RESPONSIVE IMAGE OFFSET Y — REDUCED IN LANDSCAPE
                      // PREVIOUSLY -screenHeight * 0.09 WHICH PULLED IMAGE TOO FAR
                      // OUT OF CARD BOUNDS IN LANDSCAPE MODE
                      imageOffsetY: card1ImageOffsetY,
                      buttonOffsetX: 0,
                      buttonOffsetY: screenHeight * 2.0,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PickupMapPage(),
                          ),
                        );
                      },
                    ),
                  ),

                  // RESPONSIVE CARD GAP — REPLACES FIXED screenHeight * 0.06
                  SizedBox(height: cardGap),

                  /// ================= CARD 2 =================
                  Center(
                    child: ThreeDImageCard(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      title: 'Home Care\nServices',
                      ctaText: 'Book now',
                      gradient: const LinearGradient(
                        colors: [Color(0xFF52B788), Color(0xFF52B788)],
                      ),
                      imagePath: 'assets/images/Home_care 3.png',
                      imageWidthFactor: 0.48,
                      imageOffsetX: screenWidth * 0.50,
                      imageOffsetY: -screenHeight * 0.02,
                      textOffsetX: screenWidth * 0.40,
                      buttonOffsetX: screenWidth * 0.42,
                      buttonOffsetY: screenHeight * 2.0,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HomeCarePage(),
                          ),
                        );
                      },
                    ),
                  ),

                  // RESPONSIVE CARD GAP
                  SizedBox(height: cardGap),

                  /// ================= CARD 3 =================
                  Center(
                    child: ThreeDImageCard(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      title: 'Appointment\nWith Doctor',
                      ctaText: 'Book now',
                      gradient: const LinearGradient(
                        colors: [Color(0xFF74C69D), Color(0xFF74C69D)],
                      ),
                      imagePath: 'assets/images/Appointment_2.png',
                      imageWidthFactor: 0.58,
                      imageOffsetX: screenWidth * -0.06,
                      imageOffsetY: -screenHeight * 0.05,
                      buttonOffsetX: 0,
                      buttonOffsetY: screenHeight * 2.0,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HomeScreen(),
                          ),
                        );
                      },
                    ),
                  ),

                  // RESPONSIVE CARD GAP
                  SizedBox(height: cardGap),

                  /// ================= CARD 4 =================
                  Center(
                    child: ThreeDImageCard(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      title: 'Wellness\nStore',
                      ctaText: 'Shop now',
                      gradient: const LinearGradient(
                        colors: [Color(0xFF95D5B2), Color(0xFF95D5B2)],
                      ),
                      imagePath: 'assets/images/medical_store_(3).png',
                      imageWidthFactor: 0.55,
                      imageOffsetX: screenWidth * 0.40,
                      imageOffsetY: -screenHeight * 0.02,
                      textOffsetX: screenWidth * 0.50,
                      buttonOffsetX: screenWidth * 0.48,
                      buttonOffsetY: screenHeight * 2.0,
                      onPressed: () {},
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  /// ================= TESTIMONIAL =================
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE6E6),
                      borderRadius: BorderRadius.circular(screenWidth * 0.04),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          'What our customers have to say',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.042,
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.02),

                        SizedBox(
                          // RESPONSIVE TESTIMONIAL HEIGHT — INCREASED IN LANDSCAPE
                          // BECAUSE screenHeight IS SMALLER IN LANDSCAPE SO 0.18
                          // WOULD BE TOO SQUISHED — 0.28 GIVES MORE VISUAL SPACE
                          height: testimonialHeight,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return Container(
                                width: screenWidth * 0.62,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                    screenWidth * 0.035,
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (_, __) =>
                                SizedBox(width: screenWidth * 0.03),
                            itemCount: 3,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  /// ================= FOOTER =================
                  Center(
                    child: Column(
                      children: [

                        Image.asset(
                          'assets/images/logo.png',
                          width: screenWidth * 0.13,
                          height: screenWidth * 0.13,
                        ),

                        SizedBox(height: screenHeight * 0.01),

                        Text(
                          'More than just\nhealthcare',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: screenWidth * 0.075,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF82CFC6),
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.02),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            SocialCircle(
                              icon: Icons.facebook,
                              screenWidth: screenWidth,
                            ),

                            SizedBox(width: screenWidth * 0.03),

                            SocialCircle(
                              icon: FontAwesomeIcons.instagram,
                              screenWidth: screenWidth,
                            ),

                            SizedBox(width: screenWidth * 0.03),

                            LinkedInCircle(screenWidth: screenWidth),
                          ],
                        ),

                        SizedBox(height: screenHeight * 0.04),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// ================= PROFILE PAGE =================
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E6B5B),
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          children: [

            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your address',
              ),
            ),

            SizedBox(height: screenWidth * 0.05),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, controller.text);
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ================= AMBULANCE BOOKING PAGE =================
class AmbulanceBookingPage extends StatelessWidget {
  const AmbulanceBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E6B5B),
        title: const Text('Ambulance Booking'),
      ),
      body: const Center(
        child: Text(
          'WELCOME TO AMBULANCE BOOKING PAGE',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

/// ================= BOTTOM NAV =================
class BottomNavItem extends StatelessWidget {

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const BottomNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          Icon(
            icon,
            color: Colors.white,
            size: screenWidth * 0.06,
          ),

          SizedBox(height: screenWidth * 0.01),

          Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : Colors.white70,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              fontSize: screenWidth * 0.028,
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= SOCIAL =================
class SocialCircle extends StatelessWidget {

  final IconData icon;
  final double screenWidth;

  const SocialCircle({
    super.key,
    required this.icon,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.11,
      height: screenWidth * 0.11,
      decoration: const BoxDecoration(
        color: Color(0xFF82CFC6),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: screenWidth * 0.05,
      ),
    );
  }
}

class LinkedInCircle extends StatelessWidget {

  final double screenWidth;

  const LinkedInCircle({
    super.key,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.11,
      height: screenWidth * 0.11,
      decoration: const BoxDecoration(
        color: Color(0xFF82CFC6),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          'In',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.04,
          ),
        ),
      ),
    );
  }
}

/// ================= 3D CARD =================
class ThreeDImageCard extends StatefulWidget {

  final double screenWidth;
  final double screenHeight;
  final String title;
  final String ctaText;
  final LinearGradient gradient;
  final String imagePath;
  final double imageWidthFactor;
  final double imageOffsetX;
  final double imageOffsetY;
  final double textOffsetX;

  // ===== BUTTON POSITION PARAMETERS =====
  // buttonOffsetX: MOVES BUTTON LEFT(-) OR RIGHT(+)
  // buttonOffsetY: MOVES BUTTON UP(-) OR DOWN(+)
  final double buttonOffsetX;
  final double buttonOffsetY;
  // =======================================

  /// THIS FUNCTION HANDLES BUTTON CLICK
  final VoidCallback onPressed;

  const ThreeDImageCard({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.title,
    required this.ctaText,
    required this.gradient,
    required this.imagePath,
    required this.imageWidthFactor,
    required this.imageOffsetX,
    required this.imageOffsetY,
    required this.onPressed,
    // ===== BUTTON POSITION DEFAULTS =====
    this.textOffsetX = 0,
    this.buttonOffsetX = 0,
    this.buttonOffsetY = 0,
    // =====================================
  });

  @override
  State<ThreeDImageCard> createState() => _ThreeDImageCardState();
}

class _ThreeDImageCardState extends State<ThreeDImageCard> {

  double tiltX = 0;
  double tiltY = 0;

  @override
  Widget build(BuildContext context) {

    final bool isLandscape = widget.screenWidth > widget.screenHeight;

    final cardWidth = widget.screenWidth * 0.92;

    // RESPONSIVE CARD HEIGHT — LANDSCAPE ME REDUCED TO PREVENT OVERFLOW
    // PREVIOUSLY FIXED AT screenHeight * 0.28 FOR ALL ORIENTATIONS
    // IN LANDSCAPE screenHeight IS MUCH SMALLER SO 0.28 MADE CARDS TOO SQUISHED
    // INCREASED LANDSCAPE FACTOR TO 0.42 SO CARDS REMAIN VISUALLY BALANCED
    final cardHeight = isLandscape
        ? widget.screenHeight * 0.42
        : widget.screenHeight * 0.28;

    return GestureDetector(

      onPanUpdate: (details) {
        final box = context.findRenderObject() as RenderBox;
        final localPosition = box.globalToLocal(details.globalPosition);
        final dx = (localPosition.dx / cardWidth) * 2 - 1;
        final dy = (localPosition.dy / cardHeight) * 2 - 1;
        setState(() {
          tiltX = -dy;
          tiltY = dx;
        });
      },

      onPanEnd: (_) {
        setState(() {
          tiltX = 0;
          tiltY = 0;
        });
      },

      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.002)
          ..rotateX(tiltX * 0.12)
          ..rotateY(tiltY * 0.12),

        child: Stack(
          clipBehavior: Clip.none,
          children: [

            /// ================= CARD =================
            Container(
              width: cardWidth,
              height: cardHeight,
              decoration: BoxDecoration(
                gradient: widget.gradient,
                borderRadius: BorderRadius.circular(widget.screenWidth * 0.05),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: widget.screenWidth * 0.05,
                    offset: Offset(0, widget.screenHeight * 0.01),
                  ),
                ],
              ),
            ),

            /// ================= TITLE =================
            Positioned(
              left: widget.screenWidth * 0.05 + widget.textOffsetX,
              top: widget.screenHeight * 0.02,
              child: Text(
                widget.title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: widget.screenWidth * 0.07,
                ),
              ),
            ),

            // ===== BOOK NOW BUTTON =====
            /// ================= BUTTON =================
            Positioned(
              left: widget.screenWidth * 0.06 + widget.buttonOffsetX,
              top: widget.buttonOffsetY * 0.08,
              child: ElevatedButton(
                /// THIS BUTTON OPENS NEXT PAGE
                onPressed: widget.onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black54,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(widget.screenWidth * 0.05),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: widget.screenWidth * 0.06,
                    vertical: widget.screenHeight * 0.012,
                  ),
                ),
                child: Text(
                  widget.ctaText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: widget.screenWidth * 0.038,
                  ),
                ),
              ),
            ),

            /// ================= IMAGE =================
            Positioned(
              right: widget.imageOffsetX,
              bottom: widget.imageOffsetY,
              child: SizedBox(
                width: cardWidth * widget.imageWidthFactor,
                child: Image.asset(
                  widget.imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}