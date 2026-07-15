import 'package:flutter/material.dart';

class OnboardingStarterScreen extends StatefulWidget {
  const OnboardingStarterScreen({super.key});

  @override
  State<OnboardingStarterScreen> createState() => _OnboardingStarterState();
}

class _OnboardingStarterState extends State<OnboardingStarterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Onboarding Starter Screen"),
      ),
    );
  }
}
