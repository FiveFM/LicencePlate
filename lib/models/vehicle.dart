class Vehicle {
  final String kenteken;
  final String voertuigsoort;
  final String merk;
  final String handelsbenaming;
  // Other properties here

  Vehicle({required this.kenteken, required this.voertuigsoort, required this.merk, required this.handelsbenaming});

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      kenteken: json['kenteken'],
      voertuigsoort: json['voertuigsoort'],
      merk: json['merk'],
      handelsbenaming: json['handelsbenaming'],
      // Other properties here
    );
  }
}