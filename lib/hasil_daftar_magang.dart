import 'package:flutter/material.dart';

class HasilDaftarMagang extends StatelessWidget {
  final String nama;
  final String nim;
  final String noTelepon;
  final String email;
  final String tanggalLahir;
  final String alamat;
  final String programStudi;
  final String jenisKelamin;
  final String posisi;
  final String pengalaman;
  final String hobi;

  const HasilDaftarMagang({
    super.key,
    required this.nama,
    required this.nim,
    required this.noTelepon,
    required this.email,
    required this.tanggalLahir,
    required this.alamat,
    required this.programStudi,
    required this.jenisKelamin,
    required this.posisi,
    required this.pengalaman,
    required this.hobi,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Daftar Magang'),
        backgroundColor: const Color(0xFF0D47A1), // Biru
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Banner Sukses
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.shade400, width: 1.5),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 48,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Pendaftaran Sukses!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tunggu informasi selanjutnya melalui WhatsApp atau Email Anda.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.green.shade900,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Card Data Pendaftaran
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Color(0xFFD4AF37), width: 1.5), // Emas
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 36,
                      backgroundColor: Color(0xFF0D47A1), // Biru
                      child: Icon(Icons.person, size: 40, color: Color(0xFFD4AF37)), // Emas
                    ),
                    const SizedBox(height: 12),
                    Text(
                      nama,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5D4037), // Coklat
                      ),
                    ),
                    Text(
                      posisi,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF0D47A1), // Biru
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Divider(height: 24, thickness: 1),
                    _buildItem('Nama Lengkap', nama),
                    _buildItem('NIM', nim),
                    _buildItem('Program Studi', programStudi),
                    _buildItem('No. Telepon', noTelepon),
                    _buildItem('Email', email),
                    _buildItem('Tanggal Lahir', tanggalLahir),
                    _buildItem('Jenis Kelamin', jenisKelamin),
                    _buildItem('Posisi Dilamar', posisi),
                    _buildItem('Pengalaman Kerja', pengalaman),
                    _buildItem('Hobi', hobi),
                    _buildItem('Alamat Domisili', alamat),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Tombol Kembali
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5D4037), // Coklat
                  foregroundColor: const Color(0xFFD4AF37), // Emas
                ),
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali ke Formulir'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D4037), // Coklat
              ),
            ),
          ),
          const Text(': '),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
