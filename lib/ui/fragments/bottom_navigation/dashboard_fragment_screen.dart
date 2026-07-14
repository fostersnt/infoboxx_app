import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:infoboxx/ui/fragments/bottom_navigation/favorite_fragment_screen.dart';
import 'package:infoboxx/ui/fragments/bottom_navigation/home_fragment_screen.dart';
import 'package:infoboxx/ui/fragments/bottom_navigation/profile_fragment_screen.dart';

class DashboardFragmentScreen extends StatefulWidget {
  const DashboardFragmentScreen({super.key});

  @override
  State<DashboardFragmentScreen> createState() => _DashboardFragmentScreenState();
}

class _DashboardFragmentScreenState extends State<DashboardFragmentScreen> {
  final List<Widget> _fragmentScreens = [
    HomeFragmentScreen(),
    FavoriteFragmentScreen(),
    ProfileFragmentScreen()
  ];

  final List _navigationButtonsProperties = [
    {
      "active_icon": Icons.home,
      "non_active_icon": Icons.home_outlined,
      "label": "Home",
    },
    {
      "active_icon": Icons.favorite,
      "non_active_icon": Icons.favorite_border,
      "label": "Favorites",
    },
    {
      "active_icon": FontAwesomeIcons.person,
      "non_active_icon": Icons.person_outline,
      "label": "Profile",
    },
  ];

  RxInt indexNumber = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Obx(
            () => _fragmentScreens[indexNumber.value]
        ),
      ),
      bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: indexNumber.value,
            onTap: (val){
              indexNumber.value = val;
            },
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white24,
            items: List.generate(_navigationButtonsProperties.length, (index) {
             var navBtnProperty = _navigationButtonsProperties[index];
             return BottomNavigationBarItem(
               backgroundColor: Colors.black,
               icon: Icon(navBtnProperty["non_active_icon"]),
               activeIcon: Icon(navBtnProperty["active_icon"]),
               label: navBtnProperty["label"],
             );
            }),
          )
      ),
    );
  }
}
