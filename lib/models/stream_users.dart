import 'package:cloud_firestore/cloud_firestore.dart';

class StreamUsers {

  String? uid;
  late String email;
  late String name;
  late String photoUrl;

  late String username;
  late String company;
  late String position;
  late String phone_number;
  late String date_of_registration;

  late String state;
  late String address;
  late String gender;
  late String total_number_transactions;
  late String total_amount;
  late String active;

  late String amount_paid;
  late String conversion_rate;
  late String currency_converted_amount;
  late String transaction_successful;
  late String date_created;
  late String date_to_receive_payment;
  late String currency_paid;
  late String currency_receive;
  late String sortData;
  late String docId;

  StreamUsers({
    required this.email,
    required this.name,
    required this.username,
    required this.company,
    required this.position,
    required this.phone_number,
    required this.date_of_registration,
    required this.state,
    required this.address,
    required this.gender,
    required this.amount_paid,
    required this.total_number_transactions,
    required this.total_amount,
    required this.currency_converted_amount,
    required this.active,
    required this.conversion_rate,
    required this.transaction_successful,
    required this.date_created,
    required this.currency_paid,
    required this.currency_receive,
    required this.date_to_receive_payment,

    required this.sortData,
    required this.docId,

  });

  StreamUsers.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {

    uid = documentSnapshot.id;
    name = documentSnapshot["name"];
    email = documentSnapshot["email"];
    username = documentSnapshot["username"];
    company = documentSnapshot["company"];
    position = documentSnapshot["position"];
    phone_number = documentSnapshot["phone_number"];
    date_of_registration = documentSnapshot["date_of_registration"];
    state = documentSnapshot["total_hours_worked"];
    address = documentSnapshot["address"];
    gender = documentSnapshot["gender"];
    total_number_transactions = documentSnapshot["total_number_transactions"];
    amount_paid  = documentSnapshot["amount_paid"];
    total_amount = documentSnapshot["total_amount"];
    active = documentSnapshot["active"];
    conversion_rate = documentSnapshot["conversion_rate"];

    currency_converted_amount = documentSnapshot["currency_converted_amount"];
    transaction_successful = documentSnapshot["transaction_successful"];
    date_created = documentSnapshot["date_created"];
    currency_paid = documentSnapshot["currency_paid"];
    currency_receive = documentSnapshot["currency_receive"];
    date_to_receive_payment = documentSnapshot["date_to_receive_payment"];
    sortData = documentSnapshot["sortData"];
    docId = documentSnapshot["docId"];

  }
}
