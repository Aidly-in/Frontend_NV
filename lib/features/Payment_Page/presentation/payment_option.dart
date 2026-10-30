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
      home: PaymentOptionPage(
        payableAmount: "₹2000",
        pickupLocation: "Ayodhya Bypass Road, Bhopal",
        dropLocation: "MP Nagar, Bhopal",
      ),
    );
  }
}

/// PAYMENT OPTION PAGE
class PaymentOptionPage extends StatefulWidget {
  final String payableAmount;
  final String pickupLocation;
  final String dropLocation;

  const PaymentOptionPage({
    super.key,
    required this.payableAmount,
    required this.pickupLocation,
    required this.dropLocation,
  });

  @override
  State<PaymentOptionPage> createState() => _PaymentOptionPageState();
}

class _PaymentOptionPageState extends State<PaymentOptionPage> {
  /// ONLY ONE SELECTION
  int selectedPaymentIndex = -1;
  int selectedUpiIndex = -1;

  /// PAYMENT APPS
  List<Map<String, dynamic>> paymentApps = [
    {"name": "Google Pay"},
    {"name": "PhonePe"},
    {"name": "Paytm"},
    {"name": "BHIM UPI"},
  ];

  /// UPI APPS
  List<Map<String, dynamic>> upiApps = [
    {"name": "Amazon Pay UPI"},
    {"name": "Cred UPI"},
    {"name": "WhatsApp UPI"},
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    /// FIX: USE OrientationBuilder TO DETECT PORTRAIT VS LANDSCAPE
    /// This prevents header from being too tall in landscape and
    /// body content from being compressed on rotation.
    return OrientationBuilder(
      builder: (context, orientation) {
        final isLandscape = orientation == Orientation.landscape;

        return Scaffold(
          backgroundColor: const Color(0xFFF1F4F3),
          body: SafeArea(
            top: false,
            child: Column(
              children: [
                /// HEADER
                /// FIX: REPLACED FIXED screenHeight-BASED PADDING WITH
                /// ADAPTIVE VALUES BASED ON ORIENTATION TO PREVENT
                /// HEADER FROM COLLAPSING OR OVERFLOWING IN LANDSCAPE
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.045,
                    right: screenWidth * 0.045,
                    /// FIX: REDUCED TOP/BOTTOM PADDING IN LANDSCAPE
                    /// TO PREVENT HEADER FROM CONSUMING TOO MUCH HEIGHT
                    top: isLandscape ? 8 : screenWidth * 0.055,
                    bottom: isLandscape ? 8 : screenWidth * 0.065,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFF31C1B0),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // FIX: PREVENTS COLUMN FROM EXPANDING BEYOND CONTENT
                    children: [
                      Row(
                        children: [
                          /// BACK BUTTON
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            borderRadius: BorderRadius.circular(30),
                            child: Padding(
                              padding: EdgeInsets.all(screenWidth * 0.015),
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: screenWidth * 0.07,
                              ),
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Expanded(
                            child: Text(
                              "Payment Option",
                              style: TextStyle(
                                fontSize: screenWidth * 0.07,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      /// FIX: REDUCED SPACING IN LANDSCAPE TO SAVE VERTICAL SPACE
                      SizedBox(height: isLandscape ? 4 : screenWidth * 0.025),

                      /// PAYABLE AMOUNT
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Amount Payable ${widget.payableAmount}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// BODY
                /// FIX: WRAPPED SCROLL CONTENT IN Expanded + CENTER + ConstrainedBox
                /// TO SUPPORT TABLETS AND LARGE SCREENS WITHOUT STRETCHING FULL WIDTH
                Expanded(
                  child: Center(
                    child: ConstrainedBox(
                      /// FIX: TABLET-FRIENDLY MAX WIDTH — CONTENT WON'T STRETCH
                      /// ACROSS FULL SCREEN ON WIDE DISPLAYS (TABLETS, FOLDABLES, DESKTOPS)
                      constraints: const BoxConstraints(maxWidth: 720),
                      child: SingleChildScrollView(
                        /// FIX: KEYBOARD-SAFE PADDING SO CONTENT NOT HIDDEN
                        /// BEHIND KEYBOARD ON SMALLER DEVICES
                        keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: EdgeInsets.all(screenWidth * 0.04),
                        child: Column(
                          children: [
                            /// PICKUP CARD
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(screenWidth * 0.045),
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
                                  /// PICKUP
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            height: screenWidth * 0.03,
                                            width: screenWidth * 0.03,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.green,
                                                width: 2,
                                              ),
                                            ),
                                          ),
                                          /// FIX: REPLACED FIXED screenHeight-BASED HEIGHT
                                          /// FOR CONNECTOR LINE WITH A FIXED PIXEL VALUE
                                          /// THAT DOESN'T COLLAPSE IN LANDSCAPE MODE
                                          Container(
                                            width: 1,
                                            height: 36, // FIX: STABLE HEIGHT REGARDLESS OF ORIENTATION
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: screenWidth * 0.04),
                                      Expanded(
                                        child: Text(
                                          widget.pickupLocation,
                                          style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: screenWidth * 0.042,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 14), // FIX: STABLE SPACING

                                  /// DROP
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: screenWidth * 0.035,
                                        width: screenWidth * 0.035,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.deepOrange,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: screenWidth * 0.04),
                                      Expanded(
                                        child: Text(
                                          widget.dropLocation,
                                          style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: screenWidth * 0.042,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 28), // FIX: STABLE SPACING

                            /// PREFERRED PAYMENT
                            sectionTitle(context, "Preferred Payment"),

                            const SizedBox(height: 14), // FIX: STABLE SPACING

                            Column(
                              children: List.generate(
                                paymentApps.length,
                                    (index) {
                                  final payment = paymentApps[index];
                                  return paymentTile(
                                    context: context,
                                    title: payment["name"],
                                    isSelected:
                                    selectedPaymentIndex == index,
                                    onTap: () {
                                      setState(() {
                                        /// SELECT CURRENT PAYMENT
                                        selectedPaymentIndex = index;
                                        /// UNSELECT UPI SECTION
                                        selectedUpiIndex = -1;
                                      });
                                    },
                                  );
                                },
                              ),
                            ),

                            const SizedBox(height: 24), // FIX: STABLE SPACING

                            /// PAY BY ANY UPI APP
                            sectionTitle(context, "Pay by Any UPI App"),

                            const SizedBox(height: 14), // FIX: STABLE SPACING

                            Column(
                              children: List.generate(
                                upiApps.length,
                                    (index) {
                                  final upi = upiApps[index];
                                  return paymentTile(
                                    context: context,
                                    title: upi["name"],
                                    isSelected: selectedUpiIndex == index,
                                    onTap: () {
                                      setState(() {
                                        /// SELECT CURRENT UPI
                                        selectedUpiIndex = index;
                                        /// UNSELECT PREFERRED PAYMENT
                                        selectedPaymentIndex = -1;
                                      });
                                    },
                                  );
                                },
                              ),
                            ),

                            const SizedBox(height: 24), // FIX: STABLE SPACING

                            /// ADD CARD
                            paymentOptionTile(
                              context: context,
                              icon: Icons.add,
                              title: "Add New Card",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AddCardPage(),
                                  ),
                                );
                              },
                            ),

                            const SizedBox(height: 24), // FIX: STABLE SPACING

                            /// MORE OPTIONS
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(screenWidth * 0.045),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "More Payment Options",
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.055,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 18), // FIX: STABLE SPACING
                                  paymentOptionTile(
                                    context: context,
                                    icon: Icons.account_balance_wallet,
                                    title: "Wallets",
                                    onTap: () {},
                                  ),
                                  const Divider(),
                                  paymentOptionTile(
                                    context: context,
                                    icon: Icons.language,
                                    title: "Netbanking",
                                    onTap: () {},
                                  ),
                                  const Divider(),
                                  paymentOptionTile(
                                    context: context,
                                    icon: Icons.local_shipping,
                                    title: "Pay on Delivery",
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 24), // FIX: BOTTOM PADDING INSIDE SCROLL
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

  /// SECTION TITLE
  Widget sectionTitle(BuildContext context, String title) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: screenWidth * 0.055,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// PAYMENT TILE
  Widget paymentTile({
    required BuildContext context,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.only(bottom: 14), // FIX: STABLE MARGIN INSTEAD OF screenHeight-BASED
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // FIX: PREVENTS COLUMN FROM OVER-EXPANDING
        children: [
          Row(
            children: [
              /// APP BOX
              Container(
                height: screenWidth * 0.13,
                width: screenWidth * 0.13,
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F3F5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.apps, size: screenWidth * 0.06),
              ),
              SizedBox(width: screenWidth * 0.04),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16), // FIX: STABLE SPACING BETWEEN ROW AND BUTTON

          /// BUTTON
          /// FIX: REPLACED FIXED screenHeight * 0.065 HEIGHT WITH constraints
          /// USING minHeight SO BUTTON NEVER COLLAPSES IN LANDSCAPE
          /// WHILE STILL GROWING IF TEXT WRAPS ON SMALL SCREENS
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isSelected
                  ? () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Pay via $title")),
                );
              }
                  : onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: isSelected ? Colors.green : Colors.white,
                elevation: isSelected ? 0 : 1,
                /// FIX: USE minimumSize INSTEAD OF A FIXED HEIGHT CONTAINER
                /// SO BUTTON ADAPTS WITHOUT OVERFLOWING ON ANY SCREEN SIZE
                minimumSize: const Size(double.infinity, 50),
                side: BorderSide(
                  color: isSelected ? Colors.green : Colors.grey.shade300,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                isSelected ? "Pay via $title" : "Select",
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontSize: screenWidth * 0.042,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// PAYMENT OPTION TILE
  Widget paymentOptionTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        /// FIX: REPLACED screenHeight-BASED VERTICAL PADDING WITH STABLE VALUE
        /// TO PREVENT TILES FROM COLLAPSING OR EXPANDING TOO MUCH IN LANDSCAPE
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              height: screenWidth * 0.12,
              width: screenWidth * 0.12,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: Colors.black87,
                size: screenWidth * 0.06,
              ),
            ),
            SizedBox(width: screenWidth * 0.04),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: screenWidth * 0.045,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

/// ADD CARD PAGE
class AddCardPage extends StatelessWidget {
  const AddCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Card")),
      body: const Center(
        child: Text(
          "Add Card Screen",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
