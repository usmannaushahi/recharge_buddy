class BeneficiaryModel {
  String id;
  String name;
  String countryCode;
  String phoneNumber;
  num currentBalance;

  BeneficiaryModel({
    required this.id,
    required this.name,
    required this.countryCode,
    required this.phoneNumber,
    required this.currentBalance,
  });

  // Factory constructor to create a UserModel from a map (often used when converting JSON)
  factory BeneficiaryModel.fromJson(Map<String, dynamic> json) {
    return BeneficiaryModel(
      id: json['id'],
      name: json['name'],
      countryCode: json['countryCode'],
      phoneNumber: json['phoneNumber'],
      currentBalance: json['currentBalance'],
    );
  }

  // Method to convert UserModel to a map (often used when converting back to JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'countryCode': countryCode,
      'phoneNumber': phoneNumber,
      'currentBalance': currentBalance,
    };
  }
}
