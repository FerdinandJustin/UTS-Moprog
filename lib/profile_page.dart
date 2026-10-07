import 'package:flutter/material.dart';
import 'data.dart';
import 'splash_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool notifikasi = true;

  // data dummy pengguna
  String nama = 'Budi Santoso';
  String email = 'budi@email.com';
  String telepon = '0812-3456-7890';

  // satu baris menu (ikon, teks, panah)
  Widget menu(IconData ikon, String teks) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$teks belum tersedia')),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(ikon, color: Colors.blue),
            const SizedBox(width: 12),
            Expanded(
                child: Text(teks, style: const TextStyle(fontSize: 16))),
            Icon(Icons.chevron_right, color: Colors.grey.shade600),
          ],
        ),
      ),
    );
  }

  // satu baris info (label di kiri, isi di kanan)
  Widget baris(String label, String nilai) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: Colors.grey.shade600)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(nilai,
                textAlign: TextAlign.right,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget judul(String teks) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(teks,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Akun Saya'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // foto profil + nama
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade900,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        color: Colors.blue.shade800, shape: BoxShape.circle),
                    child: const Icon(Icons.person,
                        color: Colors.white, size: 50),
                  ),
                  const SizedBox(height: 10),
                  Text(nama,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text(email,
                      style: TextStyle(
                          fontSize: 14, color: Colors.blue.shade100)),
                ],
              ),
            ),

            judul('Informasi Pribadi'),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  baris('Nama', nama),
                  baris('Email', email),
                  baris('No. Telepon', telepon),
                  baris('Di keranjang', '${keranjang.length} layanan'),
                ],
              ),
            ),

            judul('Pengaturan'),
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  const Icon(Icons.notifications, color: Colors.blue),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text('Pengingat jadwal',
                        style: TextStyle(fontSize: 16)),
                  ),
                  Switch(
                    value: notifikasi,
                    activeThumbColor: Colors.blue.shade900,
                    onChanged: (bool nilai) {
                      setState(() {
                        notifikasi = nilai;
                      });
                    },
                  ),
                ],
              ),
            ),
            menu(Icons.history, 'Riwayat Reservasi'),
            menu(Icons.favorite, 'Layanan Favorit'),
            menu(Icons.help_outline, 'Bantuan'),

            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const SplashPage()),
                        (route) => false,
                  );
                },
                child: const Text('Keluar', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}