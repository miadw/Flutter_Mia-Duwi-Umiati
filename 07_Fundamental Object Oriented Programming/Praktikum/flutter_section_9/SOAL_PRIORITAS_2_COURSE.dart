import 'dart:ffi';
import 'dart:io';

class Course {
  String judul;
  String deskripsi;

  Course(this.judul, this.deskripsi);
}
class Student{
  String nama = "nama";
  String kelas = "kelas";
  List<Course> courses = [];
  
  void tambahKursus(Course kursus){
    courses.add(kursus);
  }

  void hapusKursus(Course kursus){
    courses.remove(kursus);
  }

  void lihatSemuaKursus(){
    if (courses.isEmpty) {
      print("Anda tidak menambahkan kursus.");
    } else {
      print("\nKursus yang $nama kelas $kelas ambil : ");
      for (var kursus in courses) {
        print("${kursus.judul}: ${kursus.deskripsi}");
      }
    }
  }
}

void main() {
  var kursus1 = Course("1. Front-End Engineer Career With Flutter", "Mempelajari cara membangun mobile application dalam bahasa Flutter dan melakukan deployment."); 
  var kursus2 = Course("2. Front-End Engineer Career With ReactJS", "Mempelajari cara membangun aplikasi di sisi Front-end dalam bahasa React dan melakukan deployment.");
  
  Student student1 = Student();
  student1.nama = "Mia Duwi Umiati";
  student1.kelas = "Flutter-C";
  student1.tambahKursus(kursus1);
  student1.tambahKursus(kursus2);
  student1.lihatSemuaKursus();
  
  print("\nSetelah Kursus dihapus...");
  
  student1.hapusKursus(kursus2);
  student1.lihatSemuaKursus();

  print("\nSetelah Kursus ditambah...");
  
  student1.tambahKursus(kursus2);
  student1.lihatSemuaKursus();
  
}