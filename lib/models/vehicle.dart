class Vehicle {
  final String kenteken;
  final String voertuigsoort;
  final String merk;
  final String handelsbenaming;
  final String datum_tenaamstelling;
  final String bruto_bpm;
  // ...

  Vehicle({
    required this.kenteken,
    required this.voertuigsoort,
    required this.merk,
    this.handelsbenaming = '',
    this.datum_tenaamstelling = '',
    required this.bruto_bpm,
    // ...
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle.parse(json);
  }

  factory Vehicle.parse(Map<String, dynamic> json) {
    return Vehicle(
      kenteken: json['kenteken'],
      voertuigsoort: json['voertuigsoort'],
      merk: json['merk'],
      handelsbenaming: json['handelsbenaming'] ?? '',
      datum_tenaamstelling: json['datum_tenaamstelling'] ?? '',
      bruto_bpm: json['bruto_bpm'],
      // ...
    );
  }
}
