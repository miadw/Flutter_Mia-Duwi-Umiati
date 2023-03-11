class MatematikaKPK implements KalkulatorKPK {
  int x;
  int y;
  MatematikaKPK(this.x, this.y);

  @override
  int cariKPK(int x, int y) {
    int max = x > y ? x : y;
    while (true) {
      if (max % x == 0 && max % y == 0) {
        return max;
      }
      max++;
    }
  }

  String hasil() {
    int kpk = cariKPK(x, y);
    return 'KPK dari $x dan $y adalah $kpk';
  }
}

class MatematikaFPB implements KalkulatorFPB {
  int x;
  int y;
  MatematikaFPB(this.x, this.y);

  @override
  int cariFPB(int x, int y) {
    while (y != 0) {
      int r = x % y;
      x = y;
      y = r;
    }
    return x;
  }

  String hasil() {
    int fpb = cariFPB(x, y);
    return 'FPB dari $x dan $y adalah $fpb';
  }
}

abstract class KalkulatorKPK {
  int cariKPK(int x, int y);
}

abstract class KalkulatorFPB {
  int cariFPB(int x, int y);
}

void main() {
  MatematikaKPK kpk = MatematikaKPK(17, 13);
  print(kpk.hasil());

  MatematikaFPB fpb = MatematikaFPB(16, 24);
  print(fpb.hasil());
}
