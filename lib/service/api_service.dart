import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutterprojects/models/licence_plate.dart';


Future<List<Car>?> fetchCar() async {

  Client client = Client();
  Uri uri = Uri.parse('https://opendata.rdw.nl/resource/m9d7-ebf2.json/');
  var response = await client.get(uri);

  if (response.statusCode < 300 && response.statusCode >= 200) {
    List<Car> carList;
    carList = (jsonDecode(response.body) as List).map((e) => Car.fromJson(e)).toList();
    return carList;
  } else {
    if (response.statusCode == 400) {
      return List.empty();
    }
    throw Exception('Failed to load car details');
  }
}