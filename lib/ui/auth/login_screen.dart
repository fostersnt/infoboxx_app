import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infoboxx/api/dio_client.dart';
import 'package:infoboxx/api/endpoints.dart';
import 'package:infoboxx/ui/fragments/bottom_navigation/dashboard_fragment_screen.dart';
import 'package:infoboxx/ui/onboarding/onboarding_starter_screen.dart';
import 'package:infoboxx/util/app_colors.dart';
import 'package:infoboxx/util/app_loaders.dart';
import 'package:infoboxx/util/app_notifications.dart';
import 'package:infoboxx/util/app_validators.dart';
import 'package:infoboxx/util/response_convertor.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                        height: MediaQuery.of(context).size.height / 4,
                        child: Image.asset("images/logo_white.webp"),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 8,
                        child: Column(
                          children: [
                            Text(
                              "WELCOME BACK !",
                              style: TextStyle(
                                color: AppColors.grayCoolSlate,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 5),
                            Obx(() {
                              if (isLoading.value == true) {
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
                                //! Email field
                                TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.email),
                                    hintText: "email",
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
                                //! Password field
                                Obx(
                                  () => TextFormField(
                                    controller: passwordController,
                                    obscureText: hidePassword.value,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.key),
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
                                            color: AppColors.blackPure,
                                          ),
                                        ),
                                      ),
                                      hintText: "password",
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
                                      try {
                                        String email = emailController.text
                                            .trim();
                                        String password = passwordController
                                            .text
                                            .trim();

                                        if (email == "") {
                                          AppNotifications.showErrorSnackBar(
                                            "Email Error",
                                            "Your email should not be empty",
                                          );
                                          return;
                                        }
                                        if (password == "") {
                                          AppNotifications.showErrorSnackBar(
                                            "Password Error",
                                            "Your password should not be empty",
                                          );
                                          return;
                                        }

                                        isLoading.value = true;
                                        const loginEndpoint =
                                            ApiEndpoint.SERVICE_PROVIDER_LOGIN;
                                        var requestData = {
                                          "email": email,
                                          "password": password,
                                        };
                                        var apiResponse = await DioClient
                                            .myDioObj
                                            .post(
                                              loginEndpoint,
                                              data: requestData,
                                            );

                                        Map<String, dynamic> response =
                                            apiResponse.data;

                                        String serverMessage =
                                            response['reason'] ??
                                            "An error occurred during login.";

                                        ResponseConvertor.convertToJson(
                                          response,
                                        );

                                        if (response['data']['status_code'] == 200) {
                                          Get.to(
                                            () => DashboardFragmentScreen(),
                                          );
                                        } else {
                                          AppNotifications.showErrorSnackBar(
                                            "Login Failed",
                                            serverMessage,
                                          );
                                        }
                                      } catch (e) {
                                        String errorMessage =
                                            "An unexpected error occurred.";

                                        if (e is DioException) {
                                          if (e.response != null &&
                                              e.response?.data != null) {
                                            // The server WAS reached, but returned an error status (400, 401, 500, etc.)
                                            errorMessage =
                                                e
                                                    .response
                                                    ?.data['data']['reason'] ??
                                                e
                                                    .response
                                                    ?.data['data']['reason'] ??
                                                "Server error.";
                                          } else {
                                            // The request NEVER reached your server!
                                            // Let's find out exactly why:
                                            switch (e.type) {
                                              case DioExceptionType
                                                  .connectionTimeout:
                                                errorMessage =
                                                    "Connection timed out. Please try again later.";
                                                break;
                                              case DioExceptionType.sendTimeout:
                                                errorMessage =
                                                    "Failed to send data to the server. Please check your connection.";
                                                break;
                                              case DioExceptionType
                                                  .receiveTimeout:
                                                errorMessage =
                                                    "Server took too long to respond. Please try again.";
                                                break;
                                              case DioExceptionType
                                                  .connectionError:
                                                errorMessage =
                                                    "No internet connection or the host server is completely unreachable.";
                                                break;
                                              case DioExceptionType.cancel:
                                                errorMessage =
                                                    "The request was cancelled.";
                                                break;
                                              default:
                                                errorMessage =
                                                    "Network connection failed: ${e.message}";
                                                break;
                                            }
                                          }
                                        } else {
                                          errorMessage = e.toString();
                                        }

                                        AppNotifications.showErrorSnackBar(
                                          "An Error Occurred",
                                          errorMessage,
                                        );
                                      }
                                      isLoading.value = false;
                                    },
                                    borderRadius: BorderRadius.circular(30),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 28,
                                      ),
                                      child: Text(
                                        "Login",
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
                                        "Don't have an Account?",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(color: AppColors.blackPure),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Get.to(() => OnboardingStarterScreen());
                                      },
                                      child: Text(
                                        "Onboard Now",
                                        style: TextStyle(
                                          color: AppColors.yellowColor,
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
