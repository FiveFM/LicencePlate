import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/service/api_service.dart';

import 'models/vehicle.dart';
void main() => runApp(MyApp());

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final vehicleService = VehicleService();
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retrieve Text Input'),
      ),
      body: Column(

        children:[
          TextFormField(
            validator: (value) {
              if(value!.toUpperCase().isEmpty || !validateBoard(value.toUpperCase()) || value.length < 6 ) {
                 return myController.text = "Voer een geldig kenteken in";
              } else {
                return null;
              }
            },
          controller: myController,
        ),
          TextButton(
            // When the user presses the button, show an alert dialog containing
            // the text that the user has entered into the text field.
            onPressed: () async {

              myController.!.validate();

              var input = myController.text.toUpperCase();
              input.replaceAll("-", "").toUpperCase();
              var response = await vehicleService.fetchVehicles(input);
              if (response == null) return;
              // Create a Vehicle object from the JSON object
              var vehicle = Vehicle.fromJson(response);
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                return SecondScreen(vehicle: vehicle);
              }));},
            child: const Text("submit"),
          ),
        ]
      ),
    );
  }
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Vehicle List',
      home: MyCustomForm(),
    );
  }
}

class SecondScreen extends StatelessWidget {
  final Vehicle vehicle;

  const SecondScreen({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(vehicle.kenteken, style: TextStyle(fontSize: 16,),),
            Text(vehicle.voertuigsoort, style: TextStyle(fontSize: 16,),),
            Text(vehicle.handelsbenaming, style: TextStyle(fontSize: 16,)),
            Text(vehicle.merk, style: TextStyle(fontSize: 16,)),
            Text(vehicle.uitvoering, style: TextStyle(fontSize: 16,)),
            Text(vehicle.variant, style: TextStyle(fontSize: 16,)),
            Text(vehicle.inrichting, style: TextStyle(fontSize: 16,)),
            Text(DateTime.parse(vehicle.datum_eerste_toelating).toString(), style: TextStyle(fontSize: 16,)),
            Text(DateTime.parse(vehicle.vervaldatum_apk).toString(), style: TextStyle(fontSize: 16,)),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              }, child: Text("go terug"),
            )
          ],
        ),
      ),
    );
  }
}

bool validateBoard(String text) {
  text = text.replaceAll('-', '').toUpperCase();
  RegExp expression = RegExp(r"CD[ABFJNST][0-9]{1,3}");
  List<RegExp> expressions = List.empty(growable: true);
  expressions.add(RegExp(r"[^aeiouAEIOU\d]{2}[\d]{2}[\d]{2}"));
  expressions.add(RegExp(r"[\d]{2}[\d]{2}[^aeiouAEIOU\d]{2}"));
  expressions.add(RegExp(r"[\d]{2}[^aeiouAEIOU\d]{2}[\d]{2}"));
  expressions.add(RegExp(r"[^aeiouAEIOU\d]{2}[\d]{2}[^aeiouAEIOU\d]{2}"));
  expressions.add(RegExp(r"[^aeiouAEIOU\d]{2}[^aeiouAEIOU\d]{2}[\d]{2}"));
  expressions.add(RegExp(r"[\d]{2}[^aeiouAEIOU\d]{2}[^aeiouAEIOU\d]{2}"));
  expressions.add(RegExp(r"[\d]{2}[^aeiouAEIOU\d]{3}[\d]{1}"));
  expressions.add(RegExp(r"[\d]{1}[^aeiouAEIOU\d]{3}[\d]{2}"));
  expressions.add(RegExp(r"[^aeiouAEIOU\d]{2}[\d]{3}[^aeiouAEIOU\d]{1}"));
  expressions.add(RegExp(r"[^aeiouAEIOU\d]{1}[\d]{3}[^aeiouAEIOU\d]{2}"));
  expressions.add(RegExp(r"[^aeiouAEIOU\d]{3}[\d]{2}[^aeiouAEIOU\d]{1}"));
  expressions.add(RegExp(r"[^aeiouAEIOU\d]{1}[\d]{2}[^aeiouAEIOU\d]{3}"));
  expressions.add(RegExp(r"[\d]{1}[^aeiouAEIOU\d]{2}[\d]{3}"));
  expressions.add(RegExp(r"[\d]{3}[^aeiouAEIOU\d]{2}[\d]{1}"));

  for (int i = 0; i < expressions.length; i++) {
    if (expressions[i].hasMatch(text)) {
      return true;
    } else if (expression.hasMatch(text)) {
      return true;
    }
  }
  return false;
}