# Flutter Project Template Setup

Template Flutter ini dibuat untuk mempercepat pembuatan project baru dengan struktur folder yang rapi, menggunakan GetX sebagai state management, serta termasuk konfigurasi tema, string, style teks, dan service API dasar.

## 🚀 Fitur

- Menggunakan `GetX` untuk manajemen state dan routing.
- Struktur folder modular per screen.
- Konfigurasi awal tema, warna, font, dan teks.
- Setup service API dasar menggunakan `http`.
- Folder `assets` lengkap dengan struktur `images` dan `fonts`.
- Custom widget terorganisir di folder khusus.

## 🗂️ Struktur Folder

```
lib/
│
├── bindings/                # Folder untuk file GetX bindings per modul
│   └── README.md
│
├── core/
│   ├── constants/           # Berisi file global seperti colors.dart, fonts.dart, strings.dart
│   ├── theme/               # Tema aplikasi dan gaya teks
│   └── utils/               # File utilitas umum seperti pemanggilan API, path asset
│
├── data/
│   └── services/            # Service yang berhubungan dengan data, seperti API
│
├── modules/                # Folder fitur (screen) yang terpisah per modul
│   └── README.md
│
├── routes/                 # Routing aplikasi (AppRoutes dan AppPages)
│
├── widgets/                # Widget custom yang digunakan ulang
│   └── README.md
│
└── main.dart               # Entry point aplikasi
```

## 📁 Struktur Asset

```
assets/
├── fonts/                  # Tempat font custom
└── images/                 # Tempat gambar, logo, dsb.
```

Pastikan font dan gambar ditambahkan di sini dan didaftarkan di `pubspec.yaml`.

## ⚙️ Cara Menggunakan Script Setup

### 1. Jalankan di Terminal

```bash
chmod +x flutter_template_setup.sh
./flutter_template_setup.sh
```

### 2. Ikuti Instruksi

- Masukkan nama project (gunakan underscore `_` bukan spasi)
- Masukkan nama package (contoh: `com.example.myapp`)

### 3. Selesai!

Struktur project akan otomatis dibuat dan siap digunakan. File `pubspec.yaml` juga otomatis diperbarui dengan dependency dan asset.

## 🧪 Dependency yang Digunakan

```yaml
dependencies:
  get: ^4.6.5
  google_fonts: ^6.1.0
```

## 📄 File Penting

- **colors.dart**: Semua warna aplikasi.
- **fonts.dart**: Nama font default.
- **strings.dart**: Semua teks atau string global.
- **app_theme.dart**: Tema aplikasi.
- **text_styles.dart**: Gaya teks standar.
- **api_service.dart**: Template pemanggilan API.
- **asset_paths.dart**: Path asset yang mudah dipanggil.
- **app_routes.dart & app_pages.dart**: Routing aplikasi.

## 🛠️ Kustomisasi Selanjutnya

Setelah struktur selesai dibuat, kamu bisa mulai membuat modul baru di dalam folder `modules/`, menambahkan file binding di `bindings/`, serta menambahkan widget custom di `widgets/`.

## 📦 Publikasi

Kamu bebas menyimpan script ini secara pribadi atau membagikannya di GitHub/GitLab agar developer lain bisa ikut menggunakan template yang sama.

## 🧼 Tips

- Jangan lupa untuk menjalankan `flutter pub get` setelah setup selesai.
- Pastikan nama project dan package sesuai standar Flutter (lowercase, underscore, dll).

## 📜 Lisensi

Project ini menggunakan lisensi [MIT License](LICENSE).

Silakan gunakan, ubah, dan bagikan template ini dengan bebas.
