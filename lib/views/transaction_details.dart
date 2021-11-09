import 'package:firstallytestappplication/controller/logic_controller.dart';
import 'package:firstallytestappplication/views/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Transaction_Details extends StatefulWidget {
  const Transaction_Details({Key? key}) : super(key: key);

  @override
  _Transaction_DetailsState createState() => _Transaction_DetailsState();
}

class _Transaction_DetailsState extends State<Transaction_Details> {

  var transactionDetails = Get.arguments;
  Crud_Logic crud_logic = Crud_Logic();

  @override
  Widget build(BuildContext context) {

    String uid = transactionDetails[0];
    String email = transactionDetails[1];
    String name = transactionDetails[2];
    String photoUrl = transactionDetails[3];

    String username = transactionDetails[4];
    String company = transactionDetails[5];
    String position = transactionDetails[6];
    String phone_number = transactionDetails[7];
    String date_of_registration = transactionDetails[8];

    String state = transactionDetails[9];
    String address = transactionDetails[10];
    String gender = transactionDetails[11];
    String sortData = transactionDetails[12];
    String docId = transactionDetails[13];


    String transaction_successful = transactionDetails[14];
    String currency_converted_amount = transactionDetails[15];
    String amount_paid = transactionDetails[16];
    String total_amount = transactionDetails[17];
    String total_number_transactions = transactionDetails[18];
    String currency_paid = transactionDetails[19];
    String currency_receive = transactionDetails[20];
    String conversion_rate = transactionDetails[21];


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
          "Confirm transaction details",
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
              Icons.person,
              color: Colors.green,
            ),
            onPressed: () {
              Get.to(() => const Profile());
            },
          ),
        ],
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient:LinearGradient(
                  colors: [
                    Color(0xFF4e3789),
                    Color(0xFF281261),
                    Color(0xFF281261),
                    Color(0xFF281261)
                    //add more colors for gradient
                  ],
                  begin: Alignment.topRight, //begin of the gradient color
                  end: Alignment.bottomRight, //end of the gradient color
                  stops: [0, 0.2, 0.5, 0.8] //stops for individual color
                //set the stops number equal to numbers of color
              ),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0)
              )
          ),
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                children: <Widget>[

                  const Divider(),
                  ListTile(
                    title: const Text("Currency"),
                    subtitle: Text(conversion_rate,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),),
                    leading: const Icon(Icons.local_parking_rounded),
                  ),
                  ListTile(
                    title: const  Text("Currency used in paying"),
                    subtitle: Text(currency_paid,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),),
                    leading: const Icon(Icons.monetization_on),
                  ),
                  ListTile(
                    title: const Text("Amount paid"),
                    subtitle: Text(amount_paid,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),),
                    leading: const Icon(Icons.money),
                  ),
                  ListTile(
                    title: const  Text("Currency to receive with"),
                    subtitle: Text(currency_receive,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),),
                    leading: const Icon(Icons.calendar_today),
                  ),
                  ListTile(
                    title: const Text("Transaction Status"),
                    subtitle: Text(transaction_successful,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),),
                    leading: const Icon(Icons.timer),
                  ),
                  ListTile(
                    title: const Text("Equivalent amount Naira"),
                    subtitle: Text(currency_converted_amount,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),),
                    leading: const Icon(Icons.timer),
                  ),
                  ListTile(
                    title: const Text("Total transactions"),
                    subtitle: Text(total_number_transactions,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),),
                    leading:const Icon(Icons.lock_clock),
                  ),
                  const Divider(
                    height: 2,
                    thickness: 1,
                  ),
                  ListTile(
                    title: const Text("Full Name"),
                    subtitle: Text(name),
                    leading: const Icon(Icons.person),
                  ),
                  ListTile(
                    title: const Text("Email"),
                    subtitle: Text(email),
                    leading: const Icon(Icons.email),
                  ),
                  ListTile(
                    title: const Text("Phone"),
                    subtitle: Text(phone_number),
                    leading: const Icon(Icons.phone),
                  ),
                  ListTile(
                    title: const Text("Position"),
                    subtitle: Text(position),
                    leading: const Icon(Icons.web),
                  ),

                  ListTile(
                    title: const Text("state"),
                    subtitle: Text(state),
                    leading: const Icon(Icons.location_on_rounded),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                          child: ButtonTheme(
                              minWidth: double.infinity,
                              child: GestureDetector(
                                onTap: () {
                                  crud_logic.userPayment(context, conversion_rate,
                                      amount_paid, email, name, username+sortData,
                                      phone_number,uid, docId);
                                },
                                child: Container(
                                    height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.blue),
                                    child: const  Center(
                                      child: Text("COMPLETE TRANSACTION",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                ),
                              )
                          ),
                        ),

                      ],
                    ),
                  )

                ],
              ),
            ),
          )
      ),
    );
  }
}
