import 'package:arshop/screens/home/home.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../constants/routes.dart';
import '../../screens/auth_ui/login/login.dart';
import '../../screens/auth_ui/signup/signup.dart';
import '../../widgets/appBar_title/top_title.dart';
import '../../widgets/primary_button/primary_button.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        // Navigate to Home page after successful sign-in
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Home()));
      }
    } catch (e) {
      print('Error signing in with Google: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign in with Google: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopTitle(
              title: 'Welcome to Ar Shopping App',
              subtitle: 'Test your item in real world environment before buying',
            ),
            CarouselSlider(
              items: [
                SizedBox(
                  height: 300, // Adjust the height as needed
                  child: Image.asset('assets/images/find.gif'),
                ),
                SizedBox(
                  height: 300, // Adjust the height as needed
                  child: Image.asset('assets/images/Payment_Information-pana-removebg-preview.gif'),
                ),
                SizedBox(
                  height: 300, // Adjust the height as needed
                  child: Image.asset('assets/images/shop.gif'),
                ),
              ],
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                viewportFraction: 0.9,
              ),
            ),
            const SizedBox(height: 24),

            PrimaryButton(
              onPressed: () {
                Routes.instance.push(const Login(), context);
              },
              title: 'Login',
            ),
            const SizedBox(height: 10),

            PrimaryButton(
              onPressed: () {
                Routes.instance.push(const Signup(), context);
              },
              title: 'Signup',
            ),
            const SizedBox(height: 18),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                  onPressed: () {
                    signInWithGoogle(context);
                  },
                  child: Image.asset(
                    'assets/images/google_300221.png',
                    scale: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
