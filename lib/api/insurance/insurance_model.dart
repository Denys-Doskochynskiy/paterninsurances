class InsuranceModel {
  final int id;
  final String condition;
  final String country;
  final String price;
  final bool isAvailable;
  final String title;
  final String reservedByUser;

  InsuranceModel(
      {required this.id,
      required this.condition,
      required this.reservedByUser,
      required this.country,
      required this.price,
      required this.isAvailable,
      required this.title});

  factory InsuranceModel.fromJson(Map<String, dynamic> json) {
    return InsuranceModel(
      id: json['id'],
      country: json['country'],
      condition: json['condition'],
      price: json['price'],
      isAvailable: json['is_available'],
      title: json['title'],
      reservedByUser: json['reserved_by_user']??"",
    );
  }
}
