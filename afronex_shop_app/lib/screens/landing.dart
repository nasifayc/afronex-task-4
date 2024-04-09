import 'package:afronex_shop_app/screens/bottom_navigations/cart/cartpage.dart';
import 'package:afronex_shop_app/screens/bottom_navigations/home.dart';
import 'package:afronex_shop_app/screens/bottom_navigations/profile_page.dart';
import 'package:afronex_shop_app/screens/bottom_navigations/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class LandingPage extends StatelessWidget {
  LandingPage({super.key});

  final List<Widget> pages = [
    HomePage(),
    const SearchPage(),
    CartPage(),
    const ProfilePage(),
  ];

  final RxInt selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => IndexedStack(
              index: selectedIndex.value,
              children: pages,
            )),
        bottomNavigationBar: Obx(
          () => GNav(
            selectedIndex: selectedIndex.value,
            onTabChange: (value) => selectedIndex.value = value,
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
        ));
  }
}





