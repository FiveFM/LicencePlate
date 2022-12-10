import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/vehicle.dart';

class VehicleService {
  Future<List<Vehicle>> fetchVehicles() async {
    try {
      final response = await http.get(Uri.parse('https://opendata.rdw.nl/resource/m9d7-ebf2.json'));
      print('Response status code: ${response.statusCode}');
      if (response.statusCode < 300 && response.statusCode >= 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        var data = json.decode(response.body);
        return data.map((item) => Vehicle(
          kenteken: item["kenteken"],
          voertuigsoort: item["voertuigsoort"],
          merk: item["merk"],
          handelsbenaming: item['handelsbenaming'],
          datum_tenaamstelling: item['datum_tenaamstelling'],
          bruto_bpm: item['bruto_bpm'],

        )).toList();
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load vehicles');
      }
    } catch (error) {
      // Handle any errors that may occur when using the http.get method
      print(error);
      return [];
    }
  }

}



