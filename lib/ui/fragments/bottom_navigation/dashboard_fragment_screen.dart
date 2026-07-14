import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infoboxx/ui/fragments/bottom_navigation/favorite_fragment_screen.dart';
import 'package:infoboxx/ui/fragments/bottom_navigation/home_fragment_screen.dart';
import 'package:infoboxx/ui/fragments/bottom_navigation/profile_fragment_screen.dart';

class DashboardFragmentScreen extends StatefulWidget {
  const DashboardFragmentScreen({super.key});

  @override
  State<DashboardFragmentScreen> createState() => _DashboardFragmentScreenState();
}

class _DashboardFragmentScreenState extends State<DashboardFragmentScreen> {
  List<Widget> fragmentScreens = [
    HomeFragmentScreen(),
    FavoriteFragmentScreen(),
    ProfileFragmentScreen()
  ];

  List navigationButtonsProperties = [
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

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
