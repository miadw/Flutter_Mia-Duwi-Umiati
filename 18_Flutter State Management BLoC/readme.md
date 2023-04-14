Rangkuman yang berkaitan dengan Flutter State Management BLoC
1. BLoC adalah singkatan dari Business Logic Component. Ini adalah sebuah arsitektur untuk manajemen state pada aplikasi Flutter yang terdiri dari tiga komponen utama:
    a. Event: tindakan yang memicu perubahan pada state
    b. State: kondisi terkini dari aplikasi
    c. Logic: pemrosesan bisnis untuk menangani event dan mengubah state
2. Untuk melakukan perubahan pada data yang disimpan di BLoC, kita harus memanggil method yang telah kita tambahkan pada class BLoC tersebut. Kemudian, BLoC akan memberikan notifikasi kepada semua widget yang menggunakan data tersebut agar mereka dapat merender ulang dirinya sendiri.
3. Stream adalah sebuah objek yang digunakan untuk mengirim dan menerima data secara asynchronous. Dalam BLoC, Stream digunakan untuk mengirim data dari BLoC ke widget dan sebaliknya.
4. Untuk menghubungkan Stream dengan widget, kita perlu menggunakan StreamBuilder (StreamBuilder adalah sebuah widget yang digunakan untuk membuat widget yang bergantung pada data dari sebuah Stream. Widget ini akan rebuild ketika ada data baru yang masuk ke dalam Stream). Dalam StreamBuilder, kita dapat memberikan sebuah builder method untuk mengakses data dari Stream.
