import 'dart:math';
void main(){ 
  Kalkulator k = new Kalkulator(); 
  k.tambah();
  k.kurang();
  k.kali();
  k.bagi();
}

class Kalkulator{  
  int angkaA = 44;
  int angkaB = 22;
   
  void tambah(){ 
    print("Hasil penjumlahan ${angkaA} + ${angkaB} adalah ${angkaA + angkaB}");
  }

  void kurang(){ 
    print("Hasil pengurangan ${angkaA} - ${angkaB} adalah ${angkaA - angkaB}");
  }

  void kali(){ 
    print("Hasil perkalian ${angkaA} x ${angkaB} adalah ${angkaA * angkaB}");
  }

  void bagi(){ 
    print("Hasil pembagian ${angkaA} : ${angkaB} adalah ${angkaA / angkaB}");
  }
}