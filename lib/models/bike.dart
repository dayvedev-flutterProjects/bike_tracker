
import 'package:hive_flutter/hive_flutter.dart';

part 'bike.g.dart'; //this indicates our generated file bike.g.dart is associated

@HiveType(typeId: 0)
class Bike {

  @HiveField(0)
  String ownerName;

  @HiveField(1)
  String bikeType;

  @HiveField(2)
  String make;

  @HiveField(3)
  String model;


  Bike({required this.ownerName,required this.bikeType, required this.make, required this.model});


}