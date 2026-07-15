import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infoboxx/ui/onboarding/starter_starter.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, cons) {
          return ConstrainedBox(
            constraints: BoxConstraints(minHeight: cons.maxHeight),
            child: SingleChildScrollView(
              child: Center(
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
                          child: Text(
                            "WELCOME BACK !",
                            style: TextStyle(color: Colors.grey, fontSize: 20),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
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
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      // 1. Border when the field is enabled (idle)
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                          color: Colors.white60,
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
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        hintText: "password",
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,
                                          ),
                                        ),
                                        // 1. Border when the field is enabled (idle)
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,
                                          ),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  Material(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(30),
                                    child: InkWell(
                                      onTap: () => {},
                                      borderRadius: BorderRadius.circular(30),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 28),
                                        child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 16),),
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
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Get.to(
                                            () => OnboardingStarterScreen(),
                                          );
                                        },
                                        child: Text(
                                          "Onboard Now",
                                          style: TextStyle(
                                            color: Color(0xFFFBC31B),
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
            ),
          );
        },
      ),
    );
  }
}
