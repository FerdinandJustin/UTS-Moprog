class Layanan {
  final String nama;
  final String deskripsi;
  final String gambar;
  final int harga;
  final int durasi; // menit

  const Layanan(this.nama, this.deskripsi, this.gambar, this.harga, this.durasi);
}

// satu item di keranjang: layanan + dokter + add-on yang dipilih + total harganya
class ItemKeranjang {
  final Layanan layanan;
  final String dokter;
  final List<String> addon;
  final int total;

  ItemKeranjang(this.layanan, this.dokter, this.addon, this.total);
}

// data dummy layanan
const List<Layanan> daftarLayanan = [
  Layanan(
      'Scaling & Cleaning',
      'Pembersihan karang gigi dan plak agar gigi bersih, napas segar, dan gusi lebih sehat.',
      'assets/scalling.png',
      350000,
      45),
  Layanan(
      'Tambal Gigi',
      'Menutup gigi berlubang dengan bahan komposit sewarna gigi supaya tampak alami.',
      'assets/tambal.png',
      450000,
      60),
  Layanan(
      'Pemutihan Gigi',
      'Perawatan bleaching untuk mencerahkan warna gigi beberapa tingkat lebih putih.',
      'assets/pemutihan.png',
      1500000,
      90),
  Layanan(
      'Cabut Gigi',
      'Pencabutan gigi yang rusak atau gigi bungsu dengan prosedur aman dan minim nyeri.',
      'assets/cabut.png',
      600000,
      45),
  Layanan(
      'Perawatan Gigi Anak',
      'Pemeriksaan dan perawatan gigi untuk anak dengan pendekatan yang ramah dan nyaman.',
      'assets/perawatan_anak.png',
      300000,
      40),
];

const List<String> daftarDokter = [
  'drg. Darrell Weida Wihardi',
  'drg. Ferdinand Justin',
  'drg. Gilbert Valentino Hahijary',
];

const List<String> namaAddon = [
  'Anestesi lokal',
  'Fluoride treatment',
  'Rontgen gigi',
];
const List<int> hargaAddon = [100000, 120000, 120000];

// keranjang disimpan di variabel global supaya bisa diakses semua halaman
List<ItemKeranjang> keranjang = [];

// items opsional: kalau tidak diisi (null) pakai isi keranjang,
// kalau diisi (dari tombol Reservasi di halaman detail) pakai list yang dikirim
int totalHarga([List<ItemKeranjang>? items]) {
  List<ItemKeranjang> list = items ?? keranjang;
  int hasil = 0;
  for (int i = 0; i < list.length; i++) {
    hasil = hasil + list[i].total;
  }
  return hasil;
}

int totalDurasi([List<ItemKeranjang>? items]) {
  List<ItemKeranjang> list = items ?? keranjang;
  int hasil = 0;
  for (int i = 0; i < list.length; i++) {
    hasil = hasil + list[i].layanan.durasi;
  }
  return hasil;
}

String namaPengguna = 'Donal';
String emailPengguna = 'donal@email.com';
String teleponPengguna = '0812-3356-7930';

// ubah angka ke format rupiah, contoh 350000 jadi Rp 350.000
// titik disisipkan setiap 3 digit, dihitung dari belakang
String formattingHarga(int harga) {
  String angka = harga.toString();
  String hasil = '';
  int hitung = 0;
  for (int i = angka.length - 1; i >= 0; i--) {
    hasil = angka[i] + hasil;
    hitung++;
    if (hitung % 3 == 0 && i != 0) {
      hasil = '.' + hasil;
    }
  }
  return 'Rp ' + hasil;
}