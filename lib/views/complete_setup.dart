import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstallytestappplication/components/rounded_back_button.dart';
import 'package:firstallytestappplication/components/verified_design.dart';
import 'package:firstallytestappplication/constants/data.dart';
import 'package:firstallytestappplication/controller/firebase_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Complete_Setup extends StatefulWidget {
  const Complete_Setup({Key? key}) : super(key: key);

  @override
  _Complete_SetupState createState() => _Complete_SetupState();
}

class _Complete_SetupState extends State<Complete_Setup> {

  Firebase_Controller controller = Firebase_Controller();
  final firestoreInstance = FirebaseFirestore.instance;

  var profile_uid = "";
  var profile_email = "";
  var profile_username = "";


  @override
  void initState() {
    getUserData();
    // TODO: implement initState
    super.initState();
  }

  void getUserData() {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    firestoreInstance.collection("User_Profiles").doc(firebaseUser!.uid)
        .get()
        .then((value) {
      setState(() {
        profile_email = value.data()!["email"];
        profile_username = value.data()!["username"];
        profile_uid = value.data()!["uid"];

        controller.email.text = value.data()!["email"];
        controller.username.text = value.data()!["username"];
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Rounded_Back_Buttton(),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, left: 45, bottom: 10),
                    child: Text("Complete your registration",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Center(
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10)
                            )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(() {
                                    return Center(
                                      child: Column(
                                        children: [

                                          controller.uploadedFileURL != ""
                                              ? CircleAvatar(
                                            radius: 60,
                                            backgroundImage:
                                            NetworkImage(
                                              controller.uploadedFileURL
                                                  .value,),
                                          )
                                              : controller.imageReady != true ?
                                          GestureDetector(
                                            onTap: () {
                                              controller.getImage2(
                                                  ImageSource.gallery);
                                            },
                                            child: Container(
                                              width: 100,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 4,
                                                      color: Theme
                                                          .of(context)
                                                          .scaffoldBackgroundColor),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        spreadRadius: 2,
                                                        blurRadius: 10,
                                                        color: Colors.black
                                                            .withOpacity(0.1),
                                                        offset: Offset(0, 10))
                                                  ],
                                                  shape: BoxShape.circle,
                                                  image: const DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                        "assets/images/add_user.png"),
                                                  )
                                              ),
                                            ),
                                          ) :
                                          Image.file(controller.singleImage),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          controller.uploadedFileURL != ""
                                              ? const Text(" ",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ) :
                                          const Text("Please select an image",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),

                                        ],
                                      ),
                                    );
                                  }),

                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      TextField(
                                        controller: controller.name,
                                        decoration: const InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.purple,
                                                width: 0.9),
                                          ),

                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                          labelStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),

                                          labelText: 'Full Name',
                                        ),
                                        onSubmitted: (String value) async {
                                          await showDialog<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Thanks!'),
                                                content: Text(
                                                    'You typed "$value", which has length ${value
                                                        .characters.length}.'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextField(
                                        controller: controller.email,
                                        decoration: const InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.purple,
                                                width: 0.9),
                                          ),

                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                          labelStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),

                                          labelText: 'Email',
                                        ),
                                        onChanged: (value) {
                                          value = controller.email.text;
                                        },
                                        onSubmitted: (String value) async {
                                          await showDialog<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Thanks!'),
                                                content: Text(
                                                    'You typed "$value", which has length ${value
                                                        .characters.length}.'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextField(
                                        controller: controller.username,
                                        decoration: const InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.purple,
                                                width: 0.9),
                                          ),

                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                          labelStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),

                                          labelText: 'Username',
                                        ),
                                        onChanged: (value) {
                                          value = controller.username.text;
                                        },
                                        onSubmitted: (String value) async {
                                          await showDialog<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Thanks!'),
                                                content: Text(
                                                    'You typed "$value", which has length ${value
                                                        .characters.length}.'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextField(
                                        controller: controller.company,
                                        decoration: const InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.purple,
                                                width: 0.9),
                                          ),

                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                          labelStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),

                                          labelText: 'Company name',
                                        ),
                                        onSubmitted: (String value) async {
                                          await showDialog<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Thanks!'),
                                                content: Text(
                                                    'You typed "$value", which has length ${value
                                                        .characters.length}.'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextField(
                                        controller: controller.position,
                                        decoration: const InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.purple,
                                                width: 0.9),
                                          ),

                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                          labelStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),

                                          labelText: 'Position',
                                        ),
                                        onSubmitted: (String value) async {
                                          await showDialog<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Thanks!'),
                                                content: Text(
                                                    'You typed "$value", which has length ${value
                                                        .characters.length}.'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextField(
                                        controller: controller.phoneNumber,
                                        decoration: const InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.purple,
                                                width: 0.9),
                                          ),

                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                          labelStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),

                                          labelText: 'Phone number',
                                        ),
                                        onSubmitted: (String value) async {
                                          await showDialog<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Thanks!'),
                                                content: Text(
                                                    'You typed "$value", which has length ${value
                                                        .characters.length}.'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextField(
                                        controller: controller.address,
                                        decoration: const InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.purple,
                                                width: 0.9),
                                          ),
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                          labelStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),

                                          labelText: 'Address',
                                        ),
                                        onSubmitted: (String value) async {
                                          await showDialog<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Thanks!'),
                                                content: Text(
                                                    'You typed "$value", which has length ${value
                                                        .characters.length}.'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),

                                      ///Menu Mode with no searchBox
                                      DropdownSearch<String>(
                                        validator: (v) =>
                                        v == null
                                            ? "required field"
                                            : null,
                                        hint: "Select a gender",
                                        mode: Mode.MENU,
                                        showSelectedItem: true,
                                        items: gender,
                                        label: "Select a gender *",
                                        showClearButton: true,
                                        onChanged: (value) {
                                          controller.gender.text = value!;
                                        },
                                        popupItemDisabled: (String? s) =>
                                        s?.startsWith('Z') ?? false,
                                        //Deactivate any option starting with letter Z
                                        clearButtonSplashRadius: 20,
                                        selectedItem: controller.gender.text,
                                        //Preselected data
                                        onBeforeChange: (a, b) {
                                          if (b == null) {
                                            AlertDialog alert = AlertDialog(
                                              title: const Text(
                                                  "Are you sure..."),
                                              content: const Text(
                                                  "...you want to clear the selection"),
                                              actions: [
                                                TextButton(
                                                  child: const Text("OK"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop(
                                                        true);
                                                  },
                                                ),
                                                TextButton(
                                                  child: const Text("NOT OK"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop(
                                                        false);
                                                  },
                                                ),
                                              ],
                                            );

                                            return showDialog<bool>(
                                                context: context,
                                                builder: (
                                                    BuildContext context) {
                                                  return alert;
                                                });
                                          }

                                          return Future.value(true);
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),

                                      ///BottomSheet Mode with searchBox
                                      DropdownSearch<String>(
                                        mode: Mode.BOTTOM_SHEET,
                                        items: stateData,
                                        label: "Select a state",
                                        onChanged: (value) {
                                          controller.state.text = value!;
                                        },
                                        selectedItem: controller.state.text,
                                        showSearchBox: true,
                                        searchFieldProps: TextFieldProps(
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            contentPadding: EdgeInsets.fromLTRB(
                                                12, 12, 8, 0),
                                            labelText: "Search a state",
                                          ),
                                        ),
                                        popupTitle: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Theme
                                                .of(context)
                                                .primaryColorDark,
                                            borderRadius: const BorderRadius
                                                .only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'Pick a state',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        popupShape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(24),
                                            topRight: Radius.circular(24),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 20,
                                  ),

                                  ButtonTheme(
                                      minWidth: double.infinity,
                                      child: GestureDetector(
                                        onTap: () {
                                          controller.Ccomplete_registration(
                                              controller.email.text,
                                              controller.username.text,
                                              controller.name.text,
                                              controller.address.text,
                                              controller.company.text,
                                              controller.state.text,
                                              controller.position.text,
                                              controller.gender.text,
                                              controller.phoneNumber.text
                                          );
                                        },
                                        child: Container(
                                            height: 50,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(5),
                                              gradient: const LinearGradient(
                                                  colors: [
                                                    Color(0xFF4e3789),
                                                    Color(0xFF281261),
                                                    Color(0xFF281261),
                                                    Color(0xFF281261)
                                                    //add more colors for gradient
                                                  ],
                                                  begin: Alignment.centerRight,
                                                  //begin of the gradient color
                                                  end: Alignment.centerLeft,
                                                  //end of the gradient color
                                                  stops: [
                                                    0.0,
                                                    0.9,
                                                    0.5,
                                                    0.8
                                                  ] //stops for individual color
                                                //set the stops number equal to numbers of color
                                              ),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "COMPLETE REGISTRATION",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                        ),
                                      )
                                  ),

                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      )
                  ),
                ],
              )
          )
      ),
    );
  }
}
