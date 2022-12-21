import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
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
  String kenteken = '';
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
        title: const Text('Zoek auto op kenteken'),
      ),
      body: Column(
        children:[
          Padding(
            padding: EdgeInsets.all(16),
        child:
          TextField(
          controller: myController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Kenteken',
            ),
            onSubmitted: (text) async {
              text.replaceAll('-', '');

              if(validateBoard(text.toUpperCase())) {
                setState(() {
                  kenteken = text.replaceAll('-', '');
                });

                var response = await vehicleService.fetchVehicles(kenteken);
                if (response == null) return;
                // Create a Vehicle object from the JSON object
                var vehicle = Vehicle.fromJson(response);
                Navigator.push(
                    context, MaterialPageRoute(builder: (BuildContext context) {
                  return SecondScreen(vehicle: vehicle);
                }));
              } else {
                setState(() {
                  kenteken = "$text is geen geldig kenteken. Voer een geldig kenteken in!";
                });
              }
            },
          ),
          ),
          Padding(
          padding: EdgeInsets.all(0),
          child: Text(kenteken)),
        ],
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
        title: const Text('Kenteken details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kenteken: ${vehicle.kenteken}', style: TextStyle(fontSize: 18,),),
            Text('Voertuigsoort ${vehicle.voertuigsoort}', style: TextStyle(fontSize: 18,),),
            Text('Handelsbenaming: ${vehicle.handelsbenaming}', style: TextStyle(fontSize: 18,)),
            Text('Merk: ${vehicle.merk}', style: TextStyle(fontSize: 18,)),
            Text('Kleur: ${vehicle.eerste_kleur}', style: TextStyle(fontSize: 18,)),
            Text('Uitvoering: ${vehicle.uitvoering}', style: TextStyle(fontSize: 18,)),
            Text('Variant: ${vehicle.variant}', style: TextStyle(fontSize: 18,)),
            Text('Inrichting: ${vehicle.inrichting}', style: TextStyle(fontSize: 18,)),
            Text('Toelatings datum: ${DateTime.parse(vehicle.datum_eerste_toelating).toString()}', style: TextStyle(fontSize: 18,)),
            Text('Vervaldatum apk: ${DateTime.parse(vehicle.vervaldatum_apk).toString()}', style: TextStyle(fontSize: 18,)),
            TextButton(
              style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.black12), mouseCursor: MaterialStatePropertyAll<MouseCursor>(SystemMouseCursors.click)),
              onPressed: () {
                Navigator.pop(context);
              }, child: Text("ga terug"),
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