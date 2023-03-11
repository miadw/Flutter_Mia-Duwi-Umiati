class BangunRuang {
  double volume(){
    return 0;
  }
}

class Kubus extends BangunRuang{
  double sisi;
  Kubus(this.sisi);

  @override
  double volume(){
    print("Volume kubus(cm):");
    return sisi * sisi * sisi;
  }

  void result() {
    print("Nilai sisi kubus adalah $sisi cm ");
  }
}

class Balok extends BangunRuang {
  double panjang;
  double lebar;
  double tinggi;

  Balok(this.panjang, this.lebar, this.tinggi);

  @override
  double volume(){
    print("Volume balok(cm):");
    return panjang * lebar * tinggi;
  }

  void result(){
    print("Nilai panjang balok adalah $panjang cm, lebar $lebar cm, dan tinggi $tinggi cm");
  }
}

void main() {
  Kubus k = Kubus(7);
  Balok b = Balok(4, 6, 10);

  k.result();
  print(k.volume());
  b.result();
  print(b.volume());
}
