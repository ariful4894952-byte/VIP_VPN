import 'package:flutter/material.dart';

class ServerPage extends StatelessWidget {
  const ServerPage({super.key});

  // --- স্পেশাল ভিআইপি মোডসমূহ (Gaming & Safe Mode) ---
  static final List specialModes = [
    {
      'name': 'Gaming Mode',
      'code': 'GAME',
      'flag': '⚡',
      'ping': '12 ms',
      'subtitle': 'Ultra-low ping & high-speed routing',
      'isVip': true,
      'icon': Icons.sports_esports_rounded,
    },
    {
      'name': 'Safe Mode (Privacy)',
      'code': 'SAFE',
      'flag': '🛡️',
      'ping': '25 ms',
      'subtitle': 'Advanced IP leak protection & strict no-logs',
      'isVip': true,
      'icon': Icons.security_rounded,
    },
  ];

  static final List servers = [
    // --- ফ্রি সার্ভারসমূহ (শহর বা জেলাসহ) ---
    {
      'name': 'United States',
      'code': 'USA',
      'flag': '🇺🇸',
      'ping': '24 ms',
      'isVip': false,
      'hasCities': true,
      'cities': [
        {'cityName': 'New York', 'ping': '22 ms'},
        {'cityName': 'Los Angeles', 'ping': '35 ms'},
        {'cityName': 'Chicago', 'ping': '28 ms'},
        {'cityName': 'Miami', 'ping': '31 ms'},
      ],
    },
    {
      'name': 'United Kingdom',
      'code': 'UK',
      'flag': '🇬🇧',
      'ping': '35 ms',
      'isVip': false,
      'hasCities': true,
      'cities': [
        {'cityName': 'London', 'ping': '33 ms'},
        {'cityName': 'Manchester', 'ping': '38 ms'},
      ],
    },
    {
      'name': 'Germany',
      'code': 'GER',
      'flag': '🇩🇪',
      'ping': '42 ms',
      'isVip': false,
      'hasCities': true,
      'cities': [
        {'cityName': 'Frankfurt', 'ping': '40 ms'},
        {'cityName': 'Berlin', 'ping': '45 ms'},
      ],
    },
    {
      'name': 'Singapore',
      'code': 'SGP',
      'flag': '🇸🇬',
      'ping': '18 ms',
      'isVip': false,
      'hasCities': false,
    },

    // --- ভিআইপি (প্রিমিয়াম) সার্ভারসমূহ ---
    {
      'name': 'Switzerland',
      'code': 'SUI',
      'flag': '🇨🇭',
      'ping': '48 ms',
      'isVip': true,
      'hasCities': false,
    },
    {
      'name': 'Australia',
      'code': 'AUS',
      'flag': '🇦🇺',
      'ping': '85 ms',
      'isVip': true,
      'hasCities': false,
    },
    {
      'name': 'United Arab Emirates',
      'code': 'UAE',
      'flag': '🇦🇪',
      'ping': '65 ms',
      'isVip': true,
      'hasCities': false,
    },
    {
      'name': 'Brazil',
      'code': 'BRA',
      'flag': '🇧🇷',
      'ping': '95 ms',
      'isVip': true,
      'hasCities': false,
    },
  ];

  // নির্দিষ্ট দেশের শহর বা জেলাগুলো সিলেক্ট করার ডায়ালগ বক্স
  void _showCitySelectionDialog(BuildContext context, Map server) {
    final List citiesList = server['cities'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1D1B2E),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Text(server['flag'], style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Select ${server['name']} City',
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: citiesList.length,
              itemBuilder: (context, index) {
                final city = citiesList[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF13111C),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                  ),
                  child: ListTile(
                    dense: true,
                    title: Text(
                      city['cityName'],
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      'Ping: ${city['ping']}',
                      style: const TextStyle(color: Color(0xFF00FF88), fontSize: 11),
                    ),
                    trailing: const Icon(Icons.bolt, color: Color(0xFF00FF88), size: 18),
                    onTap: () {
                      Navigator.pop(context); // ডায়ালগ বন্ধ হবে
                      // হোম পেজে সিলেক্টেড দেশ ও শহরের তথ্য রিটার্ন করবে
                      Navigator.pop(context, {
                        'country': server['name'],
                        'city': city['cityName'],
                        'flag': server['flag'],
                        'ping': city['ping'],
                      });
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  // ভিআইপি পেজে রিডাইরেক্ট করার ফাংশন
  void _handleVipRedirect(BuildContext context, String modeName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$modeName is a VIP Feature. Redirecting to Subscription Page...'),
        backgroundColor: Colors.amber,
        duration: const Duration(seconds: 2),
      ),
    );

    /*
    // ভবিষ্যতে যখন আপনার VipPage তৈরি হবে, তখন এই কমেন্টটি হটিয়ে নিচের কোডটি চালু করে দেবেন:
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const VipPage()),
    );
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF13111C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1D1B2E),
        title: const Text(
          'Select Server Node & Mode',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // --- সেকশন ১: স্পেশাল ভিআইপি মোডসমূহ (Gaming & Safe Mode) ---
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0, left: 4.0),
            child: Text(
              'SPECIAL VIP MODES',
              style: TextStyle(color: Colors.amber, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2),
            ),
          ),
          ...specialModes.map((mode) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12.0),
              decoration: BoxDecoration(
                color: const Color(0xFF1D1B2E),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.amber.withValues(alpha: 0.4)),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(mode['icon'], color: Colors.amber, size: 24),
                ),
                title: Text(
                  mode['name'],
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                ),
                subtitle: Text(
                  mode['subtitle'],
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.workspace_premium_rounded, color: Colors.amber, size: 20),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.amber.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.amber.withValues(alpha: 0.5)),
                      ),
                      child: const Text(
                        'VIP',
                        style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 11),
                      ),
                    ),
                  ],
                ),
                onTap: () => _handleVipRedirect(context, mode['name']),
              ),
            );
          }).toList(),

          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0, left: 4.0),
            child: Text(
              'STANDARD & VIP SERVERS',
              style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2),
            ),
          ),

          // --- সেকশন ২: আপনার মূল সার্ভার ও দেশসমূহ ---
          ...servers.map((server) {
            final bool hasCities = server['hasCities'] ?? false;
            final bool isVip = server['isVip'];

            return Container(
              margin: const EdgeInsets.only(bottom: 12.0),
              decoration: BoxDecoration(
                color: const Color(0xFF1D1B2E),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isVip ? Colors.amber.withValues(alpha: 0.3) : Colors.white.withValues(alpha: 0.06),
                ),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                leading: Text(
                  server['flag'],
                  style: const TextStyle(fontSize: 32),
                ),
                title: Text(
                  server['name'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                subtitle: Row(
                  children: [
                    Icon(
                      Icons.signal_cellular_alt_rounded,
                      color: isVip ? Colors.amber : const Color(0xFF00FF88),
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      hasCities ? '${server['ping']} • Cities Available' : server['ping'],
                      style: const TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                  ],
                ),
                trailing: isVip
                    ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.workspace_premium_rounded, color: Colors.amber, size: 22),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.amber.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.amber.withValues(alpha: 0.5)),
                      ),
                      child: const Text(
                        'VIP',
                        style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 11),
                      ),
                    ),
                  ],
                )
                    : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00FF88).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'FREE',
                    style: TextStyle(
                      color: Color(0xFF00FF88),
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
                onTap: () {
                  if (isVip) {
                    // ভিআইপি সার্ভারে ক্লিক করলে সাবস্ক্রিপশন পেজে যাবে
                    _handleVipRedirect(context, server['name']);
                  } else {
                    // ফ্রি সার্ভার হলে শহর বা জেলা সিলেক্ট করার অপশন দেখাবে
                    if (hasCities) {
                      _showCitySelectionDialog(context, server);
                    } else {
                      Navigator.pop(context, {
                        'country': server['name'],
                        'city': 'Standard Node',
                        'flag': server['flag'],
                        'ping': server['ping'],
                      });
                    }
                  }
                },
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}