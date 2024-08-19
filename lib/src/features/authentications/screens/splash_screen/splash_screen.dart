import 'package:authentications/src/constants/colors.dart';
import 'package:authentications/src/features/authentications/screens/login/login_screen.dart';
import 'package:authentications/src/features/core/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void checkAuthentication() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Get.offAll(() => const HomeScreen());
      // if (user.emailVerified) {
      //   Get.offAll(() => const HomeScreen());
      // } else {
      //   Get.offAll(() => const HomeScreen());
      // }
    } else {
      Get.offAll(() => const LoginScreen());
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      checkAuthentication();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: pageBackgroundColor,
    );
  }
}
