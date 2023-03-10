class Buku {
  int id;
  String judul;
  String penerbit;
  int harga;
  String kategori;
  
  Buku(this.id, this.judul, this.penerbit, this.harga, this.kategori);
  
  @override
  String toString() {
    return "ID: $id, judul: $judul, penerbit: $penerbit, harga: $harga, kategori: $kategori";
  }
}

class TokoBuku {
  List<Buku> books = [];
  
  void tambahBuku(Buku buku) {
    books.add(buku);
  }
  
  List<Buku> lihatSemuaBuku() {
    return books;
  }
  
  void hapusBuku(int id) {
    books.removeWhere((buku) => buku.id == id);
  }
}

void main() {
  var tokoBuku = TokoBuku();
  
  var buku1 = Buku(1, "Seni Berbicara kepada Siapa Saja, Kapan Saja, dan di Mana Saja (ed. Revisi)", "Gramedia Pustaka Utama", 75000, "Motivasi");
  var buku2 = Buku(2, "In the Middle of Everything", "Gramedia Pustaka Utama", 135000, "Novel");
  
  tokoBuku.tambahBuku(buku1);
  tokoBuku.tambahBuku(buku2);
  
  var semuaBuku = tokoBuku.lihatSemuaBuku();
  print("Semua Buku yang ada :");
  for (var buku in semuaBuku) {
    print(buku.toString());
  }
  
  tokoBuku.hapusBuku(2);
  
  semuaBuku = tokoBuku.lihatSemuaBuku();
  print("\nSetelah menghapus buku ID 2...");
  for (var buku in semuaBuku) {
    print(buku.toString());
  }

  tokoBuku.tambahBuku(buku2);
  
  semuaBuku = tokoBuku.lihatSemuaBuku();
  print("\nSetelah menambah buku ID 2...");
  for (var buku in semuaBuku) {
    print(buku.toString());
  }
}
