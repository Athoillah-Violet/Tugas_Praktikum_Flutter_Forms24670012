import 'package:flutter/material.dart';

import 'hasil_daftar_magang.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pendaftaran Magang AlmaStore',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Palet warna: Biru, Coklat, Emas, dan Putih
        primaryColor: const Color(0xFF0D47A1), // Biru
        scaffoldBackgroundColor: Colors.white, // Putih
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0D47A1),
          primary: const Color(0xFF0D47A1), // Biru Utama
          secondary: const Color(0xFFD4AF37), // Emas / Gold
          tertiary: const Color(0xFF5D4037), // Coklat
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0D47A1), // Biru
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF5D4037), // Coklat
            foregroundColor: const Color(0xFFD4AF37), // Emas
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        useMaterial3: true,
      ),
      home: const FormPraktikumPage(),
    );
  }
}

class FormPraktikumPage extends StatefulWidget {
  const FormPraktikumPage({super.key});

  @override
  State<FormPraktikumPage> createState() => _FormPraktikumPageState();
}

class _FormPraktikumPageState extends State<FormPraktikumPage> {
  // GlobalKey untuk validasi form
  final _formKey = GlobalKey<FormState>();

  // Controller untuk input teks
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _teleponController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();

  // State untuk toggle visibilitas password
  bool _obscurePassword = true;

  // State untuk Radio (Jenis Kelamin)
  String? _jenisKelamin = 'Laki-laki';

  // State untuk Dropdown (Program Studi)
  String? _selectedProdi;
  final List<String> _daftarProdi = [
    'Pendidikan TI',
    'Bisnis Digital',
    'PGSD',
    'Informatika',
    'Sistem Informasi',
  ];

  // State untuk Dropdown (Mendaftar Sebagai)
  String? _selectedPosisi;
  final List<String> _daftarPosisi = [
    'Administrasi & Operasional',
    'Customer Service (Central Service)',
    'Penjoki Game (MLBB / FF / Genshin)',
    'Kasir Top Up Game',
    'Media & Desain Konten',
  ];

  // State untuk Checkbox Pengalaman Kerja (Hanya bisa pilih 1)
  String? _pengalamanKerja;

  // State untuk Checkbox Hobi (Boleh pilih lebih dari 1)
  bool _hobiMembaca = false;
  bool _hobiOlahraga = false;
  bool _hobiMusik = false;
  bool _hobiFotografi = false;
  bool _hobiGaming = false;

  // State untuk Checkbox Persetujuan
  bool _setujuSyarat = false;

  @override
  void dispose() {
    _namaController.dispose();
    _nimController.dispose();
    _teleponController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _alamatController.dispose();
    _tanggalController.dispose();
    super.dispose();
  }

  // Fungsi Date Picker
  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2002),
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _tanggalController.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  // Fungsi Mengambil Daftar Hobi yang Dipilih
  List<String> _getHobiDipilih() {
    List<String> listHobi = [];
    if (_hobiMembaca) listHobi.add('Membaca');
    if (_hobiOlahraga) listHobi.add('Olahraga');
    if (_hobiMusik) listHobi.add('Musik');
    if (_hobiFotografi) listHobi.add('Fotografi');
    if (_hobiGaming) listHobi.add('Gaming');
    return listHobi;
  }

  // Fungsi Submit Form & Navigasi ke Halaman Hasil Daftar Magang
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Validasi Pengalaman Kerja (Hanya 1 yang dipilih)
      if (_pengalamanKerja == null || _pengalamanKerja!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pilih satu status pengalaman kerja sebelumnya!'),
          ),
        );
        return;
      }

      // Validasi Hobi (Minimal 1 dipilih)
      List<String> hobiList = _getHobiDipilih();
      if (hobiList.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pilih minimal satu hobi!')),
        );
        return;
      }

      // Validasi Syarat & Ketentuan
      if (!_setujuSyarat) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Anda harus menyetujui syarat & ketentuan!'),
          ),
        );
        return;
      }

      // Mengalihkan ke Halaman Hasil Daftar Magang
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HasilDaftarMagang(
            nama: _namaController.text,
            nim: _nimController.text,
            noTelepon: _teleponController.text,
            email: _emailController.text,
            tanggalLahir: _tanggalController.text,
            alamat: _alamatController.text,
            programStudi: _selectedProdi ?? '-',
            jenisKelamin: _jenisKelamin ?? '-',
            posisi: _selectedPosisi ?? '-',
            pengalaman: _pengalamanKerja!,
            hobi: hobiList.join(', '),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pendaftaran Magang AlmaStore')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Toko
              const Text(
                'AlmaStore - Jasa Top Up & Joki Game',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1), // Biru
                ),
              ),
              const Text(
                'Silakan isi formulir pendaftaran magang di bawah ini:',
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 16),

              // 1. Nama Lengkap
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  hintText: 'Masukkan nama lengkap',
                  prefixIcon: Icon(Icons.person, color: Color(0xFF0D47A1)),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama lengkap wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 2. NIM (Minimal 8 Digit)
              TextFormField(
                controller: _nimController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'NIM (Nomor Induk Mahasiswa)',
                  hintText: 'Masukkan NIM (min. 8 digit)',
                  prefixIcon: Icon(Icons.badge, color: Color(0xFF0D47A1)),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'NIM wajib diisi';
                  }
                  if (value.trim().length < 8) {
                    return 'NIM minimal 8 digit';
                  }
                  if (int.tryParse(value.trim()) == null) {
                    return 'NIM harus berupa angka';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 3. Program Studi (Dropdown)
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Program Studi',
                  hintText: 'Pilih Program Studi',
                  prefixIcon: Icon(Icons.school, color: Color(0xFF0D47A1)),
                  border: OutlineInputBorder(),
                ),
                value: _selectedProdi,
                items: _daftarProdi.map((prodi) {
                  return DropdownMenuItem(value: prodi, child: Text(prodi));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedProdi = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pilih program studi Anda';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 4. Nomor Telepon
              TextFormField(
                controller: _teleponController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Nomor Telepon / WhatsApp',
                  hintText: 'Contoh: 08123456789',
                  prefixIcon: Icon(Icons.phone, color: Color(0xFF0D47A1)),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nomor telepon wajib diisi';
                  }
                  if (value.trim().length < 10) {
                    return 'Nomor telepon minimal 10 digit';
                  }
                  if (int.tryParse(value.trim()) == null) {
                    return 'Nomor telepon harus berupa angka';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 5. Email
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'nama@email.com',
                  prefixIcon: Icon(Icons.email, color: Color(0xFF0D47A1)),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email wajib diisi';
                  }
                  if (!value.contains('@') || !value.contains('.')) {
                    return 'Format email harus benar';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 6. Password
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password Akun',
                  hintText: 'Minimal 8 karakter',
                  prefixIcon: const Icon(Icons.lock, color: Color(0xFF0D47A1)),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: const Color(0xFFD4AF37), // Emas
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password wajib diisi';
                  }
                  if (value.length < 8) {
                    return 'Password minimal 8 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 7. Tanggal Lahir (Date Input)
              TextFormField(
                controller: _tanggalController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Tanggal Lahir',
                  hintText: 'Pilih tanggal',
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    color: Color(0xFF0D47A1),
                  ),
                  border: OutlineInputBorder(),
                ),
                onTap: _pickDate,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tanggal lahir wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 8. Alamat (Text Area)
              TextFormField(
                controller: _alamatController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Alamat Domisili',
                  hintText: 'Tuliskan alamat lengkap tempat tinggal...',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Alamat wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 9. Mendaftar Sebagai (Dropdown Posisi)
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Mendaftar Sebagai (Posisi Magang)',
                  hintText: 'Pilih Posisi Magang',
                  prefixIcon: Icon(Icons.work, color: Color(0xFF0D47A1)),
                  border: OutlineInputBorder(),
                ),
                value: _selectedPosisi,
                items: _daftarPosisi.map((posisi) {
                  return DropdownMenuItem(value: posisi, child: Text(posisi));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPosisi = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pilih salah satu posisi magang';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 10. Jenis Kelamin (Radio)
              const Text(
                'Jenis Kelamin:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              RadioListTile<String>(
                title: const Text('Laki-laki'),
                value: 'Laki-laki',
                groupValue: _jenisKelamin,
                activeColor: const Color(0xFF0D47A1),
                contentPadding: EdgeInsets.zero,
                onChanged: (value) {
                  setState(() {
                    _jenisKelamin = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('Perempuan'),
                value: 'Perempuan',
                groupValue: _jenisKelamin,
                activeColor: const Color(0xFF0D47A1),
                contentPadding: EdgeInsets.zero,
                onChanged: (value) {
                  setState(() {
                    _jenisKelamin = value;
                  });
                },
              ),
              const SizedBox(height: 12),

              // 11. Pengalaman Kerja Sebelumnya (Checkbox - Hanya 1 yang bisa dipilih)
              const Text(
                'Pengalaman Kerja Sebelumnya (Pilih salah satu):',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              CheckboxListTile(
                title: const Text('Belum pernah bekerja (Fresh)'),
                value: _pengalamanKerja == 'Belum pernah bekerja (Fresh)',
                activeColor: const Color(0xFF5D4037),
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() {
                    _pengalamanKerja = value == true
                        ? 'Belum pernah bekerja (Fresh)'
                        : null;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Sudah pernah kerja (< 1 tahun)'),
                value: _pengalamanKerja == 'Sudah pernah kerja (< 1 tahun)',
                activeColor: const Color(0xFF5D4037),
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() {
                    _pengalamanKerja = value == true
                        ? 'Sudah pernah kerja (< 1 tahun)'
                        : null;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Sudah berpengalaman (≥ 1 tahun)'),
                value: _pengalamanKerja == 'Sudah berpengalaman (≥ 1 tahun)',
                activeColor: const Color(0xFF5D4037),
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() {
                    _pengalamanKerja = value == true
                        ? 'Sudah berpengalaman (≥ 1 tahun)'
                        : null;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Freelance / Berpengalaman Joki Game'),
                value:
                    _pengalamanKerja == 'Freelance / Berpengalaman Joki Game',
                activeColor: const Color(0xFF5D4037),
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() {
                    _pengalamanKerja = value == true
                        ? 'Freelance / Berpengalaman Joki Game'
                        : null;
                  });
                },
              ),
              const SizedBox(height: 12),

              // 12. Hobi (Checkbox - Boleh dipilih lebih dari satu)
              const Text(
                'Hobi (Boleh pilih lebih dari satu):',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              CheckboxListTile(
                title: const Text('Membaca'),
                value: _hobiMembaca,
                activeColor: const Color(0xFF0D47A1),
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() {
                    _hobiMembaca = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Olahraga'),
                value: _hobiOlahraga,
                activeColor: const Color(0xFF0D47A1),
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() {
                    _hobiOlahraga = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Musik'),
                value: _hobiMusik,
                activeColor: const Color(0xFF0D47A1),
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() {
                    _hobiMusik = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Fotografi'),
                value: _hobiFotografi,
                activeColor: const Color(0xFF0D47A1),
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() {
                    _hobiFotografi = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Gaming (Main Game Online)'),
                value: _hobiGaming,
                activeColor: const Color(0xFF0D47A1),
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() {
                    _hobiGaming = value ?? false;
                  });
                },
              ),
              const SizedBox(height: 12),

              // 13. Persetujuan Syarat & Ketentuan
              CheckboxListTile(
                title: const Text(
                  'Saya menyetujui seluruh syarat & ketentuan magang di AlmaStore',
                ),
                value: _setujuSyarat,
                activeColor: const Color(0xFF0D47A1),
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() {
                    _setujuSyarat = value ?? false;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Tombol Kirim Pendaftaran
              Builder(
                builder: (context) {
                  return SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: _submitForm,
                      icon: const Icon(Icons.send),
                      label: const Text(
                        'Kirim Pendaftaran',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
