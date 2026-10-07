import 'package:flutter/material.dart';
import 'home_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  // pindah ke Beranda, splash dihapus supaya tidak bisa dibalikin dengan tombol back
  void masukKeHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Gambar background full 1 layar & otomatis melebar/menyesuaikan ukuran layar
          Image.asset(
            'assets/gigi.png',
            fit: BoxFit.cover,
          ),

          // 2. Efek fade (gradient overlay) supaya teks & tombol mudah dibaca
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue.withOpacity(0.3),
                  Colors.blue.shade900.withOpacity(0.85),
                ],
              ),
            ),
          ),

          // 3. Konten Teks & Tombol di atas gambar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Spacer(),

                  // logo
                  const Icon(Icons.local_hospital, color: Colors.white, size: 80),
                  const SizedBox(height: 8),
                  const Text('DentEase',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  Text('Healthy Smile, Brighter You',
                      style: TextStyle(fontSize: 16, color: Colors.blue.shade100)),

                  const Spacer(flex: 2),

                  // tombol mulai
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue.shade900,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        masukKeHome(context);
                      },
                      child: const Text('Mulai Sekarang',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // teks "sudah punya akun"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Sudah punya akun? ',
                          style: TextStyle(color: Colors.white70)),
                      GestureDetector(
                        onTap: () {
                          masukKeHome(context);
                        },
                        child: const Text('Masuk',
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}