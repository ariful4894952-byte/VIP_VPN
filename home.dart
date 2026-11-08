import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'servers.dart'; // সার্ভার পেজের সাথে কানেক্ট করার জন্য

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  bool isConnected = false;
  bool isConnecting = false;
  int _currentIndex = 0;
  late AnimationController _animationController;

  // সিলেক্ট করা সার্ভার ডেটা ট্র্যাক করার জন্য
  String selectedCountry = 'Bangladesh';
  String selectedCity = 'Standard Node';
  String selectedFlag = '🇧🇩';
  String selectedPing = '24 ms';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void toggleConnection() {
    setState(() {
      isConnecting = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isConnecting = false;
        isConnected = !isConnected;
      });
    });
  }

  // --- ট্যাব অনুযায়ী পেজ পরিবর্তন করার লজিক ---
  Widget _buildBodyContent() {
    if (_currentIndex == 0) {
      // ১. হোম ট্যাব (মূল ভিপিএন কানেক্ট স্ক্রিন)
      return Stack(
        children: [
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Opacity(
              opacity: 0.12,
              child: Container(
                height: 320,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/world_map.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // টপ বার
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: (isConnected ? Colors.greenAccent : Colors.redAccent).withOpacity(0.15),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: (isConnected ? Colors.greenAccent : Colors.redAccent).withOpacity(0.4),
                              ),
                            ),
                            child: Icon(
                              isConnected ? Icons.lock_rounded : Icons.lock_open_rounded,
                              color: isConnected ? Colors.greenAccent : Colors.redAccent,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isConnected ? 'YOU ARE PROTECTED' : 'YOU ARE UNPROTECTED',
                                style: TextStyle(
                                  color: isConnected ? Colors.greenAccent : const Color(0xFFFF4D4D),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '$selectedCountry · $selectedCity ($selectedPing)',
                                style: const TextStyle(color: Colors.white54, fontSize: 11, letterSpacing: 0.5),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.person_outline, color: Colors.white70, size: 20),
                          onPressed: () {
                            setState(() {
                              _currentIndex = 3; // প্রোফাইল ট্যাবে নিয়ে যাবে
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // গোল্ডেন প্রিমিয়াম সাবস্ক্রিপশন কার্ড
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1D1B2E), Color(0xFF141221)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.amber.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.workspace_premium, color: Colors.black87, size: 20),
                        ),
                        const SizedBox(width: 14),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Get VIP VPN Subscription',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Unlock all ultra-fast gaming servers',
                                style: TextStyle(color: Colors.white54, fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded, color: Colors.amber, size: 14),
                      ],
                    ),
                  ),

                  // মেইন অ্যানিমেটেড কানেক্ট বাটন
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: toggleConnection,
                            child: AnimatedBuilder(
                              animation: _animationController,
                              builder: (context, child) {
                                return Container(
                                  height: 155,
                                  width: 155,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: isConnected
                                          ? [const Color(0xFF00B09B), const Color(0xFF96C93D)]
                                          : [const Color(0xFF5352ED), const Color(0xFF70a1ff)],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: (isConnected ? const Color(0xFF00B09B) : const Color(0xFF5352ED))
                                            .withOpacity(0.3 + (_animationController.value * 0.2)),
                                        blurRadius: 22 + (_animationController.value * 10),
                                        spreadRadius: 6,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Container(
                                      height: 130,
                                      width: 130,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFF13111C),
                                      ),
                                      child: Icon(
                                        Icons.power_settings_new_rounded,
                                        size: 60,
                                        color: isConnected ? Colors.greenAccent : Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          isConnecting
                              ? 'ESTABLISHING SECURE TUNNEL...'
                              : (isConnected ? 'CONNECTED TO FASTEST SERVER' : 'TAP TO SECURE CONNECTION'),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // সার্ভার সিলেকশন কার্ড (যেখান থেকে সার্ভার পেজে যাওয়া যাবে)
                  GestureDetector(
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ServerPage()),
                      );
                      if (result != null && result is Map) {
                        setState(() {
                          selectedCountry = result['country'];
                          selectedCity = result['city'];
                          selectedFlag = result['flag'];
                          selectedPing = result['ping'];
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1D1B2E),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white.withOpacity(0.06)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(selectedFlag, style: const TextStyle(fontSize: 28)),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    selectedCountry,
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Ping: $selectedPing · $selectedCity',
                                    style: const TextStyle(color: Colors.white54, fontSize: 11),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white54, size: 16),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ); // <--- এখানে Stack-এর ঠিক পরেই সঠিকভাবে ব্র্যাকেট ও সেমিকোলন ( ); ) দেওয়া হয়েছে।
    } else if (_currentIndex == 1) {
      // ২. দেশ বা সার্ভার লিস্ট ট্যাব
      return const ServerPage();
    } else if (_currentIndex == 2) {
      // ৩. মোড বা প্রফাইল অপশন
      return const Center(
        child: Text(
          'Special Modes & Features',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      );
    } else {
      // ৪. নতুন প্রোফাইল পেজ (ইউজারের জিমেইল ও ডিটেইলস সহ)
      final User? user = FirebaseAuth.instance.currentUser;
      String userEmail = user?.email ?? 'ariful.developer@gmail.com';
      String userName = user?.displayName ?? 'Md Ariful';

      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            // প্রোফাইল এভেতার বা লোগো
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF5352ED), Color(0xFF70a1ff)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF5352ED).withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Center(
                child: Icon(Icons.person_rounded, size: 50, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            // ইউজারের নাম
            Text(
              userName,
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            // ইউজারের জিমেইল
            Text(
              userEmail,
              style: const TextStyle(color: Colors.white54, fontSize: 13),
            ),
            const SizedBox(height: 30),

            // প্রফাইল ডিটেইলস কার্ড
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1D1B2E),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.06)),
              ),
              child: Column(
                children: [
                  const ListTile(
                    leading: Icon(Icons.workspace_premium, color: Colors.amber),
                    title: Text('Subscription Status', style: TextStyle(color: Colors.white, fontSize: 14)),
                    trailing: Text('Free Plan', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                  ),
                  const Divider(color: Colors.white10, height: 1),
                  const ListTile(
                    leading: Icon(Icons.security, color: Color(0xFF00FF88)),
                    title: Text('Account Security', style: TextStyle(color: Colors.white, fontSize: 14)),
                    trailing: Text('Protected', style: TextStyle(color: Color(0xFF00FF88), fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            const Spacer(),

            // লগআউট বাটন
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pop(context); // লগইন পেজে ফিরিয়ে নেওয়ার জন্য
                },
                icon: const Icon(Icons.logout_rounded, color: Colors.white),
                label: const Text('Log Out', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent.withOpacity(0.8),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF13111C),
      body: _buildBodyContent(),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF100E17),
          border: Border(top: BorderSide(color: Colors.white10, width: 0.5)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF70a1ff),
          unselectedItemColor: Colors.white54,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.public),
              label: 'Countries',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_rounded),
              label: 'Profiles',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}