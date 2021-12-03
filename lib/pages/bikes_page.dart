import 'package:bike_tracker/models/bike.dart';
import 'package:bike_tracker/utils/AppConstants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'add_bikes_page.dart';

class BikesPage extends StatefulWidget {
  @override
  _BikesPageState createState() => _BikesPageState();
}

class _BikesPageState extends State<BikesPage> {

  //final boxValueNotifier = Hive.box<Bike>(AppConstants.bikeBox).listenable();
  final bikeBox = Hive.box<Bike>(AppConstants.bikeBox);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bikes'),
      ),

      body: ValueListenableBuilder(
          valueListenable: bikeBox.listenable(),
          builder: (context, Box<Bike> box, _){

            if (box.values.isEmpty)
              return Center(
                child: Text("No bikes found"),
              );
            return ListView.builder(
                itemCount: box.values.length,
                itemBuilder: (BuildContext context, int index ){
                  Bike? zeBike = box.getAt(index);
                  return Dismissible(
                    direction: DismissDirection.endToStart,

                    background: Container(
                      color: Colors.red,
                      child: ListTile(
                        //leading: Icon(Icons.delete, color: Colors.white,),
                        trailing: Icon(Icons.delete, color: Colors.white,),

                      ),

                    ),


                    key: Key(index.toString()), // or use UniqueKey(),

                    onDismissed: (direction) {
                      box.deleteAt(index);

                      ScaffoldMessenger.of(context).showSnackBar(
                          zeSnackBar("${zeBike!.ownerName}'s bike deleted")
                      );

                    },

                    child: Card(
                      elevation: 2,

                      child: ListTile(
                        leading: CircleAvatar(child: Icon(Icons.motorcycle, )),
                        title: Text(zeBike!.ownerName),
                        subtitle: Text("${zeBike.make} ${zeBike.model}"),
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  AddBikePage(addBike: false, index: index, bikeToUpdate: zeBike,))
                          );
                        },
                      ),
                    ),
                  );
                }
            );
          }
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()  {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
                  AddBikePage(addBike: true))
          );
        },
      ),
    );
  }


  SnackBar zeSnackBar(String message) {
    return SnackBar(
      duration: const Duration(seconds: 1),
      content: Text(message),
      action: SnackBarAction(
        textColor: Colors.orangeAccent,
        label: 'Dismiss',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
  }

}