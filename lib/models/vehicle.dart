class Vehicle {
  final String kenteken;
  final String voertuigsoort;
  final String merk;
  final String handelsbenaming;
  final String eerste_kleur;
  final String inrichting;
  final String datum_eerste_toelating;
  final String variant;
  final String vervaldatum_apk;
  final String uitvoering;

  // Other properties here

  Vehicle({required this.kenteken, required this.voertuigsoort, required this.merk, required this.handelsbenaming, required this.eerste_kleur, required this.inrichting, required this.datum_eerste_toelating, required this.variant, required this.vervaldatum_apk, required this.uitvoering  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      kenteken: json['kenteken'],
      voertuigsoort: json['voertuigsoort'],
      merk: json['merk'],
      handelsbenaming: json['handelsbenaming'],
      eerste_kleur: json['eerste_kleur'],
      inrichting: json['inrichting'],
      datum_eerste_toelating: json['datum_eerste_toelating_dt'],
      variant: json['variant'],
      vervaldatum_apk: json['vervaldatum_apk_dt'],
      uitvoering: json['uitvoering'],// Other properties here
    );
  }
}