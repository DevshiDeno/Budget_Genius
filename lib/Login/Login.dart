// ignore_for_file: prefer_const_constructors

import 'dart:ui';
import 'package:budget_genius/Dashboard/dashboard.dart';
import 'package:budget_genius/Provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../Components/my_button.dart';
import '../Components/textfield.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key, required this.text});
final String text;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final passwordController = TextEditingController();

  double _sigmaX = 5;
 // from 0-10
  double _sigmaY = 5;
 // from 0-10
  double _opacity = 0.2;

  final _formKey = GlobalKey<FormState>();
late String _email;
  @override
  void initState() {
    super.initState();
    // Initialize the text variable with an empty string
    _email=widget.text;
  }
  // sign user in method
  void signUserIn() {
    if (_formKey.currentState!.validate()) {
      print('valid');
    } else {
      print('not valid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.network(
                'https://anmg-production.anmg.xyz/yaza-co-za_sfja9J2vLAtVaGdUPdH5y7gA',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.26),
                  const Text("Log in",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ClipRect(
                    child: BackdropFilter(
                      filter:
                      ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 1)
                                .withOpacity(_opacity),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(30))),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Form(
                          key: _formKey,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Row(children: [
                                    const CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(
                                          'https://anmg-production.anmg.xyz/yaza-co-za_sfja9J2vLAtVaGdUPdH5y7gA'),
                                    ),
                                    SizedBox(
                                        width:
                                        MediaQuery.of(context).size.width *
                                            0.05),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        Text("Jane Dow",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 5),
                                        Text(_email,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15))
                                      ],
                                    )
                                  ]),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03),
                                MyTextField(
                                  controller: passwordController,
                                  hintText: 'Password',
                                  obscureText: true,
                                  onChanged: (value) {
                                    // // Update the password variable in your provider class
                                    // final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                                    // provider.updatePassword(value.trim());
                                  },
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                                MyButtonAgree(
                                  text: "Continue",
                                  onTap: () async {
                                    // final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                                    //
                                    // // // Check if the user entered the correct password
                                    // // if (provider.isPasswordCorrect()) {
                                    // //   // If so, log in using Google Sign-In
                                    // //   await provider.googleLogin(context);
                                    //
                                    //   // Navigate to dashboard
                                    //   Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(builder: (context) => Dashboard()),
                                    //   );
                                    // } else {
                                    //   // If not, show a snackbar with an error message
                                    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Incorrect Password')));
                                    // }
                                  },
                                ),
                                const SizedBox(height: 30),
                                const Text('Forgot Password?',
                                    style: TextStyle(
                                        color:
                                        Color.fromARGB(255, 71, 233, 133),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                    textAlign: TextAlign.start),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}