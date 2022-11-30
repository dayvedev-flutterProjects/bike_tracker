import 'package:bike_tracker/pages/bikes_page.dart';
import 'package:bike_tracker/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/bike.dart';

void main() async {

  await Hive.initFlutter();
  Hive.registerAdapter(BikeAdapter());

  await Hive.openBox<Bike>(AppConstants.bikeBox);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bike Tracker Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BikesPage(),
    );
  }


}


