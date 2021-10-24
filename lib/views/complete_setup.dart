import 'package:firstallytestappplication/components/rounded_back_button.dart';
import 'package:firstallytestappplication/components/verified_design.dart';
import 'package:flutter/material.dart';

class Complete_Setup extends StatefulWidget {
  const Complete_Setup({Key? key}) : super(key: key);

  @override
  _Complete_SetupState createState() => _Complete_SetupState();
}

class _Complete_SetupState extends State<Complete_Setup> {

  final TextEditingController _verify = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Rounded_Back_Buttton(),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, left: 45, bottom: 10),
                    child: Text("Verify your account",
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
                                  Center(
                                    child: Column(
                                      children: const [
                                        Verified_Design(),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Text("We just sent you a verification code to your email",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text("Please enter the code",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      TextField(
                                        controller: _verify,
                                        decoration: const InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.purple, width: 0.9),
                                          ),

                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                          labelStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),

                                          labelText: 'Verification code',
                                        ),
                                        onSubmitted: (String value) async {
                                          await showDialog<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Thanks!'),
                                                content: Text ('You typed "$value", which has length ${value.characters.length}.'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () { Navigator.pop(context); },
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),

                                    ],
                                  ),

                                  const SizedBox(
                                    height: 20,
                                  ),

                                  ButtonTheme(
                                      minWidth: double.infinity,
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                            height: 50,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              gradient: const LinearGradient(
                                                  colors: [
                                                    Color(0xFF4e3789),
                                                    Color(0xFF281261),
                                                    Color(0xFF281261),
                                                    Color(0xFF281261)
                                                    //add more colors for gradient
                                                  ],
                                                  begin: Alignment.centerRight, //begin of the gradient color
                                                  end: Alignment.centerLeft, //end of the gradient color
                                                  stops: [0.0, 0.9, 0.5, 0.8] //stops for individual color
                                                //set the stops number equal to numbers of color
                                              ),
                                            ),
                                            child: const  Center(
                                              child: Text("VERIFY ME",
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

                                  Center(
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text("This code will expire in 10 minutes",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        GestureDetector(
                                          child: const Text("Resent Code",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
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
