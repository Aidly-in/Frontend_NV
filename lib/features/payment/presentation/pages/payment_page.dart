import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

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
  int selectedPaymentIndex = -1;
  int selectedUpiIndex = -1;

  List<Map<String, dynamic>> paymentApps = [
    {"name": "Google Pay"},
    {"name": "PhonePe"},
    {"name": "Paytm"},
    {"name": "BHIM UPI"},
  ];

  List<Map<String, dynamic>> upiApps = [
    {"name": "Amazon Pay UPI"},
    {"name": "Cred UPI"},
    {"name": "WhatsApp UPI"},
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return OrientationBuilder(
      builder: (context, orientation) {
        final isLandscape = orientation == Orientation.landscape;

        return Scaffold(
          backgroundColor: const Color(0xFFF1F4F3),
          body: SafeArea(
            top: false,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.045,
                    right: screenWidth * 0.045,
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
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
                      SizedBox(height: isLandscape ? 4 : screenWidth * 0.025),
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
                Expanded(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 720),
                      child: SingleChildScrollView(
                        keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: EdgeInsets.all(screenWidth * 0.04),
                        child: Column(
                          children: [
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
                                          Container(
                                            width: 1,
                                            height: 36,
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
                                  const SizedBox(height: 14),
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
                            const SizedBox(height: 28),
                            sectionTitle(context, "Preferred Payment"),
                            const SizedBox(height: 14),
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
                                        selectedPaymentIndex = index;
                                        selectedUpiIndex = -1;
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 24),
                            sectionTitle(context, "Pay by Any UPI App"),
                            const SizedBox(height: 14),
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
                                        selectedUpiIndex = index;
                                        selectedPaymentIndex = -1;
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 24),
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
                            const SizedBox(height: 24),
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
                                  const SizedBox(height: 18),
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

  Widget paymentTile({
    required BuildContext context,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
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
          const SizedBox(height: 16),
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
