import 'package:afronex_shop_app/providers/user_controller.dart';
import 'package:afronex_shop_app/screens/bottom_navigations/cartpage.dart';
import 'package:afronex_shop_app/screens/bottom_navigations/home.dart';
import 'package:afronex_shop_app/screens/bottom_navigations/profile_page.dart';
import 'package:afronex_shop_app/screens/bottom_navigations/search.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:get/get.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int page = 0;
  UserController controller = Get.put(UserController());

  List<Widget> pages = const [
    HomePage(),
    SearchPage(),
    CartPage(),
    ProfilePage(),
  ];

  void _updatePage(int value) {
    setState(() {
      page = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[page],
      bottomNavigationBar: GNav(
        onTabChange: (value) {
          _updatePage(value);
        },
        activeColor: Colors.teal,
        gap: 10,
        color: Colors.black,
        tabs: const [
          GButton(icon: Icons.home, text: 'Home'),
          GButton(icon: Icons.search, text: 'Search'),
          GButton(icon: Icons.shopping_cart, text: 'Cart'),
          GButton(icon: Icons.person, text: 'Profile'),
        ],
      ),
    );
  }
}
