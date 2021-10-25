import 'package:firstallytestappplication/views/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Transaction_Details extends StatefulWidget {
  const Transaction_Details({Key? key}) : super(key: key);

  @override
  _Transaction_DetailsState createState() => _Transaction_DetailsState();
}

class _Transaction_DetailsState extends State<Transaction_Details> {
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
          "Transaction details",
          style: TextStyle(
              fontSize: 20,
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
    );
  }
}
