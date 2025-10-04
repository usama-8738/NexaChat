import 'package:hive/hive.dart';

import 'hive_box_registry.dart';

class CacheDatabase {
  Future<void> openCoreBoxes() async {
    await Future.wait(defaultHiveBoxes.map(Hive.openBox));
  }

  Box<dynamic> box(String name) => Hive.box(name);

  Future<void> clearAll() async {
    for (final name in defaultHiveBoxes) {
      if (Hive.isBoxOpen(name)) {
        await Hive.box(name).clear();
      }
    }
  }
}
