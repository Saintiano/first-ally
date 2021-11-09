import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstallytestappplication/constants/styles.dart';
import 'package:firstallytestappplication/controller/logic_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'transaction_details.dart';

class TRansaction_History extends StatefulWidget {
  const TRansaction_History({Key? key}) : super(key: key);

  @override
  _TRansaction_HistoryState createState() => _TRansaction_HistoryState();
}

class _TRansaction_HistoryState extends State<TRansaction_History> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  Crud_Logic crud_logic = Crud_Logic();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.green,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        title: const Text(
          "Transaction history",
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black38
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.green,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Transactions').doc(_auth.currentUser!.uid).collection("Payment").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot doc = snapshot.data!.docs[index];

                  return GestureDetector(
                      onTap: (){

                        String uid = doc['uid'];
                        String email = doc['email'];
                        String name = doc['name'];
                        String photoUrl = doc['photoUrl'];

                        String username = doc['username'];
                        String company = doc['company'];
                        String position = doc['position'];
                        String phone_number = doc['phone_number'];
                        String date_of_registration = doc['date_of_registration'];

                        String state = doc['state'];
                        String address = doc['address'];
                        String gender = doc['gender'];
                        String sortData = doc['sortData'];
                        String docId = doc['docId'];

                        String transaction_successful = doc['transaction_successful'];
                        String currency_converted_amount = doc['currency_converted_amount'];
                        String amount_paid = doc['amount_paid'];

                        String total_amount = doc['total_amount'];
                        String total_number_transactions = doc['total_number_transactions'];
                        String currency_paid = doc['currency_paid'];
                        String currency_receive = doc['currency_receive'];
                        String conversion_rate = doc['conversion_rate'];

                        Get.to(() => const Transaction_Details(), arguments: [
                          uid, email, name, photoUrl, username, company, position, phone_number, date_of_registration,
                          state, address, gender,  sortData, docId, transaction_successful, currency_converted_amount,
                          amount_paid, total_amount, total_number_transactions, currency_paid, currency_receive,
                          conversion_rate
                        ]

                        );
                      },
                      child: Container(
                        height: 100,
                        margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                        child: Card(
                          elevation: 5,
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: const AssetImage(
                                        "assets/images/bill.png"),
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.1),
                                        BlendMode.dstATop),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius:
                                  BorderRadius.circular(5.0),
                                  color: Colors.black87),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ListTile(
                                      leading: Container(
                                        height: 400,
                                        decoration: BoxDecoration(
                                            color: AppColor.lightgrey,
                                            borderRadius: BorderRadius.circular(10)),
                                        padding: const EdgeInsets.all(0),
                                        margin: const EdgeInsets.all(4),
                                        child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: const AssetImage(
                                                      "assets/images/bill.png"),
                                                  colorFilter: ColorFilter.mode(
                                                      Colors.black.withOpacity(0.0),
                                                      BlendMode.dstATop),
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(5.0),
                                                color: AppColor.purpleLight),
                                            height: 45,
                                            width: 45,
                                            child: Image.asset(
                                              "assets/images/bill.png",
                                            )
                                        ),
                                      ),
                                      title: Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              doc['name'],
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    doc['currency_converted_amount'],
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                        color: Colors.green,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                  Text(
                                                    doc['amount_paid'],
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                        color: Colors.white60,
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                ],
                                              )
                                          )
                                        ],
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            doc['conversion_rate'],
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                                color: Colors.white70,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            doc['transaction_successful'],
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                                color: Colors.white70,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: const Icon(FontAwesomeIcons.arrowRight,
                                        color: Colors.white70,
                                        size: 15,
                                      )
                                  ),

                                ],
                              )
                          ),
                        ),
                      )
                  );
                });
          } else {
            return const Text("No data");
          }
        },
      ),
    );
  }

}
