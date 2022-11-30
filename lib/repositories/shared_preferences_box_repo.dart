import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:isar/isar.dart';

import '../models/vehicle/vehicle.dart';
import '../utils/app_constants.dart';

///This class performs CRUD for the hive db to follow clean code architecture

class SharedPrefsBox {
  //final Ref ref;
  late final ValueListenable mySharedPrefsBoxListenable;
  late final vehicles;
  SharedPrefsBox(){
    vehicles = isar.vehicles;

  mySharedPrefsBoxListenable = mySharedPrefsBox.listenable();
  }
  //SharedPrefsBox(this.ref);
  final isar =  Isar.openSync([VehicleSchema]);

  final mySharedPrefsBox = Hive.box(AppConstants.vehicleBox);


  void putI(dynamic item){
     isar.writeTxn(() async {
       vehicles.putSync(item); // insert & update
    });
  }

  void put(String key, dynamic item) {
    mySharedPrefsBox.put(key, item);
  }

  dynamic get(String key) {
    return mySharedPrefsBox.get(key);
  }

  dynamic getWithDefault(String key, {dynamic defaultVal}) {
    return mySharedPrefsBox.get(key, defaultValue: defaultVal);
  }

  dynamic delete(String key) {
    mySharedPrefsBox.delete(key);
  }

  dynamic deleteAll(key) {
    mySharedPrefsBox.deleteAll(key);
  }

}
