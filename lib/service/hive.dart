import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:yazlab_1_1/service/hive_model.dart';

class ItemHive {
  static Box<HiveModel> getItemHive() => Hive.box<HiveModel>("itembox");
}
