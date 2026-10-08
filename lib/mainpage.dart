import 'package:flutter/material.dart';
import 'colors.dart';
import 'homepage.dart';
import 'profilepage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    Widget halaman;
    if (index == 0) {
      halaman = const HomePage();
    } else if (index == 4) {
      halaman = const ProfilePage();
    } else {
      halaman = const Center(child: Text('Halaman belum dibuat'));
    }

    return Scaffold(
      body: halaman,
      bottomNavigationBar: bottomBar(),
    );
  }

  Widget bottomBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 75,
          child: Row(
            children: [
              navItem(0, Icons.home_rounded, 'Home'),
              navItem(1, Icons.paid_rounded, 'Finance'),
              // tombol QRIS tengah
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFF7B4DEB), ungu],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'QRIS',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text('Pay',
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              navItem(3, Icons.notifications_rounded, 'Inbox'),
              navItem(4, Icons.account_circle_rounded, 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  Widget navItem(int i, IconData icon, String label) {
    bool aktif = index == i;
    Color warna = aktif ? ungu : Colors.grey;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            index = i;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: warna, size: 30),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: warna,
                fontWeight: aktif ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}