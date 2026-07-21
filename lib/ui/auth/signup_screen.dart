import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infoboxx/services/api/dio_client.dart';
import 'package:infoboxx/services/api/api_endpoints.dart';
import 'package:infoboxx/services/app/user_service.dart';
import 'package:infoboxx/ui/fragments/bottom_navigation/dashboard_fragment_screen.dart';
import 'package:infoboxx/ui/onboarding/onboarding_starter_screen.dart';
import 'package:infoboxx/util/app_colors.dart';
import 'package:infoboxx/util/app_loaders.dart';
import 'package:infoboxx/util/app_notifications.dart';
import 'package:infoboxx/util/app_validators.dart';
import 'package:infoboxx/util/response_convertor.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final userService = Get.find<UserService>();

  var hidePassword = true.obs;
  var isLoading = false.obs;
  // var isFormValidated = false.obs;
  // var formErrorMessage = "".obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitePure,
      body: LayoutBuilder(
        builder: (context, cons) {
          return ConstrainedBox(
            constraints: BoxConstraints(minHeight: cons.maxHeight),
            child: SingleChildScrollView(
              // physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 5,
                        child: Image.asset("images/logo_white.webp"),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 8,
                        child: Column(
                          children: [
                            // Text(
                            //   "WELCOME BACK !",
                            //   style: TextStyle(
                            //     color: AppColors.grayCoolSlate,
                            //     fontSize: 20,
                            //   ),
                            // ),
                            // SizedBox(height: 5),
                            Obx(() {
                              if (userService.isLoading.value == true) {
                                return AppLoaders.fourCirclePulse();
                              } else {
                                return Text("");
                              }
                            }),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.grayLightSilver,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                SizedBox(height: 30),
                                //! Company name field
                                TextFormField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: AppColors.grayCoolSlate,
                                    ),
                                    hintText: "company name...",
                                    hintStyle: TextStyle(color: AppColors.blackGunMetal.withOpacity(0.35)),
                                    filled: true,
                                    fillColor: AppColors.whitePure,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                        color: AppColors.grayLightSilver,
                                      ),
                                    ),
                                    // 1. Border when the field is enabled (idle)
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                        color: AppColors.grayLightSilver,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                        color: AppColors.grayLightSilver,
                                      ),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                        color: AppColors.grayLightSilver,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30),
                                //! Company email field
                                TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: AppColors.grayCoolSlate,
                                    ),
                                    hintText: "company email...",
                                    hintStyle: TextStyle(color: AppColors.blackGunMetal.withOpacity(0.35)),
                                    filled: true,
                                    fillColor: AppColors.whitePure,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                        color: AppColors.grayLightSilver,
                                      ),
                                    ),
                                    // 1. Border when the field is enabled (idle)
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                        color: AppColors.grayLightSilver,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                        color: AppColors.grayLightSilver,
                                      ),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                        color: AppColors.grayLightSilver,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30),
                                //! Company email field
                                Obx(
                                      () => TextFormField(
                                    controller: phoneController,
                                    obscureText: hidePassword.value,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.key,
                                        color: AppColors.grayCoolSlate,
                                      ),
                                      suffixIcon: Obx(
                                            () => GestureDetector(
                                          onTap: () {
                                            hidePassword.value =
                                            !hidePassword.value;
                                          },
                                          child: Icon(
                                            hidePassword.value == true
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: AppColors.grayCoolSlate,
                                          ),
                                        ),
                                      ),
                                      hintText: "phone number...",
                                      hintStyle: TextStyle(color: AppColors.blackGunMetal.withOpacity(0.35)),
                                      filled: true,
                                      fillColor: AppColors.whitePure,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                          color: AppColors.grayLightSilver,
                                        ),
                                      ),
                                      // 1. Border when the field is enabled (idle)
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                          color: AppColors.grayLightSilver,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                          color: AppColors.grayLightSilver,
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                          color: AppColors.grayLightSilver,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30),
                                Material(
                                  color: AppColors.blackPure,
                                  borderRadius: BorderRadius.circular(30),
                                  child: InkWell(
                                    onTap: () async {
                                      String company_name = emailController.text.trim();
                                      String company_email = emailController.text.trim();
                                      String company_phone = phoneController.text.trim();
                                      bool check = await userService.userSignUp(
                                        company_name: company_name,
                                        company_email: company_email,
                                        company_phone: company_phone,
                                        forceRefresh: false,
                                      );

                                      if(check == true){
                                        Get.to(() => DashboardFragmentScreen());
                                      }else{
                                        AppNotifications.showErrorSnackBar("SignUp Error", userService.errorMessage.value);
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(30),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 28,
                                      ),
                                      child: Text(
                                        "SignUp",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Already have an Account?",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          color: AppColors.blackPure,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Get.to(() => OnboardingStarterScreen());
                                      },
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                          color: AppColors.blackCharcoal,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
