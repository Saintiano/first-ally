import 'package:firstallytestappplication/components/make_transaction.dart';
import 'package:firstallytestappplication/components/network_image.dart';
import 'package:firstallytestappplication/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'transaction_history.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  static final String path = "lib/src/pages/profile/profile3.dart";
  final image = avatars[1];

  late TextEditingController _escalation_additional_comment;

  @override
  void initState() {
    super.initState();
    _escalation_additional_comment = TextEditingController();
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
          "Dashboard",
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
              Icons.settings,
              color: Colors.green,
            ),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 180,
                      decoration: const BoxDecoration(
                          color: Colors.blueAccent,
                      ),
                      child: Column(
                        children: [
                          Center(
                              child: Container(
                                margin: const EdgeInsets.only(top: 40),
                                padding: const EdgeInsets.all(5),
                                width: 140,
                                height: 25,
                                decoration: const BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(100),
                                        bottomRight: Radius.circular(100),
                                        topRight: Radius.circular(100),
                                        topLeft: Radius.circular(100)
                                    )
                                ),
                                child: const Center(
                                  child:  Text("Available Balance",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                              )
                          ),
                          Container(
                            child: Center(
                                child: Container(
                                    margin: const EdgeInsets.only(top: 0),
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(100),
                                            bottomRight: Radius.circular(100),
                                            topRight: Radius.circular(100),
                                            topLeft: Radius.circular(100)
                                        )
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          Text("120,000,000",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text("Naira",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                )
                            ),
                          ),
                        ],
                      )
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(16.0, 100.0, 16.0, 16.0),
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            margin: const EdgeInsets.only(top: 16.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.only(left: 96.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const <Widget>[
                                      ListTile(
                                        contentPadding: EdgeInsets.all(0),
                                        title: Text("Full Name : "),
                                        subtitle: Text("Username : "),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Divider(
                                  height: 10.0,
                                  thickness: 1,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        children: const <Widget>[
                                          Text("285",
                                            style: TextStyle(

                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text("Total Transactions")
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: const <Widget>[
                                          Text("650"),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text("Total Amounts")
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                    image: NetworkImage(image), fit: BoxFit.cover)),
                            margin: const EdgeInsets.only(left: 16.0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),

                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(0.0),
              ),
              child: Row(
                children: const [
                  Make_Transaction(),
                  Transaction_History()
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
