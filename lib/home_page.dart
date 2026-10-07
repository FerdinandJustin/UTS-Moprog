import 'package:flutter/material.dart';
import 'data.dart';
import 'detail_page.dart';
import 'keranjang_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bool> love = [false, false, false, false, false];

  void bukaDetail(Layanan l) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailPage(layanan: l)),
    ).then((_) {
      setState(() {}); // refresh badge keranjang
    });
  }

  void bukaKeranjang() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const KeranjangPage()),
    ).then((_) {
      setState(() {});
    });
  }

  Widget cardLayanan(int i, double ukuranGambar) {
    Layanan l = daftarLayanan[i];
    return GestureDetector(
      onTap: () {
        bukaDetail(l);
      },
      onDoubleTap: () {
        setState(() {
          love[i] = !love[i];
        });
      },
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Container(
              width: ukuranGambar,
              height: ukuranGambar,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                l.gambar,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  return Icon(l.ikon, color: Colors.blue, size: 40);
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l.nama,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Icon(Icons.access_time,
                          size: 14, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Text('${l.durasi} menit',
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade600)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(formattingHarga(l.harga),
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(love[i] ? Icons.favorite : Icons.favorite_border,
                          size: 18, color: love[i] ? Colors.red : Colors.grey),
                      const Spacer(),
                      const Text('Lihat detail',
                          style: TextStyle(fontSize: 13, color: Colors.blue)),
                      const Icon(Icons.chevron_right,
                          size: 18, color: Colors.blue),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallWidth = screenWidth < 600;
    final double ukuranGambar = isSmallWidth ? 100 : 90;
    final double lebarCard =
    isSmallWidth ? screenWidth - 12 : (screenWidth - 12) / 2;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.blue,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.local_hospital,
                      color: Colors.white, size: 35),
                  const SizedBox(width: 8),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Klinik Gigi Sehat',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      Text('Reservasi mudah, senyum cerah',
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.search, color: Colors.white, size: 30),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(6),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.sentiment_satisfied_alt,
                              color: Colors.blue, size: 40),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Pilih layanan, tentukan jadwal, dan datang tanpa antre.',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(6),
                      child: Text('Daftar Layanan',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text('Ketuk untuk detail, ketuk 2x untuk favorit',
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade600)),
                    ),
                    Wrap(
                      children: [
                        for (int i = 0; i < daftarLayanan.length; i++)
                          SizedBox(
                              width: lebarCard,
                              child: cardLayanan(i, ukuranGambar)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (int index) {
          if (index == 1) {
            bukaKeranjang();
          }
          if (index == 2) { // BARU
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          }

        },
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.shopping_cart),
                if (keranjang.isNotEmpty)
                  Positioned(
                    right: -6,
                    top: -4,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                      child: Text('${keranjang.length}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 9)),
                    ),
                  ),
              ],
            ),
            label: 'Keranjang',
          ),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Akun'),
        ],
      ),
    );
  }
}