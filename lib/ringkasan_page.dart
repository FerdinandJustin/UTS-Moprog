import 'package:flutter/material.dart';
import 'data.dart';
import 'pembayaran_page.dart';

class RingkasanPage extends StatelessWidget {
  final String tanggal;
  final String jam;
  const RingkasanPage({super.key, required this.tanggal, required this.jam});

  Widget judul(String teks) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(teks,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget kotak(Widget isi) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: isi,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Ringkasan Reservasi'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            judul('Jadwal Kunjungan'),
            kotak(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          color: Colors.blue, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                          child: Text(tanggal,
                              style: const TextStyle(fontSize: 16))),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.access_time,
                          color: Colors.blue, size: 20),
                      const SizedBox(width: 10),
                      Text('Pukul $jam (${totalDurasi()} menit)',
                          style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.blue, size: 20),
                      SizedBox(width: 10),
                      Expanded(
                          child: Text('Klinik Gigi Sehat, Jl. Mawar No. 10',
                              style: TextStyle(fontSize: 16))),
                    ],
                  ),
                ],
              ),
            ),
            judul('Data Pasien'),
            kotak(
              const Row(
                children: [
                  Icon(Icons.person, color: Colors.blue),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Darrell Weida Wihardi',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('darrell.825240080@stu.untar.ac.id',
                            style: TextStyle(fontSize: 13, color: Colors.grey)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            judul('Layanan Dipilih'),
            kotak(
              Column(
                children: [
                  for (int i = 0; i < keranjang.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(keranjang[i].layanan.nama,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text(keranjang[i].dokter,
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade600)),
                                if (keranjang[i].addon.isNotEmpty)
                                  Text(keranjang[i].addon.join(', '),
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey.shade600)),
                              ],
                            ),
                          ),
                          Text(formattingHarga(keranjang[i].total),
                              style: const TextStyle(fontSize: 15)),
                        ],
                      ),
                    ),
                  const Divider(),
                  Row(
                    children: [
                      const Text('Total',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      Text(formattingHarga(totalHarga()),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue)),
                    ],
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
          child: SizedBox(
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PembayaranPage(tanggal: tanggal, jam: jam),
                  ),
                );
              },
              child: const Text('Lanjut ke Pembayaran',
                  style: TextStyle(fontSize: 18)),
            ),
          ),
        ),
      ),
    );
  }
}