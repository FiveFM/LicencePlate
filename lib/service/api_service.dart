import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/vehicle.dart';
//https://opendata.rdw.nl/resource/m9d7-ebf2.json
class VehicleService {
      var client = http.Client();
      Future<dynamic> fetchVehicles(String input) async {
        var url = Uri.parse('https://opendata.rdw.nl/resource/m9d7-ebf2.json?kenteken=$input');
        var response = await client.get(url);

        if (response.statusCode < 300 && response.statusCode >= 200) {
          var decoded = jsonDecode(response.body)[0];
          return decoded;
        } else {
          //throw exception
        }

      }

}



