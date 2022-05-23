class UserModel {
  final String email;
  final String firsName;
  final String surname;
  final String phoneNumber;
  final String location;

  UserModel(
      {required this.email,
      required this.firsName,
      required this.surname,
      required this.phoneNumber,
      required this.location});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      firsName: json['first_name'],
      surname: json['surname'],
      phoneNumber: json['phone_number'],
      location: json['location'],
    );
  }
}
