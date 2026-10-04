import 'package:flutter/material.dart';
import 'package:flutter_aidly/features/pharmacy/presentation/pages/medicine_dashboard_page.dart';
import 'package:flutter_aidly/features/pickup_homecare/presentation/pages/home_care_page.dart';
import 'package:flutter_aidly/features/pickup_homecare/presentation/pages/pickup_details_page.dart';
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
  int tapCount = 0;

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
                const Text(
                  'UPDATE YOUR PROFILE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
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
                const Text(
                  ':)',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20),
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bool isTablet = screenWidth > 600;
    final bool isLandscape = screenWidth > screenHeight;

    double scale(double mobile, double tablet) {
      return isTablet ? tablet : mobile;
    }

    const teal = Color(0xFF0E6B5B);

    final double cardGap = isLandscape
        ? screenHeight * 0.04
        : screenHeight * 0.06;

    final double card1ImageOffsetY = isLandscape
        ? -screenHeight * 0.06
        : -screenHeight * 0.09;

    final double testimonialHeight = isLandscape
        ? screenHeight * 0.28
        : screenHeight * 0.18;

    return GestureDetector(
      onTap: () {
        tapCount++;
        if (tapCount == 5) {
          tapCount = 0;
          showUpdatePopup();
        }
      },
      child: Scaffold(
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
                  SizedBox(height: cardGap),
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
                  SizedBox(height: cardGap),
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
                  SizedBox(height: cardGap),
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

class SocialCircle extends StatelessWidget {
  final dynamic icon;
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
      child: icon is IconData
          ? Icon(
              icon,
              color: Colors.white,
              size: screenWidth * 0.05,
            )
          : FaIcon(
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
  final double buttonOffsetX;
  final double buttonOffsetY;
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
    this.textOffsetX = 0,
    this.buttonOffsetX = 0,
    this.buttonOffsetY = 0,
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
            Positioned(
              left: widget.screenWidth * 0.06 + widget.buttonOffsetX,
              top: widget.buttonOffsetY * 0.08,
              child: ElevatedButton(
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
            Positioned(
              right: widget.imageOffsetX,
              bottom: widget.imageOffsetY,
              child: Image.asset(
                widget.imagePath,
                width: widget.screenWidth * widget.imageWidthFactor,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
