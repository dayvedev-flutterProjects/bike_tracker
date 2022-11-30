
import 'package:isar/isar.dart';

part 'vehicle.g.dart';


@collection
class Vehicle{

  Id id = Isar.autoIncrement;
  String ownerName;
  String vehicleType;
  String make;
  String model;


  Vehicle({required this.ownerName,required this.vehicleType, required this.make, required this.model});
}