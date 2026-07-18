import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:infoboxx/ui/fragments/bottom_navigation/onboarding_fragment_screen.dart';
import 'package:infoboxx/ui/fragments/bottom_navigation/home_fragment_screen.dart';
import 'package:infoboxx/ui/fragments/bottom_navigation/profile_fragment_screen.dart';
import 'package:infoboxx/util/app_colors.dart';

class DashboardFragmentScreen extends StatefulWidget {
  const DashboardFragmentScreen({super.key});

  @override
  State<DashboardFragmentScreen> createState() =>
      _DashboardFragmentScreenState();
}

class _DashboardFragmentScreenState extends State<DashboardFragmentScreen> {
  final List<Widget> _fragmentScreens = [
    HomeFragmentScreen(),
    OnboardingFragmentScreen(),
    ProfileFragmentScreen(),
  ];

  final List _navigationButtonsProperties = [
    {
      "active_icon": Icons.home,
      "non_active_icon": Icons.home_outlined,
      "label": "Home",
    },
    {
      "active_icon": Icons.rocket_launch,
      "non_active_icon": Icons.rocket_launch_outlined,
      "label": "Onboarding",
    },
    {
      "active_icon": FontAwesomeIcons.person,
      "non_active_icon": Icons.person_outline,
      "label": "Profile",
    },
  ];

  RxInt indexNumber = 0.obs;

  // 1. Maintain a history stack of visited tab indexes
  final List<int> _navigationHistory = [0];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Intercept device back button
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        // 2. If we have historical screens left, step backward
        if (_navigationHistory.length > 1) {
          setState(() {
            _navigationHistory.removeLast(); // Remove current screen
            indexNumber.value = _navigationHistory.last; // View previous screen
          });
        } else {
          // 3. Stack is empty; safely exit the dashboard screen back to root
          // Navigator.of(context).pop();
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.whitePure,
        body: SafeArea(child: Obx(() => _fragmentScreens[indexNumber.value])),
        bottomNavigationBar: Obx(
              () => BottomNavigationBar(
            currentIndex: indexNumber.value,
            onTap: (val) {
              // Avoid duplicating the index if they tap the same active tab twice
              if (indexNumber.value != val) {
                indexNumber.value = val;
                // 4. Log the new tab journey into our history tracking stack
                _navigationHistory.add(val);
              }
            },
            backgroundColor: AppColors.blackGunMetal,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: AppColors.whitePure,
            unselectedItemColor: AppColors.yellowAmber,
            type: BottomNavigationBarType.fixed,
            items: List.generate(_navigationButtonsProperties.length, (index) {
              var navBtnProperty = _navigationButtonsProperties[index];
              return BottomNavigationBarItem(
                backgroundColor: AppColors.blackGunMetal,
                icon: navBtnProperty["non_active_icon"] is FaIconData
                    ? FaIcon(navBtnProperty["non_active_icon"])
                    : Icon(navBtnProperty["non_active_icon"]),
                activeIcon: navBtnProperty["active_icon"] is FaIconData
                    ? FaIcon(navBtnProperty["active_icon"])
                    : Icon(navBtnProperty["active_icon"]),
                label: navBtnProperty["label"],
              );
            }),
          ),
        ),
      ),
    );
  }
}