import 'package:flutter/material.dart';
import 'package:flutterprojects/service/api_service.dart';

import 'models/vehicle.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final vehicleService = VehicleService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vehicle List',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Vehicle List'),
        ), body: FutureBuilder<List<Vehicle>>(
          future: vehicleService.fetchVehicles(),
          builder: (context, snapshot) {
            print('Building FutureBuilder widget');
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index].kenteken),
                    subtitle: Text(snapshot.data![index].voertuigsoort),
                    // ...
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return CircularProgressIndicator();
          }
      ),
      ),
    );
  }
}
