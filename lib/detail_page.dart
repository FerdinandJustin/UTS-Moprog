import 'package:flutter/material.dart';
import 'data.dart';
import 'jadwal_page.dart';

class DetailPage extends StatefulWidget {
  final Layanan layanan;
  const DetailPage({super.key, required this.layanan});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int dokterDipilih = 0;
  List<bool> addonDipilih = [false, false, false];

  int hargaTotal() {
    int hasil = widget.layanan.harga;
    for (int i = 0; i < addonDipilih.length; i++) {
      if (addonDipilih[i]) {
        hasil = hasil + hargaAddon[i];
      }
    }
    return hasil;
  }

  void tambahKeKeranjang() {
    List<String> addon = [];
    for (int i = 0; i < addonDipilih.length; i++) {
      if (addonDipilih[i]) {
        addon.add(namaAddon[i]);
      }
    }
    keranjang.add(ItemKeranjang(
        widget.layanan, daftarDokter[dokterDipilih], addon, hargaTotal()));
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
    Layanan l = widget.layanan;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Detail Layanan'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.blue.shade50,
              child: Image.asset(
                l.gambar,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  return Icon(l.ikon, color: Colors.blue, size: 90);
                },
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l.nama,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(formattingHarga(l.harga),
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            const Icon(Icons.access_time,
                                size: 16, color: Colors.blue),
                            const SizedBox(width: 4),
                            Text('${l.durasi} menit',
                                style: const TextStyle(color: Colors.blue)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  judul('Deskripsi'),
                  Text(l.deskripsi,
                      style: TextStyle(
                          fontSize: 15, color: Colors.grey.shade700)),
                  judul('Pilih Dokter'),
                  for (int i = 0; i < daftarDokter.length; i++)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          dokterDipilih = i;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: dokterDipilih == i
                              ? Colors.blue.shade50
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: dokterDipilih == i
                                  ? Colors.blue
                                  : Colors.grey.shade300,
                              width: dokterDipilih == i ? 2 : 1),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.person, color: Colors.blue),
                            const SizedBox(width: 10),
                            Expanded(
                                child: Text(daftarDokter[i],
                                    style: const TextStyle(fontSize: 16))),
                            if (dokterDipilih == i)
                              const Icon(Icons.check_circle,
                                  color: Colors.blue),
                          ],
                        ),
                      ),
                    ),
                  judul('Kustomisasi (Opsional)'),
                  for (int i = 0; i < namaAddon.length; i++)
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      activeColor: Colors.blue,
                      value: addonDipilih[i],
                      title: Text(namaAddon[i]),
                      subtitle: Text('+ ${formattingHarga(hargaAddon[i])}'),
                      onChanged: (bool? nilai) {
                        setState(() {
                          addonDipilih[i] = nilai!;
                        });
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        color: Colors.white,
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total',
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey.shade600)),
                    Text(formattingHarga(hargaTotal()),
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue)),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    tambahKeKeranjang();
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('${l.nama} ditambahkan ke keranjang')),
                  );
                },
                child: const Icon(Icons.add_shopping_cart),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  tambahKeKeranjang();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const JadwalPage()),
                  );
                },
                child: const Text('Reservasi', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}