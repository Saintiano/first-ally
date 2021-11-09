//User Model
class UserModel {
  final String uid;
  final String email;
  final String name;
  final String photoUrl;

  final String username;
  final String company;
  final String position;
  final String phone_number;
  final String date_of_registration;

  final String state;
  final String address;
  final String gender;
  final String total_number_transactions;
  final String total_amount;
  final String active;

  UserModel(
      {

        required this.uid,
        required this.email,
        required this.name,
        required this.photoUrl,

        required this.username,
        required this.company,
        required this.position,
        required this.phone_number,
        required this.date_of_registration,
        required this.state,
        required this.address,
        required this.gender,
        required this.total_number_transactions,
        required this.total_amount,
        required this.active,

      });

  factory UserModel.fromMap(Map data) {
    return UserModel(
      uid: data['uid']?? '',
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      photoUrl: data['photoUrl'] ?? '',

      username: data['position'] ?? '',
      position: data['position'] ?? '',
      phone_number: data['phone_number'] ?? '',
      gender: data['gender'] ?? '',
      date_of_registration: data['date_of_registration'] ?? '',
      state: data['state'] ?? '',
      total_amount: data['total_amount'] ?? '',
      address: data['address'] ?? '',
      company: data['company'] ?? '',
      total_number_transactions: data['total_number_transactions'] ?? '',
      active: data['active'] ?? '',

    );
  }

  Map<String, dynamic> toJson() =>
      {"uid": uid, "email": email, "name": name, "photoUrl": photoUrl,

        "position": position, "phone_number": phone_number, "gender": gender, "date_of_registration": date_of_registration,
        "state": state, "total_amount": total_amount, "address": address, "company": company,
        "total_number_transactions": total_number_transactions, "active": active, "username": username,
      };

}