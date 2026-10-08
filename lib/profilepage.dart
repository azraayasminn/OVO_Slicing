import 'package:flutter/material.dart';
import 'colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool fingerprint = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 40, 16, 20),
            child: Text('Profile',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800)),
          ),
          kartuProfil(),
          const SizedBox(height: 14),
          loyaltyButton(),
          const SizedBox(height: 24),

          // ---------- Akun ----------
          judul('Akun'),
          baris(
            const Icon(Icons.workspace_premium_outlined,
                color: Color(0xFFF5A623), size: 28),
            'OVO Club',
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: unguTombol,
                foregroundColor: Colors.white,
                shape: const StadiumBorder(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              ),
              child: const Text('Upgrade',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          baris(
            lingkaranHitam(const Text('P',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16))),
            'OVO Points',
            panah(),
          ),
          baris(
            lingkaranHitam(
                const Icon(Icons.star_rounded, color: Colors.white, size: 18)),
            'OVO Stamp',
            null,
          ),
          baris(const Icon(Icons.link_rounded, size: 28), 'Aplikasi Terhubung',
              panah()),
          pemisah(),

          // ---------- Bantuan ----------
          judul('Bantuan'),
          baris(
            lingkaranHitam(const Icon(Icons.question_mark_rounded,
                color: Colors.white, size: 18)),
            'Pusat Bantuan',
            panah(),
          ),
          pemisah(),

          // ---------- Keamanan ----------
          judul('Keamanan'),
          baris(const Icon(Icons.lock_rounded, size: 28), 'Ubah Security Code',
              panah()),
          baris(
            const Icon(Icons.fingerprint_rounded, size: 30),
            'Fingerprint',
            Switch(
              value: fingerprint,
              activeColor: unguTombol,
              onChanged: (nilai) {
                setState(() {
                  fingerprint = nilai;
                });
              },
            ),
          ),
          pemisah(),

          // ---------- Tentang ----------
          judul('Tentang'),
          baris(const Icon(Icons.workspace_premium_rounded, size: 28),
              'Keuntungan Pakai OVO', panah()),
          baris(const Icon(Icons.lightbulb_rounded, size: 28), 'Panduan OVO',
              panah()),
          baris(const Icon(Icons.list_alt_rounded, size: 28),
              'Syarat dan Ketentuan', panah()),
          baris(const Icon(Icons.verified_user_rounded, size: 28),
              'Kebijakan Privasi', panah()),

          footer(),
        ],
      ),
    );
  }

  // ---------- Kartu profil ----------
  Widget kartuProfil() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 31,
            backgroundColor: Color(0xFFE3DDF7),
            child: Icon(Icons.person_rounded, color: unguTombol, size: 34),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Azra Yasmin',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                SizedBox(height: 4),
                Text('082228140295', style: TextStyle(fontSize: 15)),
              ],
            ),
          ),
          Text('Ubah',
              style: TextStyle(
                  color: Color(0xFF1565C0), fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget loyaltyButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 70,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.view_week_rounded, size: 36),
          SizedBox(width: 12),
          Text('Loyalty Code',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }

  // ---------- Versi + Sign Out ----------
  Widget footer() {
    return Container(
      color: const Color(0xFFF3F3F3),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Version 3.170.0 (600)',
                  style: TextStyle(color: Colors.black54)),
              Text('#pakeOVOaja', style: TextStyle(color: Colors.black54)),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: unguTombol,
                foregroundColor: Colors.white,
                shape: const StadiumBorder(),
              ),
              child: const Text('Sign Out',
                  style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- Helper kecil ----------
  Widget judul(String teks) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Text(teks,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
    );
  }

  Widget pemisah() {
    return Container(
      height: 14,
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: const Color(0xFFF3F3F3),
    );
  }

  Widget panah() {
    return const Icon(Icons.chevron_right_rounded,
        size: 28, color: Colors.black87);
  }

  Widget lingkaranHitam(Widget isi) {
    return Container(
      width: 30,
      height: 30,
      decoration:
          const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
      child: Center(child: isi),
    );
  }

  Widget baris(Widget ikon, String teks, Widget? kanan) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          SizedBox(width: 32, child: Center(child: ikon)),
          const SizedBox(width: 24),
          Text(teks,
              style:
                  const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
          const Spacer(),
          if (kanan != null) kanan,
        ],
      ),
    );
  }
}