import 'package:flutter/material.dart';

class VipPage extends StatelessWidget {
  const VipPage({super.key});

  // এখানে কোনো জটিল জেনেরিক টাইপ ব্যবহার করা হয়নি, ফলে কোনো এরর আসবে না
  static final List<dynamic> vipPackages = [
    {
      'title': 'Weekly VIP',
      'price': '\$1.99',
      'subtitle': 'Billed weekly, cancel anytime.',
      'isPopular': false,
    },
    {
      'title': 'Monthly VIP',
      'price': '\$4.99',
      'subtitle': 'Billed monthly, most flexible.',
      'isPopular': false,
    },
    {
      'title': 'Yearly VIP',
      'price': '\$29.99',
      'subtitle': 'Billed annually, great savings.',
      'isPopular': false,
    },
    {
      'title': '2 Years VIP (Best Value)',
      'price': '\$59.99',
      'subtitle': 'Save big for 24 months access.',
      'isPopular': true,
    },
    {
      'title': 'Lifetime VIP (All Time)',
      'price': '\$99.99',
      'subtitle': 'One-time payment, lifetime unlimited access.',
      'isPopular': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF13111C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1D1B2E),
        title: const Text(
          'Unlock VIP Membership',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ওপরে প্রিমিয়াম ব্যানার
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2A2438), Color(0xFF1D1B2E)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.amber.withValues(alpha: 0.4)),
              ),
              child: const Column(
                children: [
                  Icon(Icons.workspace_premium_rounded, color: Colors.amber, size: 45),
                  SizedBox(height: 8),
                  Text(
                    'Go Premium & Enjoy Ultra Speed',
                    style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Unlock all global VIP servers without any ads.',
                    style: TextStyle(color: Colors.white54, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Select Your Subscription Plan',
              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // প্যাকেজগুলোর স্ক্রলযোগ্য লিস্ট
            Expanded(
              child: ListView.builder(
                itemCount: vipPackages.length,
                itemBuilder: (context, index) {
                  final Map<String, dynamic> pkg = vipPackages[index] as Map<String, dynamic>;
                  final bool isPopular = pkg['isPopular'] as bool;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1D1B2E),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isPopular ? Colors.amber : Colors.white.withValues(alpha: 0.08),
                        width: isPopular ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    pkg['title'] as String,
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                                  ),
                                  if (isPopular) ...[
                                    const SizedBox(width: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: const Text('BEST', style: TextStyle(color: Colors.black, fontSize: 9, fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 3),
                              Text(
                                pkg['subtitle'] as String,
                                style: const TextStyle(color: Colors.white54, fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          pkg['price'] as String,
                          style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // সাবস্ক্রাইব বাটন
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  // পেমেন্ট বা সাবস্ক্রিপশন কনফার্মেশন লজিক
                },
                child: const Text(
                  'Continue to Subscribe',
                  style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}