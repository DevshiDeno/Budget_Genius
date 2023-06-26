// ignore_for_file: prefer_const_constructors

import 'dart:ui';
import 'package:budget_genius/Login/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Components/my_button.dart';
import '../Components/squaretile.dart';
import '../Components/textfield.dart';
import '../Dashboard/dashboard.dart';
import '../Provider.dart';
import 'SignUp.dart';
import 'authentication.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late String text;
  String _password = "";

  // text editing controllers
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  double _sigmaX = 5;

  // from 0-10
  double _sigmaY = 5;

  // from 0-10
  double _opacity = 0.2;

  double _width = 350;

  double _height = 300;

  final _formKey = GlobalKey<FormState>();

  // sign user in method
  bool _isSigningIn = false;

  // void _signOut() async{
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  const Text("Hi !",
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
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 1)
                                .withOpacity(_opacity),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Form(
                          key: _formKey,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyTextField(
                                  controller: usernameController,
                                  hintText: "Enter Email",
                                  obscureText: false,
                                  onChanged: (value) {
                                    // Update the text variable when the user types in the TextField

                                    text = value;
                                  },
                                ),
                                const SizedBox(height: 10),
                                // sign in button

                                Consumer<GoogleSignInProvider>(
                                    builder: (context, provider, child) {
                                  return MyButton(onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      // Check if user is already logged in
                                      if (provider.user != null) {
                                        await provider.signIn();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage(text: text)),
                                        );
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Signup(text: text)));
                                      }
                                    } else {
                                      print('not valid');
                                    }
                                  });
                                }),

                                const SizedBox(height: 10),

                                // or continue with
                                Row(
                                  children: [
                                    Expanded(
                                      child: Divider(
                                        thickness: 0.5,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(
                                        'Or',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                    Expanded(
                                      child: Divider(
                                        thickness: 0.5,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 10),

                                // google + apple sign in buttons
                                FutureBuilder(
                                    future: Authentication.initializeFirebase(
                                        context: context),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return Text(
                                            'Error initializing Firebase');
                                      } else if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // facebook button
                                            GestureDetector(
                                              child: SquareTile(
                                                  imagePath:
                                                      'images/facebook.png',
                                                  title:
                                                      "Continue with Facebook"),
                                            ),
                                            SizedBox(height: 10),

                                            // google button
                                            GestureDetector(
                                              onTap: () {
                                                setState(() async {
                                                  final provider = Provider.of<
                                                          GoogleSignInProvider>(
                                                      context,
                                                      listen: false);
                                                  await provider.googleLogin();
                                                  // Check if user has a password set
                                                  final user = FirebaseAuth
                                                      .instance.currentUser;
                                                  if (user != null &&
                                                      user.providerData
                                                              .length ==
                                                          1 &&
                                                      user.providerData[0]
                                                              .providerId ==
                                                          'google.com') {
                                                    // User signed in with Google and doesn't have a password set
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                        title: Text(
                                                            'Set Password'),
                                                        content: TextField(
                                                          obscureText: true,
                                                          decoration:
                                                              InputDecoration(
                                                                  hintText:
                                                                      'Enter your password'),
                                                          onChanged: (value) {
                                                            _password =
                                                                value.trim();
                                                          },
                                                        ),
                                                        actions: [
                                                          ElevatedButton(
                                                            onPressed:
                                                                () async {
                                                              try {
                                                                await FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .updatePassword(
                                                                        _password);
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              } on FirebaseAuthException catch (e) {
                                                                print(
                                                                    e.message);
                                                              }
                                                            },
                                                            child: Text('Save'),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }
                                                });
                                              },
                                              child: SquareTile(
                                                  imagePath:
                                                      'images/google.png',
                                                  title:
                                                      "Continue with Google"),
                                            ),

                                            SizedBox(height: 10),

                                            // apple button
                                            SquareTile(
                                                imagePath: 'images/apple.png',
                                                title: "Continue with Apple"),
                                          ],
                                        );
                                      }
                                      return CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Colors.orange,
                                        ),
                                      );
                                    }),

                                const SizedBox(height: 10),

                                // not a member? register now
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          Text(
                                            'Don\'t have an account?',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                            textAlign: TextAlign.start,
                                          ),
                                          const SizedBox(width: 4),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Signup(
                                                            text: text,
                                                          )));
                                            },
                                            child: const Text(
                                              'Sign Up',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 71, 233, 133),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01),
                                      const Text('Forgot Password?',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 71, 233, 133),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                          textAlign: TextAlign.start),
                                    ],
                                  ),
                                ),
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

class Google extends StatelessWidget {
  const Google({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return Dashboard();
            } else if (snapshot.hasError) {
              return Center(child: Text("Something went wrong!"));
            } else {
              return WelcomePage();
            }
          }),
    );
  }
}
