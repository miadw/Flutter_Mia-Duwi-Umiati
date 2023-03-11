Rangkuman yang berkaitan dengan Installation Command Line Interface and Package Management in Flutter
1. Flutter CLI merupakan sebuah perangkat lunak yang digunakan untuk membuat, mengelola, dan membangun project Flutter dan dijalankan di terminal.
2. CLI commands :
       a. flutter doctor : memeriksa instalasi software yang dibutuhkan Flutter ("flutter doctor -v").
       b. flutter create <project_name> : membuat project Flutter baru dengan nama yang diberikan ("flutter create <APP_NAME>").
       c. flutter run : menjalankan project Flutter pada perangkat terhubung atau emulator ("flutter run <DART_FILE>").
       d. flutter build : membangun project Flutter untuk dideploy ke platform tertentu (misalnya, Android, iOS, web) ("flutter build <DIRECTORY>").
       e. flutter clean : menghapus folder build serta file lainnya yang dihasilkan saat menjalankan aplikasi di emulator ("flutter clean")>.
3. Packages management merupakan perangkat baris perintah untuk mengelola dependensi pada project Flutter. Berikut merupakan perintah pub:
       a. pub get: untuk mendownload dan menginstal semua dependensi yang terdaftar di file pubspec.yaml.
       b. pub upgrade: untuk mengupgrade semua dependensi ke versi terbaru.
       c. pub outdated: untuk menampilkan dependensi mana yang perlu diupgrade.
       d. pub global: untuk menginstal paket secara global, sehingga dapat diakses dari mana saja pada sistem.
