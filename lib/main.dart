import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutterprojects/service/api_service.dart';
import 'package:flutterprojects/models/licence_plate.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Car>?> futureCar;

  @override
  void initState() {
    super.initState();
    futureCar = fetchCar();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<List<Car>?>(
            future: futureCar,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data![0].kenteken);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}