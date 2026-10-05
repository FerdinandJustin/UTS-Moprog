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
      backgroundColor: Colors.blue.shade50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),

              // logo
              const Icon(Icons.local_hospital, color: Colors.blue, size: 80),
              const SizedBox(height: 8),
              const Text('DentEase',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue)),
              Text('Healthy Smile, Brighter You',
                  style: TextStyle(fontSize: 16, color: Colors.blue.shade400)),

              const Spacer(),

              // gambar gigi (pakai ikon dulu, nanti bisa diganti Image.asset)
              Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.sentiment_satisfied_alt,
                    color: Colors.white, size: 140),
              ),

              const Spacer(),

              // tombol mulai
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    masukKeHome(context);
                  },
                  child: const Text('Mulai Sekarang',
                      style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 12),

              // teks "sudah punya akun" (tanpa login, langsung ke Beranda juga)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Sudah punya akun? ',
                      style: TextStyle(color: Colors.grey.shade600)),
                  GestureDetector(
                    onTap: () {
                      masukKeHome(context);
                    },
                    child: const Text('Masuk',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}