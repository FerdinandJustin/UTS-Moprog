import 'package:flutter/material.dart';
import 'data.dart';

class PembayaranPage extends StatefulWidget {
  final String tanggal;
  final String jam;
  const PembayaranPage({super.key, required this.tanggal, required this.jam});

  @override
  State<PembayaranPage> createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  int metode = 0;
  bool sudahBayar = false;
  int totalBayar = 0; // disimpan sebelum keranjang dikosongkan

  List<String> namaMetode = [
    'Transfer Bank (BCA)',
    'E-Wallet (GoPay)',
    'Bayar di Klinik'
  ];
  List<IconData> ikonMetode = [
    Icons.account_balance,
    Icons.account_balance_wallet,
    Icons.store
  ];

  Widget formPembayaran() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Metode Pembayaran',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          for (int i = 0; i < namaMetode.length; i++)
            GestureDetector(
              onTap: () {
                setState(() {
                  metode = i;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: metode == i ? Colors.blue.shade50 : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: metode == i ? Colors.blue : Colors.grey.shade300,
                      width: metode == i ? 2 : 1),
                ),
                child: Row(
                  children: [
                    Icon(ikonMetode[i], color: Colors.blue),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Text(namaMetode[i],
                            style: const TextStyle(fontSize: 16))),
                    Icon(
                        metode == i
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        color: metode == i ? Colors.blue : Colors.grey),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 16),
          const Text('Rincian Pembayaran',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text('Subtotal layanan'),
                    const Spacer(),
                    Text(formattingHarga(totalHarga())),
                  ],
                ),
                const SizedBox(height: 6),
                const Row(
                  children: [
                    Text('Biaya reservasi'),
                    Spacer(),
                    Text('Gratis'),
                  ],
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
    );
  }

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

  Widget konfirmasi() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(
                color: Colors.green, shape: BoxShape.circle),
            child: const Icon(Icons.check, color: Colors.white, size: 60),
          ),
          const SizedBox(height: 16),
          const Text('Reservasi Berhasil!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text('Tunjukkan kode booking saat tiba di klinik',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              children: [
                const Text('Kode Booking',
                    style: TextStyle(fontSize: 13, color: Colors.grey)),
                const Text('KLN-2026-0412',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue)),
                const Divider(height: 24),
                baris('Tanggal', widget.tanggal),
                baris('Jam', widget.jam),
                baris('Metode', namaMetode[metode]),
                baris('Total', formattingHarga(totalBayar)),
                baris('Status',
                    metode == 2 ? 'Bayar di klinik' : 'Lunas'),
              ],
            ),
          ),
        ],
      ),
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
        automaticallyImplyLeading: !sudahBayar,
        title: Text(sudahBayar ? 'Konfirmasi' : 'Pembayaran'),
      ),
      body: sudahBayar ? konfirmasi() : formPembayaran(),
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
                if (!sudahBayar) {
                  setState(() {
                    totalBayar = totalHarga();
                    sudahBayar = true;
                  });
                } else {
                  keranjang.clear();
                  // kembali ke halaman paling awal (Home)
                  Navigator.popUntil(context, (route) => route.isFirst);
                }
              },
              child: Text(sudahBayar ? 'Kembali ke Beranda' : 'Bayar Sekarang',
                  style: const TextStyle(fontSize: 18)),
            ),
          ),
        ),
      ),
    );
  }
}