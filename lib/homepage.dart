import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tabAktif = 0;
  bool collapsed = false; // true kalau halaman sudah di-scroll ke bawah
  bool kenaliTerbuka = true; // untuk tombol Tutup/Buka
  bool saldoDisembunyikan = false; // true kalau saldo disembunyikan (ikon mata)
  final int saldo = 0; // nominal saldo
  final ScrollController scrollController = ScrollController();
  final List<String> tabs = ['Favorit', 'Finansial', 'Hiburan', 'Pilihan Lain'];

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      double posisi = scrollController.offset;
      if (!collapsed && posisi > 30) {
        setState(() {
          collapsed = true;
        });
      } else if (collapsed && posisi <= 0) {
        setState(() {
          collapsed = false;
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFD9D3F4), Color(0xFFC9D2F3)],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            header(),
            kartuSaldo(),
            const SizedBox(height: 16),
            Expanded(child: sheetPutih(context)),
          ],
        ),
      ),
    );
  }

  // ---------- Logo OVO + tombol Promo ----------
  Widget header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo OVO dari file di folder assets
          Image.asset(
            'assets/logo_ovo.png',
            height: 36,
            fit: BoxFit.contain,
            // Kalau file tidak ketemu, pakai logo gambar manual
            errorBuilder: (context, error, stackTrace) => const SizedBox(
              width: 110,
              height: 36,
              child: CustomPaint(painter: OvoLogoPainter(color: ungu)),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0x8CB9ADEE), // ungu muda semi-transparan
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                SizedBox(
                  width: 28,
                  height: 28,
                  child: CustomPaint(painter: PromoBadgePainter(color: ungu)),
                ),
                SizedBox(width: 10),
                Text('Promo',
                    style: TextStyle(
                        color: ungu,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //  Kartu saldo 
  Widget kartuSaldo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color.fromARGB(255, 140, 105, 229), Color.fromARGB(255, 72, 37, 162)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // "OVO" tebal + "Cash" lebih tipis
          RichText(
            text: const TextSpan(
              style: TextStyle(color: Colors.white, fontSize: 18),
              children: [
                TextSpan(
                    text: 'OVO ',
                    style: TextStyle(fontWeight: FontWeight.w800)),
                TextSpan(
                    text: 'Cash',
                    style: TextStyle(fontWeight: FontWeight.w400)),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Text('Total Saldo',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              const SizedBox(width: 6),
              // Ikon mata: pencet untuk sembunyikan / tampilkan saldo
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    saldoDisembunyikan = !saldoDisembunyikan;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    saldoDisembunyikan
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // "Rp" kecil, "0" besar
              saldoDisembunyikan
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          saldoDisembunyikan = false;
                        });
                      },
                      child: const Text('Tap untuk melihat',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16)),
                    )
                  : RichText(
                      text: TextSpan(
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        children: [
                          const TextSpan(
                              text: 'Rp ', style: TextStyle(fontSize: 14)),
                          TextSpan(
                            text: '$saldo',
                            style: const TextStyle(fontSize: 26),
                          ),
                        ],
                      ),
                    ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Row(
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: unguTombol,
                      child: Text('P',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                    ),
                    SizedBox(width: 8),
                    Text('OVO Points',
                        style: TextStyle(
                            color: unguTombol,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                    SizedBox(width: 4),
                    Icon(Icons.chevron_right, color: Colors.grey, size: 22),
                  ],
                ),
              ),
            ],
          ),
          // Baris aksi: hilang dengan animasi saat collapsed
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: collapsed
                ? const SizedBox(width: double.infinity)
                : Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        aksiSaldo(
                          const Icon(Icons.add_circle_rounded,
                              color: Colors.white, size: 38),
                          'Top Up',
                        ),
                        aksiSaldo(
                          const Icon(Icons.arrow_circle_up_rounded,
                              color: Colors.white, size: 38),
                          'Transfer',
                        ),
                        aksiSaldo(
                          const SizedBox(
                            width: 38,
                            height: 38,
                            child: CustomPaint(painter: AtmIconPainter()),
                          ),
                          'Tarik Tunai',
                        ),
                        aksiSaldo(
                          Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.menu_rounded,
                                color: unguTombol, size: 24),
                          ),
                          'History',
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget aksiSaldo(Widget ikon, String label) {
    return Column(
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: Center(child: ikon),
        ),
        const SizedBox(height: 8),
        Text(label,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15)),
      ],
    );
  }

  //  Sheet putih 
  Widget sheetPutih(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: ListView(
        controller: scrollController,
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
        children: [
          SizedBox(
            height: 170,
            child: bannerUpgrade(double.infinity),
          ),
          const SizedBox(height: 20),
          tabRow(),
          const SizedBox(height: 16),
          menuGrid(),
          const SizedBox(height: 16),
          Container(height: 6, color: const Color(0xFFF3F3F3)),
          const SizedBox(height: 20),
          kenaliSection(),
          const SizedBox(height: 20),
          Container(height: 6, color: const Color(0xFFF3F3F3)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  //  Banner upgrade 
  Widget bannerUpgrade(double lebar) {
    return Container(
      width: lebar,
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFE08A),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.workspace_premium_rounded,
                    color: unguTombol, size: 32),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  'Yuk, upgrade ke OVO Premier! Nikmatin akses dan benefit lengkap dari OVO!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ],
          ),
          const Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: unguTombol,
                foregroundColor: Colors.white,
                shape: const StadiumBorder(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              ),
              child: const Text('Upgrade',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  //  Tab kategori 
  Widget tabRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(tabs.length, (i) {
          bool aktif = tabAktif == i;
          return GestureDetector(
            onTap: () {
              setState(() {
                tabAktif = i;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              decoration: BoxDecoration(
                color: aktif ? const Color(0xFFF1EFF8) : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                tabs[i],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: aktif ? ungu : Colors.black54,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  //  Grid menu 
  Widget menuGrid() {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 0.78,
      mainAxisSpacing: 8,
      crossAxisSpacing: 4,
      children: [
        menu('Nabung by\nSuperbank', Icons.savings_rounded,
            const Color(0xFF7B4DEB), const Color(0xFFEEE9FC), 'BARU'),
        menu('Pinjaman', Icons.request_quote_rounded, const Color(0xFF5B2BD9),
            const Color(0xFFEEE9FC), '100JT'),
        menu('Uang Elektronik', Icons.contactless_rounded,
            const Color(0xFFF26B21), const Color(0xFFFEEFE6), 'Rp 1'),
        menu('Angsuran Kredit', Icons.receipt_long_rounded,
            const Color(0xFFE5457A), const Color(0xFFFCE8EF), null),
        menu('Pulsa/Paket\nData', Icons.phone_android_rounded,
            const Color(0xFF2F6FED), const Color(0xFFE8EFFD), 'PROMO'),
        menu('PLN', Icons.bolt_rounded, const Color(0xFFF5A623),
            const Color(0xFFFEF3E0), 'PROMO'),
        menu('Air PDAM', Icons.water_drop_rounded, const Color(0xFF1E9BE8),
            const Color(0xFFE3F3FD), null),
        menu('Internet & TV\nKabel', Icons.live_tv_rounded,
            const Color(0xFFF26B21), const Color(0xFFFEEFE6), null),
      ],
    );
  }

  Widget menu(String label, IconData icon, Color warna, Color latar,
      String? badge) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: 66,
              height: 66,
              decoration: BoxDecoration(shape: BoxShape.circle, color: latar),
              child: Icon(icon, color: warna, size: 32),
            ),
            if (badge != null)
              Positioned(
                top: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE53935),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(badge,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold)),
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        Text(label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
      ],
    );
  }

  //  Kenali OVO Lebih Dekat 
  Widget kenaliSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Text('Kenali OVO Lebih Dekat',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  kenaliTerbuka = !kenaliTerbuka;
                });
              },
              child: Text(
                kenaliTerbuka ? 'Tutup' : 'Buka',
                style: const TextStyle(
                  color: Color(0xFF1565C0),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text('Biar makin akrab, yuk cek tips berikut!',
            style: TextStyle(color: Colors.black54, fontSize: 15)),
        if (kenaliTerbuka) ...[
          const SizedBox(height: 16),
          SizedBox(
            height: 140,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                tipCard('Cara top up saldo OVO dengan mudah',
                    const Color(0xFF5B3FD0), Icons.add_card_rounded),
                tipCard('Kirim uang ke teman tanpa biaya',
                    const Color(0xFF2F6FED), Icons.send_rounded),
                tipCard('Upgrade ke OVO Premier untuk benefit lengkap',
                    const Color(0xFFE5457A), Icons.workspace_premium_rounded),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget tipCard(String teks, Color warna, IconData ikon) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: warna,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(ikon, color: Colors.white, size: 36),
          const Spacer(),
          Text(teks,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
        ],
      ),
    );
  }

  Widget promoBox(String teks, Color warna1, Color warna2) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(colors: [warna1, warna2]),
      ),
      child: Center(
        child: Text(teks,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
      ),
    );
  }
}


//  Painter logo OVO 
// Huruf O-V-O membulat dengan efek garis ganda (outline berongga).
class OvoLogoPainter extends CustomPainter {
  final Color color;
  const OvoLogoPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    // Ukuran desain 110 x 36, diskalakan mengikuti ukuran widget
    canvas.scale(size.width / 110, size.height / 36);

    final path = Path()
      // O pertama
      ..addOval(const Rect.fromLTWH(3, 4, 32, 28))
      // V
      ..moveTo(42, 6)
      ..lineTo(56, 30)
      ..lineTo(70, 6)
      // O kedua
      ..addOval(const Rect.fromLTWH(75, 4, 32, 28));

    // Layer terpisah supaya bagian tengah garis bisa "dilubangi"
    canvas.saveLayer(const Rect.fromLTWH(0, 0, 110, 36), Paint());

    // Garis tebal berwarna ungu
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 7
        ..strokeJoin = StrokeJoin.round
        ..strokeCap = StrokeCap.round
        ..color = color,
    );

    // Garis lebih tipis dihapus dari tengah => tampak seperti dua garis
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeJoin = StrokeJoin.round
        ..strokeCap = StrokeCap.round
        ..blendMode = BlendMode.clear,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant OvoLogoPainter old) => old.color != color;
}



//  Painter ikon Promo 
// Lencana bergerigi (rosette) dengan tanda persen "berlubang" di tengah.
class PromoBadgePainter extends CustomPainter {
  final Color color;
  const PromoBadgePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    // Ukuran desain 26 x 26, diskalakan mengikuti ukuran widget
    canvas.scale(size.width / 26, size.height / 26);

    // Bentuk lencana bergerigi: radius bergelombang 10 kali mengelilingi pusat
    const int gerigi = 10;
    final path = Path();
    for (int i = 0; i <= 240; i++) {
      final sudut = 2 * math.pi * i / 240;
      final r = 10.6 + 1.5 * math.cos(gerigi * sudut);
      final x = 13 + r * math.cos(sudut);
      final y = 13 + r * math.sin(sudut);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    // Layer terpisah supaya tanda persen bisa "dilubangi" (tembus pandang)
    canvas.saveLayer(const Rect.fromLTWH(0, 0, 26, 26), Paint());

    canvas.drawPath(path, Paint()..color = color);

    final lubang = Paint()
      ..blendMode = BlendMode.clear
      ..style = PaintingStyle.fill;

    // Dua lingkaran kecil
    canvas.drawCircle(const Offset(9.6, 9.6), 2.1, lubang);
    canvas.drawCircle(const Offset(16.4, 16.4), 2.1, lubang);

    // Garis miring
    canvas.drawLine(
      const Offset(16.8, 8.6),
      const Offset(9.2, 17.4),
      Paint()
        ..blendMode = BlendMode.clear
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.2
        ..strokeCap = StrokeCap.round,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant PromoBadgePainter old) => old.color != color;
}



//  Painter ikon Tarik Tunai (mesin ATM) 
class AtmIconPainter extends CustomPainter {
  const AtmIconPainter();

  @override
  void paint(Canvas canvas, Size size) {
    // Ukuran desain 36 x 36, diskalakan mengikuti ukuran widget
    canvas.scale(size.width / 36, size.height / 36);

    // Badan mesin: atas lebih sempit, bawah lebih lebar
    final badan = Path()
      ..moveTo(11, 5)
      ..lineTo(25, 5)
      ..lineTo(31, 22)
      ..lineTo(31, 31)
      ..lineTo(5, 31)
      ..lineTo(5, 22)
      ..close();

    canvas.saveLayer(const Rect.fromLTWH(0, 0, 36, 36), Paint());

    final putih = Paint()..color = Colors.white;

    // Isi + garis tepi tebal supaya sudutnya membulat
    canvas.drawPath(badan, putih);
    canvas.drawPath(
      badan,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..strokeJoin = StrokeJoin.round,
    );

    final lubang = Paint()..blendMode = BlendMode.clear;

    // Layar (tembus pandang)
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          const Rect.fromLTWH(10, 13, 16, 12), const Radius.circular(3)),
      lubang,
    );

    // Celah kartu di bagian bawah
    canvas.drawLine(
      const Offset(11, 28.2),
      const Offset(25, 28.2),
      Paint()
        ..blendMode = BlendMode.clear
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6
        ..strokeCap = StrokeCap.round,
    );

    // Panah ke bawah di dalam layar
    final panah = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawLine(const Offset(18, 15.5), const Offset(18, 22), panah);
    canvas.drawPath(
      Path()
        ..moveTo(14.8, 19)
        ..lineTo(18, 22.2)
        ..lineTo(21.2, 19),
      panah,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant AtmIconPainter old) => false;
}