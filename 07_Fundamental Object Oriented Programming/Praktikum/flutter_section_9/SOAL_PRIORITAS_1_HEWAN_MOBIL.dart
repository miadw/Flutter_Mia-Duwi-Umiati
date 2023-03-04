class Hewan{
  String namaHewan1 = "nama hewan";
  String namaHewan2 = "nama hewan";
  int beratBadanHewan1 = 0;
  int beratBadanHewan2 = 0;
}

class Mobil{
  int kapasitasMobil = 0;
  List<String> isiMuatan = ['Kambing', 'Domba'];

  void tambahMuatan(){
    print("Kapasitas masih tersedia, muatan bisa ditambah!");
  }
}

void main() {
  Hewan h = Hewan();
  Mobil m = Mobil();
  h.namaHewan1 = "Kambing";
  h.namaHewan2 = "Domba";
  h.beratBadanHewan1 = 5;
  h.beratBadanHewan2 = 4;
  m.kapasitasMobil = 10;

  if((h.beratBadanHewan1 + h.beratBadanHewan2) < m.kapasitasMobil){
    m.tambahMuatan();
    print("Daftar hewan: ${m.isiMuatan}");
  }else{
    print("Kapasitas sudah penuh!");
  }
}