// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveModelAdapter extends TypeAdapter<HiveModel> {
  @override
  final int typeId = 1;

  @override
  HiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveModel(
      marka: fields[0] as String,
      ismi: fields[1] as String,
      linki: fields[2] as String,
      fiyati: fields[3] as String,
      islemciTipi: fields[4] as String,
      ssdKapasitesi: fields[5] as String,
      isletimSistemi: fields[6] as String,
      ekranKarti: fields[7] as String,
      ram: fields[8] as String,
      cozunurluk: fields[9] as String,
      ekranBoyutu: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.marka)
      ..writeByte(1)
      ..write(obj.ismi)
      ..writeByte(2)
      ..write(obj.linki)
      ..writeByte(3)
      ..write(obj.fiyati)
      ..writeByte(4)
      ..write(obj.islemciTipi)
      ..writeByte(5)
      ..write(obj.ssdKapasitesi)
      ..writeByte(6)
      ..write(obj.isletimSistemi)
      ..writeByte(7)
      ..write(obj.ekranKarti)
      ..writeByte(8)
      ..write(obj.ram)
      ..writeByte(9)
      ..write(obj.cozunurluk)
      ..writeByte(10)
      ..write(obj.ekranBoyutu);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
