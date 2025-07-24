import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {


  @override
  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context) {

    final String attentionContent = 'Milk expires today, Bread expires tomorrow, Eggs expire in 2 days';
    final int totalItems = 25;
    final int expiringSoon = 3;
    final List<Map<String, String>> items = [
      {'name': 'Milk', 'category': 'Dairy', 'expiryDate': '2025-07-25'},
      {'name': 'Bread', 'category': 'Bakery', 'expiryDate': '2025-07-26'},
      {'name': 'Eggs', 'category': 'Protein', 'expiryDate': '2025-07-27'},
    ];
    super.build(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // ColorValue.backgroundColor
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hello,\ngrdhck!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        height: 1.2,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.notifications_rounded,
                        color: Colors.black,
                        size: 40,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Attention Needed Card
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3E0), // primary transparent
                    border: Border.all(color: const Color(0xFFFF9800)), // primary
                    borderRadius: const BorderRadius.all(Radius.circular(14)),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFF8E1), // yellow dark transparent
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        padding: const EdgeInsets.all(15),
                        child: const Icon(
                          Icons.warning,
                          color: Color(0xFFFF6F00),
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Attention Needed",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFFFF6F00), // orange dark
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Bullet points
                            ...attentionContent
                                .split(',')
                                .map((item) => Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "• ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFFFF6F00),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      item.trim(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFFFF6F00),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                                .toList(),

                            const SizedBox(height: 16),

                            // View All Items Button
                            SizedBox(
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  side: BorderSide(color: const Color(0xFFFF6F00)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  "View All Items",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFFFF6F00),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Statistics Cards Row
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(14)),
                          border: Border.all(
                            color: const Color(0xFFE0E0E0), // gray
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFE3F2FD), // blue transparent
                                borderRadius: BorderRadius.all(Radius.circular(50)),
                              ),
                              padding: const EdgeInsets.all(15),
                              child: const Icon(
                                Icons.inventory_2,
                                color: Color(0xFF1976D2),
                                size: 30,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              totalItems.toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Total Items",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF757575), // gray dark
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(14)),
                          border: Border.all(
                            color: const Color(0xFFE0E0E0), // gray
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFFFF8E1), // yellow status transparent
                                borderRadius: BorderRadius.all(Radius.circular(50)),
                              ),
                              padding: const EdgeInsets.all(15),
                              child: const Icon(
                                Icons.access_time,
                                color: Color(0xFFF57F17),
                                size: 30,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              expiringSoon.toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFF57F17), // yellow dark
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Expiring Soon",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF757575), // gray dark
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recent Items",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Navigate to pantry page
                      },
                      child: Text(
                        "View All",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFFFF9800), // primary
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Recent Items List
                items.isEmpty
                    ? Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "No items found",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                )
                    : Column(
                  children: items
                      .map((item) => Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFE0E0E0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE3F2FD),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const Icon(
                            Icons.food_bank,
                            color: Color(0xFF1976D2),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item['category']!,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          item['expiryDate']!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}