import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/service/api_service.dart';

import 'models/vehicle.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final vehicleService = VehicleService();
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vehicle List',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Vehicle List'),
        ),
        body: Column(
          children: [
            TextFormField(
              controller: textController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Vul kenteken in',
              ),
              onChanged: (e) => textController.text = e,
            ),
            TextButton(
              onPressed: () async {
                var response = await vehicleService.fetchVehicles(textController.text);
                if (response == null) return;

                // Create a Vehicle object from the JSON object
                var vehicle = Vehicle.fromJson(response);

                // Navigate to the second screen and pass the vehicle data as arguments
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SecondScreen(vehicle: vehicle),
                  ),
                );
              },
              child: Text('Wow'),
            ),
          ],
        ),
      ),
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
      body: Column(
        children: [
          Text(vehicle.kenteken),
          Text(vehicle.voertuigsoort),
          Text(vehicle.handelsbenaming),
          Text(vehicle.merk),
        ],
      ),
    );
  }
}
