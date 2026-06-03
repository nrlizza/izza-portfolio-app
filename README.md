# 📱 Personal Profile App — Flutter

## ✨ Fitur Utama

### Halaman Profil (`profil_page.dart`)
- Header profil dengan gradient dan foto `CircleAvatar`
- Tab navigasi (About Me / Portfolio / Contact) dengan animasi transisi
- **About Me**: Menampilkan 4 informasi diri dan 9 skill dalam chip layout
- **Portfolio**: Menampilkan 3 project yang bisa di-tap untuk melihat detail
- **Contact**: Menampilkan email, WhatsApp, GitHub, dan LinkedIn
- Floating Action Button untuk menambah data (navigasi ke halaman form)

### Halaman Detail Project (`project_detail.dart`)
- SliverAppBar dengan gradient
- Deskripsi project, key features, dan technology stack
- Tombol aksi GitHub Repository dan Live Demo
- Galeri screenshot dengan carousel (PageView) dan indicator dots
- Fade-in animation saat halaman dibuka

### Halaman Form Input (`new_form.dart`)
- 4 field input: Full Name, Email, Phone Number, Message
- Validasi form (tidak boleh kosong, format email)
- Hero animation pada avatar profil
- Animasi submit button (mengecil → loading → centang hijau)
- Pesan sukses dengan AnimatedOpacity
- Auto-navigasi kembali ke halaman utama setelah submit

## 🎨 Tema Warna

Aplikasi menggunakan custom color palette **Mauve/Dusty Rose** yang diterapkan secara konsisten:

| Warna          | Hex Code    | Kegunaan                     |
|----------------|-------------|------------------------------|
| Primary        | `#73555F`   | AppBar, tombol, icon, FAB    |
| Primary Light  | `#A17D88`   | Gradient, hint icon          |
| Primary Dark   | `#5D434B`   | Gradient header              |
| Card Background| `#F8F5F6`   | Background card dan input    |
| Text Dark      | `#1E293B`   | Teks utama                   |
| Chip Border    | `#D4C5CA`   | Border skill chips           |

## 🎬 Animasi yang Digunakan

| Animasi               | Widget/Class            | Lokasi                  | Keterangan                              |

| Fade Transition       | `AnimatedOpacity`       | profil_page             | Transisi konten saat ganti tab          |
| Container Animation   | `AnimatedContainer`     | profil_page, new_form   | Tab button & submit button berubah      |
| Content Switcher      | `AnimatedSwitcher`      | profil_page             | Pergantian konten tab                   |
| Page Fade-in          | `FadeTransition`        | project_detail          | Seluruh halaman muncul dengan fade      |
| Success Message       | `AnimatedOpacity`       | new_form                | Pesan sukses muncul setelah submit      |

## 📁 Struktur Project

```
praktikum/
├── lib/
│   ├── main.dart              # Entry point, konfigurasi tema
│   ├── profil_page.dart       # Halaman utama (3 tab: About, Portfolio, Contact)
│   ├── project_detail.dart    # Halaman detail portfolio project
│   └── new_form.dart          # Halaman form input dengan validasi
├── assets/
│   ├── izza.jpeg              # Foto profil
│   ├── masak yuk 1.png        # Screenshot project Masak Yuk
│   ├── masak yuk 2.png
│   ├── masak yuk 3.png
│   ├── edvent 1.png           # Screenshot project EdVent
│   ├── edvent 2.png
│   └── edvent 3.png
├── pubspec.yaml               # Konfigurasi dependencies & assets
└── README.md                  # Dokumentasi project (file ini)
```

## 🛠️ Teknologi & Dependencies

- **Framework**: Flutter (Dart SDK ^3.7.2)
- **UI Library**: Material Design (`uses-material-design: true`)
- **Icons**: Cupertino Icons (`cupertino_icons: ^1.0.8`)
- **Linting**: Flutter Lints (`flutter_lints: ^5.0.0`)

## 🚀 Cara Menjalankan

1. **Pastikan Flutter sudah terinstall**
   ```bash
   flutter --version
   ```

2. **Clone atau buka project**
   ```bash
   cd "d:\Semester 6\praktikum"
   ```

3. **Install dependencies**
   ```bash
   flutter pub get
   ```

4. **Jalankan aplikasi**
   ```bash
   flutter run
   ```

   Atau untuk menjalankan di Chrome (web):
   ```bash
   flutter run -d chrome
   ```

## 📋 Daftar Tugas yang Dikerjakan

### Tugas Mandiri
- Ganti informasi profil (nama, alamat, jurusan, angkatan)
- Ganti foto profil dengan foto sendiri
- Ganti role/jabatan
- Lengkapi Tab About Me (4 info diri + 9 skills)
- Lengkapi Tab Portfolio (3 project)
- Lengkapi Tab Contact (email, WhatsApp, GitHub, LinkedIn)

### Tugas Pengembangan
- **A** — Tambah Halaman Baru (`project_detail.dart` + `Navigator.push()`)
- **B** — Tambah Foto di Portfolio (`Image.asset()` + carousel)
- **C** — Ubah Tema Warna (palette mauve konsisten)
- **D** — Tambah Animasi (Hero, AnimatedOpacity, AnimatedContainer, FadeTransition, AnimatedSwitcher)
- **E** — Tambah Form Input (`new_form.dart` + validasi)
