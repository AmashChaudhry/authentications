import 'package:authentications/src/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountUsername extends StatefulWidget {
  const AccountUsername({super.key, required this.fullName});

  final String fullName;

  @override
  State<AccountUsername> createState() => _AccountUsernameState();
}

class _AccountUsernameState extends State<AccountUsername> {
  RxBool isLoading = false.obs;
  RxBool emailAlreadyExists = false.obs;
  RxBool isButtonDisabled = true.obs;
  RxString statusMessage = 'Your friends can add you using your username.'.obs;

  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: pageBackgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 0.5,
                    color: Colors.black.withOpacity(0.2),
                  ),
                ),
              ),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: componentBackgroundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.chevron_left_rounded,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Create Account',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'Step 2 of 4',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Choose username',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: usernameController,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        isCollapsed: true,
                        hintText: 'Enter Username',
                        labelText: 'Username',
                        fillColor: componentBackgroundColor,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.2),
                        ),
                        prefixIcon: Icon(
                          Icons.alternate_email_rounded,
                          color: Colors.black.withOpacity(0.4),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: accentColor.withOpacity(0.5),
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                        ),
                      ),
                      onChanged: (value) async {
                        isLoading.value = true;
                        if (value.isEmpty) {
                          isButtonDisabled.value = true;
                          statusMessage.value = 'Your friends can add you using your username.';
                        } else if (value.length < 5) {
                          isButtonDisabled.value = true;
                          statusMessage.value = 'Username must be 5 characters long';
                        } else if (value.length > 4) {
                          isButtonDisabled.value = true;
                          statusMessage.value = 'Checking username...';
                          await FirebaseFirestore.instance.collection('Users').where('Username', isEqualTo: value).get().then((userSnapshot) {
                            if (userSnapshot.docs.isNotEmpty) {
                              isButtonDisabled.value = true;
                              statusMessage.value = 'Username $value is already taken';
                            } else {
                              isButtonDisabled.value = false;
                              statusMessage.value = 'Username $value is available';
                            }
                          });
                        }
                        isLoading.value = false;
                      },
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Obx(
                        () => Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (isLoading.value)
                              Padding(
                                padding: const EdgeInsets.only(left: 2, right: 3),
                                child: SizedBox(
                                  height: 10,
                                  width: 10,
                                  child: CircularProgressIndicator(
                                    color: Colors.black.withOpacity(0.6),
                                    strokeWidth: 1.5,
                                  ),
                                ),
                              )
                            else if (!isButtonDisabled.value)
                              const Icon(
                                Icons.check_circle_rounded,
                                color: Colors.green,
                                size: 15,
                              )
                            else if (usernameController.text.isNotEmpty)
                              const Icon(
                                Icons.error,
                                color: Colors.red,
                                size: 15,
                              ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                statusMessage.value,
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.8),
                                  fontSize: 12,
                                  // fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Obx(
                () => SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: isButtonDisabled.value
                      ? Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              'Continue',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            isLoading.value = true;
                            await FirebaseFirestore.instance.collection('Users').where('Username', isEqualTo: usernameController.text).get().then((userSnapshot) {
                              if (userSnapshot.docs.isNotEmpty) {
                                emailAlreadyExists.value = true;
                                isButtonDisabled.value = true;
                              } else {
                                emailAlreadyExists.value = false;
                                // Get.to(() => AccountPassword(email: emailController.text, name: widget.name));
                              }
                            });
                            isLoading.value = false;
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accentColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
