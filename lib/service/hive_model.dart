import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'hive_model.g.dart';

@HiveType(typeId: 1)
class HiveModel {
  HiveModel(
      {this.marka = "Belirtilmemiş",
      this.ismi = "Belirtilmemiş",
      this.linki = "Belirtilmemiş",
      this.fiyati = "Belirtilmemiş",
      this.islemciTipi = "Belirtilmemiş",
      this.ssdKapasitesi = "Belirtilmemiş",
      this.isletimSistemi = "Belirtilmemiş",
      this.ekranKarti = "Belirtilmemiş",
      this.ram = "Belirtilmemiş",
      this.cozunurluk = "Belirtilmemiş",
      this.ekranBoyutu = "Belirtilmemiş"});

  @HiveField(0)
  String marka;
  @HiveField(1)
  String ismi;
  @HiveField(2)
  String linki;
  @HiveField(3)
  String fiyati;
  @HiveField(4)
  String islemciTipi;
  @HiveField(5)
  String ssdKapasitesi;
  @HiveField(6)
  String isletimSistemi;
  @HiveField(7)
  String ekranKarti;
  @HiveField(8)
  String ram;
  @HiveField(9)
  String cozunurluk;
  @HiveField(10)
  String ekranBoyutu;
}
