
import 'package:bike_tracker/models/bike.dart';
import 'package:bike_tracker/utils/AppConstants.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddBikePage extends StatefulWidget {
  final bool addBike;
  final int? index;
  final Bike? bikeToUpdate;

  AddBikePage({Key? key, required this.addBike, this.index, this.bikeToUpdate }): super(key: key);

  @override
  _AddBikePageState createState() => _AddBikePageState();
}

class _AddBikePageState extends State<AddBikePage> {
  //late AppUtils _appUtils;
  final bikesBox = Hive.box<Bike>(AppConstants.bikeBox);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _onFormChanged = false;
  bool _doAutoValidation = false;

  final ownerNameController = TextEditingController();
  final makeController = TextEditingController();
  final modelController = TextEditingController();

  late String ownerName, make, model;

  String selectedBikeType = "Standard";

  @override
  Widget build(BuildContext context) {
    //_appUtils = AppUtils(context);

    if (!widget.addBike){
      ownerNameController.text = widget.bikeToUpdate!.ownerName;
      makeController.text = widget.bikeToUpdate!.make;
      modelController.text = widget.bikeToUpdate!.model;
    }



    return Scaffold(
      appBar: AppBar(
        title:Text(
          widget.addBike ? 'Add New Bike' : 'Update Bike',
          style: TextStyle(color: Colors.white),
        ),

        leading: IconButton(

          onPressed: () {
            FocusScope.of(context).unfocus();
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.close),
        ),
      ),

      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Container(
//              margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Form(
                  key: _formKey,
                  onChanged: _onFormChange,
                  autovalidateMode: _doAutoValidation? AutovalidateMode.always : AutovalidateMode.disabled,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),

                      TextFormField(
                        controller: ownerNameController,
                        //style: TextStyle(color: AppColors.textFieldTextColor),
                        decoration: InputDecoration(
                          fillColor: Colors.grey[200],
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          helperText: "Required",
                          labelText:'Owner Name',
                          prefixIcon: Icon(Icons.person, color: Colors.black, ),

                        ),
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        validator: requiredInputValidator,
                      ),

                      DropdownButtonFormField<String>(
                        isExpanded: true,
                        isDense: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          helperText: "Required",
                          labelText: "Bike Type",
                        ),
                        value: selectedBikeType,
                        items: <String>["Standard","Cruiser", "Sport Bike", "Off-Road"]
                            .map<DropdownMenuItem<String>>((String val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        }).toList(),

                        onChanged: (newValue) {
                          setState(() {
                            selectedBikeType = newValue!;
                          });
                        },

                      ),


                      TextFormField(
                        controller: makeController,
                        //style: TextStyle(color: AppColors.textFieldTextColor),
                        decoration: InputDecoration(
                          fillColor: Colors.grey[200],
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          helperText: "Required",
                          labelText:'Make',
                          prefixIcon: Icon(Icons.motorcycle_outlined, color: Colors.green, ),

                        ),
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        validator: requiredInputValidator,
                      ),

                      TextFormField(
                        controller: modelController,
                        //style: TextStyle(color: AppColors.textFieldTextColor),
                        decoration: InputDecoration(
                          fillColor: Colors.grey[200],
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          helperText: "Required",
                          labelText:'Model',
                          prefixIcon: Icon(Icons.tune, color: Colors.black, ),

                        ),
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        validator: requiredInputValidator,
                      ),


                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: RaisedButton(
                              color: Colors.black,
                              child: Text(
                                widget.addBike ? 'Add New Bike' : 'Update Bike',
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.black)),
                              onPressed: _validateInputs,
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onFormChange() {
    if (_onFormChanged) return;
    setState(() {
      _onFormChanged = true;
    });
  }

  void _validateInputs() {
    if (_formKey.currentState!.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState!.save();

      ownerName = ownerNameController.text;
      make = makeController.text;
      model = modelController.text;

      Bike bike = new Bike(ownerName: ownerName, bikeType: selectedBikeType, make: make, model: model);
      widget.addBike ? addNewBike(bike) : updateBike(bike);

    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _doAutoValidation = true;
      });
    }
  }

  String? requiredInputValidator(value) =>
      value.isEmpty ? 'Field cannot be left blank' : null;

  void addNewBike(Bike bike) {
    bikesBox.add(bike);
    FocusScope.of(context).unfocus();
    Navigator.of(context).pop();

  }

  void updateBike(Bike bike) {
    bikesBox.putAt(widget.index!, bike);
    FocusScope.of(context).unfocus();
    Navigator.of(context).pop();

  }

}