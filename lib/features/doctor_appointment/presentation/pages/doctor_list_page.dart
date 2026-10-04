import 'package:flutter/material.dart';
import 'package:flutter_aidly/features/doctor_appointment/presentation/pages/doctor_profile_page.dart';
import 'package:flutter_aidly/features/doctor_appointment/presentation/pages/doctor_profile_detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TopDoctorsScreen(),
    );
  }
}

class TopDoctorsScreen extends StatefulWidget {
  const TopDoctorsScreen({
    super.key,
  });

  @override
  State<TopDoctorsScreen> createState() => _TopDoctorsScreenState();
}

class _TopDoctorsScreenState extends State<TopDoctorsScreen> {
  bool isSearching = false;

  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  final List<Map<String, dynamic>> doctors = [
    {
      "name": "Dr. Jenny Watson",
      "speciality": "Cardio",
      "price": "₹400",
      "rating": "4.5",
      "reviews": "(2750 Reviews)",
      "favorite": false,
    },
    {
      "name": "Dr. James Watson",
      "speciality": "Orthopedic",
      "price": "₹350",
      "rating": "4.5",
      "reviews": "(2750 Reviews)",
      "favorite": false,
    },
    {
      "name": "Dr. Alen Morgan",
      "speciality": "Heart Specialist",
      "price": "₹500",
      "rating": "4.8",
      "reviews": "(3200 Reviews)",
      "favorite": false,
    },
  ];

  List<Map<String, dynamic>> filteredDoctors = [];

  @override
  void initState() {
    super.initState();
    filteredDoctors = List.from(doctors);
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  void searchDoctor(String value) {
    setState(() {
      if (value.isEmpty) {
        filteredDoctors = List.from(doctors);
      } else {
        filteredDoctors = doctors.where((doctor) {
          final name = doctor["name"].toString().toLowerCase();
          final speciality = doctor["speciality"].toString().toLowerCase();
          return name.contains(value.toLowerCase()) ||
              speciality.contains(value.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        final imageSize = width.clamp(320.0, 600.0) * 0.22;

        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: const Color(0xFFEAF7F2),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.02,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: width * 0.07,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Expanded(
                          child: isSearching
                              ? Container(
                            height: height * 0.065,
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.04,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                width * 0.045,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  size: width * 0.06,
                                ),
                                SizedBox(width: width * 0.02),
                                Expanded(
                                  child: TextField(
                                    controller: searchController,
                                    focusNode: searchFocusNode,
                                    autofocus: true,
                                    onChanged: searchDoctor,
                                    style: TextStyle(
                                      fontSize: width * 0.04,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Search doctor...",
                                      hintStyle: TextStyle(
                                        fontSize: width * 0.038,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          Icons.close,
                                          size: width * 0.055,
                                        ),
                                        onPressed: () {
                                          searchController.clear();
                                          setState(() {
                                            filteredDoctors = List.from(doctors);
                                            isSearching = false;
                                          });
                                          FocusScope.of(context).unfocus();
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                              : Text(
                            "Top Doctors",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: width * 0.06,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        if (!isSearching)
                          IconButton(
                            icon: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: width * 0.07,
                            ),
                            onPressed: () {
                              setState(() {
                                isSearching = true;
                              });
                              Future.delayed(
                                const Duration(milliseconds: 100),
                                    () {
                                  FocusScope.of(context).requestFocus(searchFocusNode);
                                },
                              );
                            },
                          ),
                        if (!isSearching)
                          IconButton(
                            icon: Icon(
                              Icons.tune,
                              color: Colors.black,
                              size: width * 0.07,
                            ),
                            onPressed: () {},
                          ),
                      ],
                    ),
                    SizedBox(height: height * 0.025),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredDoctors.length,
                      itemBuilder: (context, index) {
                        final doctor = filteredDoctors[index];
                        return Container(
                          margin: EdgeInsets.only(
                            bottom: height * 0.025,
                          ),
                          padding: EdgeInsets.all(width * 0.045),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(width * 0.06),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: imageSize,
                                width: imageSize,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(width * 0.05),
                                ),
                                child: Icon(
                                  Icons.person,
                                  size: imageSize * 0.45,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(width: width * 0.04),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      doctor["name"],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: width * 0.05,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.008),
                                    Wrap(
                                      spacing: width * 0.02,
                                      children: [
                                        Text(
                                          doctor["speciality"],
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: width * 0.035,
                                          ),
                                        ),
                                        Text(
                                          doctor["price"],
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: width * 0.035,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: height * 0.01),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: width * 0.045,
                                        ),
                                        SizedBox(width: width * 0.01),
                                        Expanded(
                                          child: Text(
                                            "${doctor["rating"]} ${doctor["reviews"]}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: width * 0.03,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: height * 0.015),
                                    Wrap(
                                      spacing: width * 0.03,
                                      runSpacing: height * 0.01,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => DoctorProfileScreen(
                                                  name: doctor["name"],
                                                  speciality: doctor["speciality"],
                                                  price: int.parse(
                                                    doctor["price"]
                                                        .toString()
                                                        .replaceAll("₹", ""),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          borderRadius: BorderRadius.circular(30),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.055,
                                              vertical: height * 0.012,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.teal,
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            child: Text(
                                              "Online",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: width * 0.035,
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => DoctorPreferenceScreen(
                                                  name: doctor["name"],
                                                  speciality: doctor["speciality"],
                                                  price: int.parse(
                                                    doctor["price"]
                                                        .toString()
                                                        .replaceAll("₹", ""),
                                                  ),
                                                  experience: "12 Years Experience",
                                                  rating: double.parse(
                                                    doctor["rating"].toString(),
                                                  ),
                                                  reviews: 2750,
                                                ),
                                              ),
                                            );
                                          },
                                          borderRadius: BorderRadius.circular(30),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.055,
                                              vertical: height * 0.012,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            child: Text(
                                              "Offline",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: width * 0.035,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    doctor["favorite"] = !(doctor["favorite"] ?? false);
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(left: width * 0.02),
                                  child: Icon(
                                    doctor["favorite"] == true
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: doctor["favorite"] == true
                                        ? Colors.red
                                        : Colors.grey,
                                    size: width * 0.07,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
