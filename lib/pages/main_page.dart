import 'package:e_commerce/components/thatbottombar/that_bottom_bar.dart';
import 'package:e_commerce/components/thatbottombar/that_bottom_bar_item.dart';
import 'package:e_commerce/pages/cart_page.dart';
import 'package:e_commerce/pages/home_page.dart';
import 'package:e_commerce/pages/notifications_page.dart';
import 'package:e_commerce/pages/profile_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final pageViewController = PageController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ThatBottomBar(
        selectedIndex: selectedIndex,
        onChange: (int index) => pageViewController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        ),
        items: [
          ThatBottomBarItem(
            name: 'page.main.bottom_bar.home'.tr(),
            icon: Icons.home,
          ),
          ThatBottomBarItem(
            name: 'page.main.bottom_bar.cart'.tr(),
            icon: Icons.shopping_cart,
          ),
          ThatBottomBarItem(
            name: 'page.main.bottom_bar.notifications'.tr(),
            icon: Icons.notifications,
          ),
          ThatBottomBarItem(
            name: 'page.main.bottom_bar.profile'.tr(),
            icon: Icons.account_circle_rounded,
          )
        ],
      ),
      body: PageView(
        controller: pageViewController,
        onPageChanged: (value) => setState(() => selectedIndex = value),
        children: [
          const HomePage(),
          const CartPage(),
          const NotificationsPage(),
          ProfilePage(),
        ],
      ),
    );
  }
}
