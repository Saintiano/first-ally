
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave/core/flutterwave.dart';
import 'package:flutterwave/models/responses/charge_response.dart';
import 'package:flutterwave/utils/flutterwave_constants.dart';
import 'package:flutterwave/utils/flutterwave_currency.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:time_range_picker/time_range_picker.dart';

class Crud_Logic extends GetxController{

  final TextEditingController transaction_amount = TextEditingController();
  final TextEditingController currency_paid_with = TextEditingController();
  final TextEditingController currency_receive_with = TextEditingController();

  // Firestore operation
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;

  late DatabaseReference _userProfiles, transactions;

  var currencyID = "";
  var conversion_rate_calculated = 0;

  var bill_rate_dollars = 550;
  var bill_rate_euro = 650;
  var bill_rate_naira = 1;
  var bill_rate_pounds = 750;
  var bill_rate_rand = 260;
  var bill_rate_yuan = 330;
  var currency_converted_amount = 0;
  var transaction_sucessfull = false;
  var user_total_amount_transactions = 0;


  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  DateTime selectedDate = DateTime.now();
  var pickedDate = "date".obs;

  final String txref = "My_unique_transaction_reference_123";
  final String amount = "200";
  final String currency = FlutterwaveCurrency.RWF;

  @override
  void onInit() {
    super.onInit();

  }

  @override
  void onClose() {
    transaction_amount.dispose();
    currency_paid_with.dispose();
  }

  void clearEditingControllers() {
    transaction_amount.clear();
    currency_paid_with.clear();
  }

  Future<void> selectDate(BuildContext context) async {

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if(picked != null && picked != selectedDate){

      //convert picked date to local time
      selectedDate = picked.toLocal();

      //convert picked date to string and assign picked date to Obx variable pickedDate
      pickedDate.value = selectedDate.toString();

    }

  }

  //calculate amount in currency paid
  void calculateCurrencyAmountPaid(String amount_paid, String currency_paid){

    var amount = int.parse(amount_paid);

    if( currency_paid == 'Dollar' ){

      currency_converted_amount = amount * bill_rate_dollars;
      currencyID = FlutterwaveCurrency.USD;

    }else if( currency_paid == 'Euro' ){

      currency_converted_amount = amount * bill_rate_euro;
      currencyID = "EUR";

    }else if( currency_paid == 'Naira' ){

      currency_converted_amount = amount * bill_rate_naira;
      currencyID = FlutterwaveCurrency.NGN;

    }else if( currency_paid == 'Yuan' ){

      currency_converted_amount = amount * bill_rate_yuan;
      currencyID = "CNY";

    }else if( currency_paid == 'Rand' ){

      currency_converted_amount = amount * bill_rate_rand;
      currencyID = FlutterwaveCurrency.ZAR;

    }else if( currency_paid == 'Pound' ){

      currency_converted_amount = amount * bill_rate_pounds;
      currencyID = FlutterwaveCurrency.GBP;

    }

  }

  //calculate total generated revenue for projects worked on
  void calculateTotalAmountPaid(String amount_paid, int total_amount){

    print(amount_paid);

    var amount_paid_new = int.parse(amount_paid);

    user_total_amount_transactions = total_amount + amount_paid_new;

    print(user_total_amount_transactions);

  }

  //create and update Transaction
  void saveUpdateTransaction(String uid, String email, String name,
      String photoUrl, String username, String company, String position, String phone_number, String date_of_registration,
      String state, String address, String gender, String total_number_transactions, String total_amount,
      String currency_paid, String currency_receive, String date_to_receive_payment, String amount_paid,
      int addEditFlag, BuildContext context) {

    //get current date time
    final String formattedCurrentTime = formatter.format(now);
    String _sortTime = DateTime.now().microsecondsSinceEpoch.toString();

    //document reference id
    String documentId = username+_sortTime.toString();

    //calculate amount in currency paid
    calculateCurrencyAmountPaid(amount_paid, currency_paid);
    //calculate total amount transacted
    calculateTotalAmountPaid(amount_paid, currency_converted_amount);

    collectionReference  = firebaseFirestore.collection("Transactions");

    var transactionRef = username+_sortTime;

    //update user profile details
    _userProfiles = FirebaseDatabase.instance.reference().child('User_Profiles');
    transactions = FirebaseDatabase.instance.reference().child('Transactions');

    //userPayment(context, currencyID, amount_paid, email, name, transactionRef, phone_number);

    //beginPayment(context, currencyID, amount_paid, email, name, transactionRef, phone_number);

    //create the new user object
    Map<String, String> transactionInformations = {
      "uid": uid,
      "email": email,
      "name": name,
      "photoUrl": photoUrl,

      "username": username,
      "company": company,
      "position": position,
      "phone_number": phone_number,
      "date_of_registration": date_of_registration,
      "state": state,
      "address": address,
      "gender": gender,

      "total_number_transactions": user_total_amount_transactions.toString(),
      "total_amount": total_amount,
      "amount_paid": amount_paid,
      "currency_converted_amount" : currency_converted_amount.toString(),
      "currency_paid": currency_paid,
      "currency_receive": currency_receive,
      "transaction_successful": "Ongoing",
      "conversion_rate": currencyID,
      "date_created": formattedCurrentTime,
      "date_to_receive_payment": date_to_receive_payment,
      "sortData": _sortTime,
      "docId": documentId,
    };


    //update the user object
    Map<String, String> transactionInformationsUpdateUser = {
      "uid": uid,
      "total_number_transactions": total_number_transactions,
      "total_amount": currency_converted_amount.toString(),
    };

    print(uid);
    print(documentId);
    print(transactionInformations);

    if (addEditFlag == 1) {

      collectionReference
          .doc(uid).collection("Payment").doc(documentId)
          .set(transactionInformations).whenComplete(() {

        //clear editing controllers
        _updateUserFirestore(transactionInformationsUpdateUser, uid);

        Get.snackbar("Creating Transactions", "Successful",
          backgroundColor: Colors.green,
        );

      }).catchError((error) {

        Get.snackbar("Error creating transactions", error.toString(),
          backgroundColor: Colors.red,
        );

      });

    } else if (addEditFlag == 2) {
      //update transaction

      collectionReference
          .doc(uid).collection("Payment").doc(documentId)
          .update(transactionInformations).whenComplete(() {

        //clear editing controllers
        _updateUserFirestore(transactionInformationsUpdateUser, uid);

        clearEditingControllers();

        Get.back();

        Get.snackbar("Updating Transactions", "Successful",
          backgroundColor: Colors.green,
        );

      }).catchError((error) {

        Get.snackbar("Error updating Transactions", error.toString(),
          backgroundColor: Colors.red,
        );

      });
    }
  }

  //create the firestore transaction in transaction collection
  void transactionsUser(Map<String, String> userdata, String uid, String docID) {
    FirebaseFirestore.instance
        .collection("Transactions")
        .doc(uid)
        .collection("Payment")
        .doc(docID)
        .update(userdata);

    transactions.child(uid).child(docID).set(userdata);

  }

  //create the firestore user in users collection
  void _updateUserFirestore(Map<String, String> userdata, String uid) {
    FirebaseFirestore.instance
        .collection("User_Profiles")
        .doc(uid)
        .update(userdata);

    _userProfiles.child(uid).update(userdata);

  }

 userPayment(BuildContext context, String currency, String amount_paid, String email, String name, String transactionRef,
     String phoneNumber, String uid, String docID ) async {

    final Flutterwave flutterwave = Flutterwave.forUIPayment(
        context: context,
        encryptionKey: "FLWSECK_TEST58fd60afa357",
        publicKey: "FLWPUBK_TEST-4dcdfa4fbf3cba1a87b7717e12f3320c-X",
        currency: currency,
        amount: amount_paid,
        email: email,
        fullName: name,
        txRef: transactionRef,
        isDebugMode: true,
        phoneNumber: phoneNumber,
        acceptCardPayment: true,
        acceptUSSDPayment: true,
        acceptAccountPayment: true,
        acceptFrancophoneMobileMoney: false,
        acceptGhanaPayment: false,
        acceptMpesaPayment: false,
        acceptRwandaMoneyPayment: true,
        acceptUgandaPayment: false,
        acceptZambiaPayment: false);

    bool checkPaymentIsSuccessful(final ChargeResponse response) {
      return response.data!.status == FlutterwaveConstants.SUCCESSFUL &&
          response.data!.currency == this.currency &&
          response.data!.amount == this.amount &&
          response.data!.txRef == this.txref;
    }

    //create the new user object
    Map<String, String> transactionCompleted = {
      "transaction_successful": "Completed",
    };

    try {
      final ChargeResponse response = await flutterwave.initializeForUiPayments();

      if (response == null) {
        // user didn't complete the transaction.
      } else {
        final isSuccessful = checkPaymentIsSuccessful(response);
        if (isSuccessful) {
          // provide value to customer
          Get.snackbar("Payment Success",
              "Payment Successful, an Email will be sent to you soon", backgroundColor: Colors.green);
          //Update transaction to completed
          transactionsComplete(transactionCompleted, uid, docID);

        } else {
          // check message
          print(response.message);

          // check status
          print(response.status);

          // check processor error
          print(response.data!.processorResponse);

          Get.snackbar("Payment Failed",
              "Payment was not Successful, "+response.message.toString(), backgroundColor: Colors.red);
        }
      }
    } catch (error, stacktrace) {
      // handleError(error);
      //print(stacktrace);
      Get.snackbar("Payment",
          "Payment not Successful, "+error.toString(), backgroundColor: Colors.red);
    }

  }

  void transactionsComplete(Map<String, String> userdata, String uid, String docID) {
    FirebaseFirestore.instance
        .collection("Transactions")
        .doc(uid)
        .collection("Payment")
        .doc(docID)
        .update(userdata);

    transactions.child(uid).child(docID).set(userdata);

  }


}