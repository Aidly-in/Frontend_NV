import 'package:flutter/material.dart';
import 'package:flutter_aidly/features/home/presentation/pages/home_page.dart';
import 'dart:async';
import 'package:flutter_aidly/features/doctor_appointment/presentation/pages/doctor_list_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class CardConfig {
  final String title;
  final String description;
  final String image;

  final double cardHeightPortraitRatio;
  final double cardHeightLandscapeRatio;
  final double cardHeightMin;
  final double cardHeightMax;

  final double imgHeightRatio;
  final double imgWidthRatio;
  final double imgTopRatio;
  final double imgRightOffset;

  final double topMarginRatio;

  const CardConfig({
    required this.title,
    required this.description,
    required this.image,
    required this.cardHeightPortraitRatio,
    required this.cardHeightLandscapeRatio,
    this.cardHeightMin = 160,
    this.cardHeightMax = 320,
    required this.imgHeightRatio,
    required this.imgWidthRatio,
    required this.imgTopRatio,
    required this.imgRightOffset,
    this.topMarginRatio = 0.08,
  });

  double cardHeight(double sw, bool isLandscape) {
    final ratio =
    isLandscape ? cardHeightLandscapeRatio : cardHeightPortraitRatio;
    return (sw * ratio).clamp(cardHeightMin, cardHeightMax);
  }

  double totalHeight(double sw, bool isLandscape) {
    final ch = cardHeight(sw, isLandscape);
    return ch + ch * topMarginRatio;
  }
}

const List<CardConfig> medicalCards = [
  CardConfig(
    title: "Medical Checks!",
    description:
    "Check your health condition regularly\nto minimize disease risk.",
    image: "assets/images/doctor.png",
    cardHeightPortraitRatio: 0.45,
    cardHeightLandscapeRatio: 0.48,
    cardHeightMin: 165,
    cardHeightMax: 310,
    imgHeightRatio: 0.90,
    imgWidthRatio: 0.40,
    imgTopRatio: 0.1,
    imgRightOffset: -10,
    topMarginRatio: 0.10,
  ),
  CardConfig(
    title: "Heart Specialist",
    description:
    "Consult top cardiologists and monitor\nheart health easily.",
    image: "assets/images/female_doc1.png",
    cardHeightPortraitRatio: 0.45,
    cardHeightLandscapeRatio: 0.48,
    cardHeightMin: 165,
    cardHeightMax: 310,
    imgHeightRatio: 0.90,
    imgWidthRatio: 0.40,
    imgTopRatio: 0.1,
    imgRightOffset: -10,
    topMarginRatio: 0.10,
  ),
  CardConfig(
    title: "Dental Care",
    description: "Book appointments with experienced dentists instantly.",
    image: "assets/images/female_doc2.png",
    cardHeightPortraitRatio: 0.38,
    cardHeightLandscapeRatio: 0.48,
    cardHeightMin: 165,
    cardHeightMax: 310,
    imgHeightRatio: 0.90,
    imgWidthRatio: 0.50,
    imgTopRatio: 0.37,
    imgRightOffset: -9,
    topMarginRatio: 0.06,
  ),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomIndex = 0;
  int _chipIndex = 0;
  String _userName = "";

  final PageController _pageCtrl = PageController();
  final TextEditingController _searchCtrl = TextEditingController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    int page = 0;
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted || !_pageCtrl.hasClients) return;
      page = (page + 1) % medicalCards.length;
      _pageCtrl.animateToPage(page,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageCtrl.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  String _greeting() {
    final h = DateTime.now().hour;
    if (h < 12) return "Good Morning ☀️";
    if (h < 17) return "Good Afternoon 🌤";
    if (h < 21) return "Good Evening 🌆";
    return "Good Night 🌙";
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final hp = sw * 0.05;

    final sliderH = medicalCards[0].totalHeight(sw, isLandscape);

    return Scaffold(
      backgroundColor: const Color(0xFFD4F1ED),
      bottomNavigationBar: _buildBottomNav(sw),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: hp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: sh * 0.02),
              GestureDetector(
                onTap: () {
                  if (Navigator.canPop(context)) Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back,
                    size: sw * 0.065, color: Colors.black),
              ),
              SizedBox(height: sh * 0.018),
              Row(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () async {
                      final name = await Navigator.push<String>(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ProfileScreen(currentName: _userName),
                        ),
                      );
                      if (name != null && mounted) {
                        setState(() => _userName = name);
                      }
                    },
                    child: CircleAvatar(
                      radius: sw * 0.06,
                      backgroundColor: Colors.teal,
                      child: Icon(Icons.person,
                          color: Colors.white, size: sw * 0.06),
                    ),
                  ),
                  SizedBox(width: sw * 0.03),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_greeting(),
                            style: TextStyle(fontSize: sw * 0.033)),
                        SizedBox(height: sh * 0.004),
                        Text(
                          _userName.isEmpty
                              ? "Tap Profile to Set Name"
                              : _userName,
                          style: TextStyle(
                              fontSize: sw * 0.042,
                              fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.notifications_none, size: sw * 0.065),
                  SizedBox(width: sw * 0.025),
                  Icon(Icons.favorite_border, size: sw * 0.065),
                ],
              ),
              SizedBox(height: sh * 0.022),
              Container(
                height: sh * 0.06,
                padding: EdgeInsets.symmetric(horizontal: sw * 0.02),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: TextField(
                  controller: _searchCtrl,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, size: sw * 0.055),
                    hintText: "Find my doctor",
                    suffixIcon: Icon(Icons.tune,
                        color: Colors.teal, size: sw * 0.055),
                  ),
                ),
              ),
              SizedBox(height: sh * 0.022),
              SizedBox(
                height: sliderH,
                child: PageView.builder(
                  controller: _pageCtrl,
                  itemCount: medicalCards.length,
                  itemBuilder: (_, i) => _MedicalCard(
                    config: medicalCards[i],
                    isLandscape: isLandscape,
                  ),
                ),
              ),
              SizedBox(height: sh * 0.025),
              _sectionHeader("Doctor Speciality", sw, onSeeAll: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const SpecialityListScreen()));
              }),
              SizedBox(height: sh * 0.018),
              _SpecialityGrid(sw: sw),
              SizedBox(height: sh * 0.025),
              _sectionHeader("Top Doctors", sw, onSeeAll: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const TopDoctorsScreen()));
              }),
              SizedBox(height: sh * 0.015),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    doctorFilters.length,
                        (i) => _DoctorChip(
                      label: doctorFilters[i],
                      active: _chipIndex == i,
                      sw: sw,
                      onTap: () => setState(() => _chipIndex = i),
                    ),
                  ),
                ),
              ),
              SizedBox(height: sh * 0.03),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, double sw,
      {required VoidCallback onSeeAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
                fontSize: sw * 0.045, fontWeight: FontWeight.w600)),
        InkWell(
          onTap: onSeeAll,
          child: Text("See All",
              style: TextStyle(
                  color: Colors.teal,
                  fontSize: sw * 0.038,
                  fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }

  Widget _buildBottomNav(double sw) {
    return BottomNavigationBar(
      currentIndex: _bottomIndex,
      onTap: (i) {
        setState(() => _bottomIndex = i);
        if (i == 0) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => const MergedHomePage()));
        }
      },
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      backgroundColor: const Color(0xFF1F6F63),
      type: BottomNavigationBarType.fixed,
      selectedFontSize: sw * 0.028,
      unselectedFontSize: sw * 0.028,
      iconSize: sw * 0.062,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital), label: "Ambulance"),
        BottomNavigationBarItem(
            icon: Icon(Icons.health_and_safety), label: "Healthcare"),
        BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long), label: "My Order"),
      ],
    );
  }
}

class _MedicalCard extends StatelessWidget {
  final CardConfig config;
  final bool isLandscape;

  const _MedicalCard({required this.config, required this.isLandscape});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final cardH = config.cardHeight(sw, isLandscape);
    final topMargin = cardH * config.topMarginRatio;

    final imgH = cardH * config.imgHeightRatio;
    final imgW = sw * config.imgWidthRatio;
    final imgTop = topMargin + cardH * config.imgTopRatio;
    final imgRight = config.imgRightOffset;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: topMargin,
          left: 0,
          right: sw * 0.02,
          bottom: 0,
          child: Container(
            padding: EdgeInsets.fromLTRB(
                sw * 0.05, cardH * 0.10, sw * 0.02, cardH * 0.10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF0D8177),
                  Color(0xFF12BDB0),
                  Color(0xFF80D8CF),
                  Color(0xFF80D8CF),
                  Color(0xFF12BDB0),
                  Color(0xFF0D8177),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.18),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              children: [
                SizedBox(
                  width: sw * 0.50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        config.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: sw * 0.042,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: cardH * 0.05),
                      Text(
                        config.description,
                        style: TextStyle(
                            color: Colors.white, fontSize: sw * 0.032),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: cardH * 0.08),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.teal,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {},
                        child: Text("Check Now",
                            style: TextStyle(fontSize: sw * 0.030)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: imgRight,
          top: imgTop,
          child: Image.asset(
            config.image,
            width: imgW,
            height: imgH,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => Container(
              width: imgW,
              height: imgH,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.person, size: sw * 0.12, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

const List<Map<String, dynamic>> specialities = [
  {'icon': Icons.person,             'label': 'General'},
  {'icon': Icons.child_care_rounded, 'label': 'Pediatrician'},
  {'icon': Icons.favorite,           'label': 'Gynecologist'},
  {'icon': Icons.health_and_safety,  'label': 'Dentist'},
  {'icon': Icons.healing,            'label': 'Orthopedic'},
  {'icon': Icons.monitor_heart,      'label': 'Cardiologist'},
  {'icon': Icons.psychology,         'label': 'Psychiatrist'},
  {'icon': Icons.memory,             'label': 'Neurologist'},
];

class _SpecialityGrid extends StatelessWidget {
  final double sw;
  const _SpecialityGrid({required this.sw});

  @override
  Widget build(BuildContext context) {
    final itemW   = sw / 4;
    final boxSize = itemW * 0.55;
    final iconSz  = boxSize * 0.50;
    final fontSz  = sw * 0.027;

    return Wrap(
      spacing: 0,
      runSpacing: sw * 0.04,
      children: specialities.map((s) {
        return SizedBox(
          width: itemW,
          child: InkWell(
            onTap: () {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: boxSize,
                  height: boxSize,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: Icon(s['icon'] as IconData,
                      color: Colors.teal, size: iconSz),
                ),
                const SizedBox(height: 5),
                Text(s['label'] as String,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: fontSz),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

const List<String> doctorFilters = ["All", "General", "Derma", "Dentist"];

class _DoctorChip extends StatelessWidget {
  final String label;
  final bool active;
  final double sw;
  final VoidCallback onTap;

  const _DoctorChip({
    required this.label,
    required this.active,
    required this.sw,
    required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: EdgeInsets.only(right: sw * 0.04),
        padding: EdgeInsets.symmetric(
            horizontal: sw * 0.045, vertical: sw * 0.025),
        decoration: BoxDecoration(
          color: active ? Colors.teal : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label,
            style: TextStyle(
              color: active ? Colors.white : Colors.teal,
              fontSize: sw * 0.036,
              fontWeight: active ? FontWeight.w600 : FontWeight.normal,
            )),
      ),
    );
  }
}

class SpecialityListScreen extends StatelessWidget {
  const SpecialityListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final columns = sw > 900 ? 6 : sw > 600 ? 4 : 3;

    return Scaffold(
      backgroundColor: const Color(0xFFD4F1ED),
      appBar: AppBar(
        title: const Text("All Specialities"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(sw * 0.05),
        child: GridView.builder(
          itemCount: specialities.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: sw * 0.04,
            mainAxisSpacing: sw * 0.04,
          ),
          itemBuilder: (_, i) {
            final boxSize = (sw * 0.15).clamp(44.0, 72.0);
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: boxSize,
                  height: boxSize,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: Icon(specialities[i]['icon'] as IconData,
                      color: Colors.teal, size: boxSize * 0.45),
                ),
                const SizedBox(height: 5),
                Text(specialities[i]['label'] as String,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: sw * 0.03),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final String currentName;
  const ProfileScreen({super.key, required this.currentName});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final ctrl = TextEditingController(text: currentName);

    return Scaffold(
      backgroundColor: const Color(0xFFD4F1ED),
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(sw * 0.05),
        child: Column(
          children: [
            TextField(
              controller: ctrl,
              decoration: const InputDecoration(
                  labelText: "Enter Name", border: OutlineInputBorder()),
            ),
            SizedBox(height: sw * 0.05),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white),
                onPressed: () => Navigator.pop(context, ctrl.text.trim()),
                child: const Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
