import 'package:hive_flutter/hive_flutter.dart';

class RowItemsList {
  String textBoxValue;
  DateTime nowDate;
  static final _itemsHiveDb = Hive.box("items");

  RowItemsList(this.textBoxValue, this.nowDate);

  void saveItems() {
    _itemsHiveDb.put(textBoxValue, {"itemName": textBoxValue, "date": nowDate});
  }

  static List getAllItems() {
    return _itemsHiveDb.values.toList();
  }

    static void deleteItem(String key) {
    _itemsHiveDb.delete(key);
  }
}
