import 'package:json_annotation/json_annotation.dart';


class Car {
  final String kenteken;
  final String? merk;
  final String? voertuigsoort;
  final String? handelsbenaming;
  final DateTime? apkDatum;
  final DateTime? toalingDatum;
  final String? eersteKleur;
  final String? brutoBpm;
  final String? inrichting;
  final String? aantalWielen;

  const Car({
    required this.kenteken,
    this.merk,
    this.voertuigsoort,
    this.handelsbenaming,
    this.apkDatum,
    this.toalingDatum,
    this.eersteKleur,
    this.brutoBpm,
    this.inrichting,
    this.aantalWielen,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      kenteken: json['kenteken'],
      merk: json['merk'],
      voertuigsoort: json['voertuigsoort'],
      handelsbenaming: json['handelsbenaming'],
      apkDatum: json['vervaldatum_apk'],
      toalingDatum: json['datum_eerste_toelating'],
      eersteKleur: json['eerste_kleur'],
      brutoBpm: json['bruto_bpm'],
      inrichting: json['inrichting'],
      aantalWielen: json['aantal_wielen'],
    );
  }
}