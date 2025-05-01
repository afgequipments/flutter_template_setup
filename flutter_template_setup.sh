#!/bin/bash

# Prompt for project name
read -p "Masukkan nama project (gunakan underscore _ jika perlu): " project_name

# Validasi nama project
if [[ ! "$project_name" =~ ^[a-z0-9_]+$ ]]; then
  echo "❌ Nama project tidak valid. Gunakan hanya huruf kecil, angka, dan underscore (_)."
  exit 1
fi

# Prompt for package name
read -p "Masukkan nama package (contoh: com.example.app): " package_name

# Validasi nama package
if [[ ! "$package_name" =~ ^[a-z]+\.[a-z0-9]+\.[a-z0-9_]+$ ]]; then
  echo "❌ Nama package tidak valid. Gunakan format seperti: com.example.app"
  exit 1
fi

# Pindah ke direktori luar
cd ..

# Buat project baru
flutter create --org "$package_name" "$project_name"
cd "$project_name" || exit

# Hapus lib lama dan buat struktur folder baru
rm -rf lib
mkdir -p lib/core/constants
mkdir -p lib/core/theme
mkdir -p lib/core/utils
mkdir -p lib/data/services
mkdir -p lib/routes
mkdir -p lib/widgets
mkdir -p lib/modules
mkdir -p lib/bindings

# Buat folder asset
mkdir -p assets/images
mkdir -p assets/fonts

# === main.dart ===
cat > lib/main.dart <<EOF
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/strings.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appName,
      theme: AppTheme.lightTheme,
      getPages: AppPages.pages,
      initialRoute: AppRoutes.home,
    );
  }
}
EOF

# === constants ===
cat > lib/core/constants/colors.dart <<EOF
import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF6C63FF);
  static const secondary = Color(0xFFFF6584);
  static const background = Color(0xFFF9F9F9);
  static const text = Color(0xFF333333);
}
EOF

cat > lib/core/constants/fonts.dart <<EOF
class AppFonts {
  static const mainFont = 'Roboto';
}
EOF

cat > lib/core/constants/strings.dart <<EOF
class AppStrings {
  static const appName = 'Flutter Template App';
}
EOF

# === theme ===
cat > lib/core/theme/app_theme.dart <<EOF
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/fonts.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        fontFamily: AppFonts.mainFont,
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppColors.text),
        ),
      );
}
EOF

cat > lib/core/theme/text_styles.dart <<EOF
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/fonts.dart';

class TextStyles {
  static const heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
    fontFamily: AppFonts.mainFont,
  );

  static const body = TextStyle(
    fontSize: 16,
    color: AppColors.text,
    fontFamily: AppFonts.mainFont,
  );
}
EOF

# === utils ===
cat > lib/core/utils/api_service.dart <<EOF
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<Map<String, dynamic>> fetchData(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Gagal mengambil data dari API');
    }
  }
}
EOF

cat > lib/core/utils/asset_paths.dart <<EOF
class AssetPaths {
  static const logo = 'assets/images/logo.png';
}
EOF

# === routes ===
cat > lib/routes/app_routes.dart <<EOF
abstract class AppRoutes {
  static const home = '/home';
}
EOF

cat > lib/routes/app_pages.dart <<EOF
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = <GetPage>[
    GetPage(name: '/home', page: ()=> const Placeholder())
  ];
}
EOF

# === README placeholders untuk folder kosong ===
cat > lib/widgets/README.md <<EOF
# widgets

Berisi komponen UI custom seperti tombol, AppBar, dialog, dan lainnya yang digunakan ulang di berbagai layar aplikasi.
EOF

cat > lib/modules/README.md <<EOF
# modules

Folder ini menyimpan semua layar atau fitur dalam bentuk modul, seperti home, login, profile, dsb.
EOF

cat > lib/bindings/README.md <<EOF
# bindings

Berisi file binding GetX untuk menghubungkan controller dengan dependency injection pada setiap modul atau layar.
EOF

# === Update pubspec.yaml ===
awk '
  BEGIN {
    inside_dependencies = 0;
    inside_flutter = 0;
    assets_added = 0;
  }

  /^dependencies:/ {
    print;
    print "  get: ^4.6.5";
    print "  google_fonts: ^6.1.0";
    next;
  }

  /^flutter:/ {
    print;
    inside_flutter = 1;
    next;
  }

  /^[^[:space:]]/ {
    if (inside_flutter && !assets_added) {
      print "  assets:";
      print "    - assets/images/";
      print "    - assets/fonts/";
      assets_added = 1;
      inside_flutter = 0;
    }
    print;
    next;
  }

  END {
    if (inside_flutter && !assets_added) {
      print "  assets:";
      print "    - assets/images/";
      print "    - assets/fonts/";
    }
  }

  { print; }
' pubspec.yaml > pubspec_temp.yaml && mv pubspec_temp.yaml pubspec.yaml


echo ""
echo "✅ Struktur project '$project_name' berhasil dibuat!"
echo "📦 Package: $package_name"
echo "📁 Assets/images dan assets/fonts telah ditambahkan dan terdaftar di pubspec.yaml"
echo "🚀 Kamu siap untuk mulai coding!"
