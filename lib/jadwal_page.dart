import 'package:flutter/material.dart';
import 'data.dart';
import 'ringkasan_page.dart';

class JadwalPage extends StatefulWidget {
  final List<ItemKeranjang>? items;
  const JadwalPage({super.key, this.items});

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  DateTime sekarang = DateTime.now();
  int tahun = DateTime.now().year;
  int bulan = DateTime.now().month;
  // tanggalDipilih 0 = belum memilih, jamDipilih kosong = belum memilih
  int tanggalDipilih = 0;
  String jamDipilih = '';

  List<String> namaBulan = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
  ];
  List<String> namaHari = [
    'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'
  ];
  List<String> hariSingkat = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
  List<String> daftarJam = [
    '09:00', '10:00', '11:00', '13:00', '14:00', '15:00', '16:00'
  ];

  // tanggal aktif: bukan masa lalu dan bukan hari Minggu (klinik tutup)
  bool tanggalAktif(int t) {
    DateTime d = DateTime(tahun, bulan, t);
    DateTime hariIni = DateTime(sekarang.year, sekarang.month, sekarang.day);
    return !d.isBefore(hariIni) && d.weekday != 7;
  }

  bool apakahHariIni(int t) {
    return tahun == sekarang.year &&
        bulan == sekarang.month &&
        t == sekarang.day;
  }

  // slot dianggap penuh kalau (tanggal + index jam) habis dibagi 4
  bool jamPenuh(int index) {
    return (tanggalDipilih + index) % 4 == 0;
  }

  // tombol bulan sebelumnya mati kalau sudah di bulan sekarang
  bool bisaMundur() {
    return (tahun * 12 + bulan) > (sekarang.year * 12 + sekarang.month);
  }

  void bulanSebelumnya() {
    setState(() {
      bulan--;
      if (bulan < 1) {
        bulan = 12;
        tahun--;
      }
      tanggalDipilih = 0;
      jamDipilih = '';
    });
  }

  void bulanBerikutnya() {
    setState(() {
      bulan++;
      if (bulan > 12) {
        bulan = 1;
        tahun++;
      }
      tanggalDipilih = 0;
      jamDipilih = '';
    });
  }

  Widget sel(int t) {
    bool aktif = tanggalAktif(t);
    bool dipilih = tanggalDipilih == t;
    return GestureDetector(
      onTap: aktif
          ? () {
        setState(() {
          tanggalDipilih = t;
          jamDipilih = '';
        });
      }
          : null,
      child: Container(
        height: 42,
        margin: const EdgeInsets.all(2),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: dipilih ? Colors.blue : Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
              color: apakahHariIni(t) && !dipilih
                  ? Colors.blue
                  : Colors.transparent),
        ),
        child: Text('$t',
            style: TextStyle(
              fontSize: 15,
              fontWeight: dipilih ? FontWeight.bold : FontWeight.normal,
              color: dipilih
                  ? Colors.white
                  : (aktif ? Colors.black : Colors.grey.shade400),
            )),
      ),
    );
  }

  Widget kalender() {
    // DateTime(tahun, bulan + 1, 0) = hari terakhir bulan ini, jadi .day = jumlah hari
    int hariDalamBulan = DateTime(tahun, bulan + 1, 0).day;
    int offset = DateTime(tahun, bulan, 1).weekday - 1;

    List<Widget> baris = [];
    for (int minggu = 0; minggu < 6; minggu++) {
      if (minggu * 7 - offset + 1 > hariDalamBulan) {
        break;
      }
      List<Widget> kolom = [];
      for (int k = 0; k < 7; k++) {
        int t = minggu * 7 + k - offset + 1;
        if (t < 1 || t > hariDalamBulan) {
          kolom.add(const Expanded(child: SizedBox(height: 42)));
        } else {
          kolom.add(Expanded(child: sel(t)));
        }
      }
      baris.add(Row(children: kolom));
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: bisaMundur() ? bulanSebelumnya : null,
                child: Icon(Icons.chevron_left,
                    size: 32,
                    color: bisaMundur() ? Colors.blue : Colors.grey.shade300),
              ),
              Expanded(
                child: Text('${namaBulan[bulan - 1]} $tahun',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              GestureDetector(
                onTap: bulanBerikutnya,
                child:
                const Icon(Icons.chevron_right, size: 32, color: Colors.blue),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              for (int i = 0; i < 7; i++)
                Expanded(
                  child: Text(hariSingkat[i],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: i == 6 ? Colors.red : Colors.grey.shade600)),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Column(children: baris),
          const SizedBox(height: 8),
          Text('Klinik tutup hari Minggu',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        ],
      ),
    );
  }

  Widget pilihanJam() {
    if (tanggalDipilih == 0) {
      return Text('Pilih tanggal terlebih dahulu',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600));
    }
    return Wrap(
      children: [
        for (int i = 0; i < daftarJam.length; i++)
          GestureDetector(
            onTap: jamPenuh(i)
                ? null
                : () {
              setState(() {
                jamDipilih = daftarJam[i];
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8, bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: jamDipilih == daftarJam[i]
                    ? Colors.blue
                    : (jamPenuh(i) ? Colors.grey.shade200 : Colors.white),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: jamDipilih == daftarJam[i]
                        ? Colors.blue
                        : Colors.grey.shade300),
              ),
              child: Text(daftarJam[i],
                  style: TextStyle(
                    fontSize: 15,
                    decoration: jamPenuh(i) ? TextDecoration.lineThrough : null,
                    color: jamDipilih == daftarJam[i]
                        ? Colors.white
                        : (jamPenuh(i) ? Colors.grey : Colors.black),
                  )),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // tombol Lanjut baru aktif kalau tanggal dan jam sudah dipilih
    bool siap = tanggalDipilih != 0 && jamDipilih != '';
    String teksTanggal = tanggalDipilih == 0
        ? '-'
        : '${namaHari[DateTime(tahun, bulan, tanggalDipilih).weekday - 1]}, '
        '$tanggalDipilih ${namaBulan[bulan - 1]} $tahun';

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Pilih Jadwal'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Estimasi durasi: ${totalDurasi(widget.items)} menit',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
            const SizedBox(height: 12),
            const Text('Pilih Tanggal',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            kalender(),
            const SizedBox(height: 20),
            const Text('Pilih Jam',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            pilihanJam(),
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
                    Text(teksTanggal,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    Text(jamDipilih == '' ? 'Jam belum dipilih' : 'Pukul $jamDipilih',
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey.shade600)),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  foregroundColor: Colors.white,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: siap
                    ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RingkasanPage(
                          tanggal: teksTanggal, jam: jamDipilih, items: widget.items),
                    ),
                  );
                }
                    : null,
                child: const Text('Lanjut', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}