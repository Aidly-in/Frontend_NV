import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// MAIN APP
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PickupPage(),
    );
  }
}

/// PICKUP PAGE
class PickupPage extends StatefulWidget {
  const PickupPage({super.key});

  @override
  State<PickupPage> createState() => _PickupPageState();
}

class _PickupPageState extends State<PickupPage> {
  /// DROPDOWN VALUE
  String selectedPerson = "Myself";

  /// DROPDOWN LIST
  List<String> personList = [
    "Myself",
    "Family",
    "Friend",
  ];

  @override
  Widget build(BuildContext context) {
    /// FIX: USE OrientationBuilder TO DETECT LANDSCAPE VS PORTRAIT
    /// AND ADAPT HEADER PADDING SO IT DOESN'T CONSUME TOO MUCH
    /// VERTICAL SPACE IN LANDSCAPE MODE
    return OrientationBuilder(
      builder: (context, orientation) {
        final isLandscape = orientation == Orientation.landscape;

        return Scaffold(
          backgroundColor: const Color(0xFFEFF4F3),
          body: SafeArea(
            child: Column(
              children: [
                /// TOP HEADER
                /// FIX: HEADER STAYS OUTSIDE THE SCROLL SO IT IS ALWAYS VISIBLE
                /// BOTTOM PADDING REDUCED IN LANDSCAPE TO SAVE VERTICAL SPACE
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    left: 18,
                    right: 18,
                    top: 18,
                    /// FIX: REDUCED BOTTOM PADDING IN LANDSCAPE TO PREVENT
                    /// HEADER FROM CONSUMING TOO MUCH VERTICAL SPACE
                    bottom: isLandscape ? 12 : 24,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFF31C1B0),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                  child: Row(
                    children: [
                      /// BACK BUTTON
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: const Padding(
                          padding: EdgeInsets.all(6),
                          child: Icon(
                            Icons.arrow_back,
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      /// FIX: WRAPPED TITLE IN Flexible INSTEAD OF Expanded
                      /// TO PREVENT THE DROPDOWN FROM BEING PUSHED OFF-SCREEN
                      /// ON SMALL OR NARROW DEVICES WHERE BOTH COMPETE FOR SPACE
                      const Flexible(
                        child: Text(
                          "Pick-up",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis, // FIX: PREVENTS TEXT OVERFLOW
                        ),
                      ),

                      const SizedBox(width: 8),

                      /// DROPDOWN
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDDF4D8),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedPerson,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              size: 28,
                            ),
                            borderRadius: BorderRadius.circular(14),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                            items: personList.map((person) {
                              return DropdownMenuItem(
                                value: person,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.person,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(person),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedPerson = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// FIX: WRAPPED ALL BODY CONTENT BELOW THE HEADER IN
                /// Expanded + SingleChildScrollView SO THAT ON SMALL PHONES
                /// AND IN LANDSCAPE MODE THE CONTENT SCROLLS RATHER THAN
                /// CAUSING A RenderFlex OVERFLOW. THE HEADER STAYS PINNED.
                Expanded(
                  child: SingleChildScrollView(
                    /// FIX: DISMISS KEYBOARD ON SCROLL FOR KEYBOARD-SAFE LAYOUT
                    keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Center(
                      child: ConstrainedBox(
                        /// FIX: TABLET/WIDE-SCREEN MAX WIDTH CONSTRAINT
                        /// PREVENTS CONTENT FROM STRETCHING ACROSS FULL WIDTH
                        /// ON FOLDABLES, TABLETS, AND DESKTOP EMULATORS
                        constraints: const BoxConstraints(maxWidth: 720),
                        child: Column(
                          children: [
                            const SizedBox(height: 18),

                            /// LOCATION CARD
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(18),
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
                                child: Column(
                                  children: [
                                    /// PICKUP LOCATION
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              height: 12,
                                              width: 12,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.green,
                                                  width: 2,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 1,
                                              height: 35,
                                              color: Colors.grey,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 15),
                                        Expanded(
                                          child: Text(
                                            "Pickup location",
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: const CircleAvatar(
                                            radius: 11,
                                            backgroundColor: Colors.black,
                                            child: Icon(
                                              Icons.close,
                                              size: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 14),

                                    /// DROP LOCATION
                                    Row(
                                      children: [
                                        Container(
                                          height: 14,
                                          width: 14,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.deepOrange,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 15),
                                        Expanded(
                                          child: Text(
                                            "Drop location",
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: const CircleAvatar(
                                            radius: 11,
                                            backgroundColor: Colors.black,
                                            child: Icon(
                                              Icons.close,
                                              size: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 32),

                            /// OR SECTION
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 28,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 18),
                                    child: Text(
                                      "or",
                                      style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 25),

                            /// SEARCH CARD
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(14),
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
                                child: Column(
                                  children: [
                                    /// SEARCH BOX
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 14,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE7DDDD),
                                        borderRadius:
                                        BorderRadius.circular(14),
                                      ),
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.search,
                                            color: Color(0xFF31C1B0),
                                            size: 32,
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              "Search Hospital's Name",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 22),

                                    /// RECENT SEARCHES
                                    recentSearchRow(),
                                    const SizedBox(height: 20),
                                    recentSearchRow(),
                                    const SizedBox(height: 20),
                                    recentSearchRow(),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 22),

                            /// GPS CARD
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF4C4545),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        "Allow Aidly to turn on your\nphone GPS for accurate\npickup",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text("GPS Turned On"),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 22,
                                          vertical: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFA99A9A),
                                          borderRadius:
                                          BorderRadius.circular(12),
                                        ),
                                        child: const Text(
                                          "Turn On",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            /// FIX: BOTTOM PADDING SO LAST CARD ISN'T FLUSH
                            /// AGAINST THE SCREEN EDGE AFTER SCROLLING
                            const SizedBox(height: 24),
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
      },
    );
  }

  /// RECENT SEARCH ROW
  Widget recentSearchRow() {
    return Row(
      children: [
        Icon(
          Icons.history,
          color: Colors.grey.shade400,
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Divider(
            thickness: 1,
            color: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }
}