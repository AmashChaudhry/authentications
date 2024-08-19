import 'package:authentications/src/constants/colors.dart';
import 'package:authentications/src/features/authentications/screens/authentication_home/authentication_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackgroundColor,
      body: Center(
        child: SizedBox(
          height: 50,
          width: 200,
          child: ElevatedButton(
            onPressed: () async => await FirebaseAuth.instance.signOut().then((value) => Get.offAll(() => const AuthenticationHomeScreen())),
            style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
            child: const Text(
              'LOG OUT',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
