import 'package:flutter/material.dart';

// ===== MODEL =====
class Layanan {
  final String nama;
  final String deskripsi;
  final String gambar;
  final int harga;
  final int durasi; // menit
  final IconData ikon;

  const Layanan(this.nama, this.deskripsi, this.gambar, this.harga,
      this.durasi, this.ikon);
}

class ItemKeranjang {
  final Layanan layanan;
  final String dokter;
  final List<String> addon;
  final int total;

  ItemKeranjang(this.layanan, this.dokter, this.addon, this.total);
}

// ===== DATA DUMMY =====
const List<Layanan> daftarLayanan = [
  Layanan(
      'Scaling & Cleaning',
      'Pembersihan karang gigi dan plak agar gigi bersih, napas segar, dan gusi lebih sehat.',
      'assets/scalling.png',
      350000,
      45,
      Icons.cleaning_services),
  Layanan(
      'Tambal Gigi',
      'Menutup gigi berlubang dengan bahan komposit sewarna gigi supaya tampak alami.',
      'assets/tambal.png',
      450000,
      60,
      Icons.medical_services),
  Layanan(
      'Pemutihan Gigi',
      'Perawatan bleaching untuk mencerahkan warna gigi beberapa tingkat lebih putih.',
      'assets/pemutihan.png',
      1500000,
      90,
      Icons.auto_awesome),
  Layanan(
      'Cabut Gigi',
      'Pencabutan gigi yang rusak atau gigi bungsu dengan prosedur aman dan minim nyeri.',
      'assets/cabut.png',
      600000,
      45,
      Icons.healing),
  Layanan(
      'Perawatan Gigi Anak',
      'Pemeriksaan dan perawatan gigi untuk anak dengan pendekatan yang ramah dan nyaman.',
      'assets/perawatan_anak.png',
      300000,
      40,
      Icons.child_care),
];

const List<String> daftarDokter = [
  'drg. Darrell Weida Wihardi',
  'drg. Ferdinand Justin',
  'drg. Gilbert Valentino Hahijary',
];

// dua list ini berpasangan (index sama)
const List<String> namaAddon = [
  'Anestesi lokal',
  'Fluoride treatment',
  'Rontgen gigi',
];
const List<int> hargaAddon = [100000, 120000, 120000];

// ===== KERANJANG (variabel global, tanpa database) =====
List<ItemKeranjang> keranjang = [];

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