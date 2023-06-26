import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';



class GoogleSignInProvider extends ChangeNotifier {
  GoogleSignInAccount? _user = GoogleSignIn().currentUser;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      // // Check if user has a password set
      // final user = FirebaseAuth.instance.currentUser;
      // if (user != null && user.providerData.length == 1 && user.providerData[0].providerId == 'google.com') {
      //   // User signed in with Google and doesn't have a password set
      //   showDialog(
      //     context: context,
      //     builder: (context) => AlertDialog(
      //       title: Text('Set Password'),
      //       content: TextField(
      //         obscureText: true,
      //         decoration: InputDecoration(hintText: 'Enter your password'),
      //         onChanged: (value) {
      //             _password = value.trim();
      //         },
      //       ),
      //       actions: [
      //         ElevatedButton(
      //           onPressed: () async {
      //             try {
      //               await FirebaseAuth.instance.currentUser!.updatePassword(_password);
      //               Navigator.of(context).pop();
      //             } on FirebaseAuthException catch (e) {
      //               print(e.message);
      //             }
      //           },
      //           child: Text('Save'),
      //         ),
      //       ],
      //     ),
      //   );
      // }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signIn() async {
    final account = await googleSignIn.signIn();
    _user = account!;
  }

  Future<void> signUp(String email, String password) async {
    try {
      if (!EmailValidator.validate(email)) {
        throw FirebaseAuthException(
          code: 'invalid-email',
          message: 'The email address is invalid.',
        );
      }

      if (password.isEmpty) {
        throw FirebaseAuthException(
          code: 'weak-password',
          message: 'The password is too weak.',
        );
      }

      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Initialize _user after sign up
      _user = googleSignIn.currentUser!;
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> logout(context) async {
    try {
      if (_auth.currentUser != null) {
        await _auth.signOut();
        await googleSignIn.disconnect();
        await googleSignIn.signOut();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  GoogleSignInAccount? get user => _user;

  // Add initialization check for _user
  bool get isUserInitialized => _user != null;

  @override
  void notifyListeners() {}
}