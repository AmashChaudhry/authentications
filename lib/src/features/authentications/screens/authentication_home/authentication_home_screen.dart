import 'package:authentications/src/constants/colors.dart';
import 'package:authentications/src/features/authentications/screens/login/login_screen.dart';
import 'package:authentications/src/features/authentications/screens/signup/account_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationHomeScreen extends StatefulWidget {
  const AuthenticationHomeScreen({super.key});

  @override
  State<AuthenticationHomeScreen> createState() => _AuthenticationHomeScreenState();
}

class _AuthenticationHomeScreenState extends State<AuthenticationHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: pageBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.5,
                width: double.infinity,
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () => Get.to(() => const LoginScreen()),
                        style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: accentColor,
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        child: const Text(
                          'LOG IN',
                          style: TextStyle(
                            color: accentColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => Get.to(() => const AccountName()),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: accentColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        child: const Text(
                          'SIGN UP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
