import 'package:first/features/cart/cart_screen.dart';
import 'package:first/features/home/home_screen.dart';
import 'package:first/features/profile/profile_screen.dart';
import 'package:first/features/search/search_screen.dart';
import 'package:first/core/widgets/app_bar_widget.dart';
import 'package:first/core/widgets/bottom_nav_bar_widget.dart';
import 'package:first/core/widgets/drawer_widget.dart';
import 'package:first/features/wishlist/wishlist_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  final int? selectedeIndex;
  const MainScreen({this.selectedeIndex, super.key});

  @override
  State<MainScreen> createState() => _MainScreenState( );
}

class _MainScreenState extends State<MainScreen> {
  final screenList = <Widget>[
    HomeScreen(),
    SearchScreen(),
    CartScreen(),
    WishlistScreen(),
    ProfileScreen(),
  ];

  final _titleList = <String>['', '', 'Order', 'Wishlist', 'My Profile'];
  int _selectedIndex =0;

  void _onNavTapped(int index) {
    setState(() => _selectedIndex = index);
  }
  
 @override
  void initState() {
     super.initState();
     if( widget.selectedeIndex!=null)   _selectedIndex = widget.selectedeIndex ?? 0;

  }
  @override
  Widget build(BuildContext context) {
   
    return SafeArea(
      child: Scaffold(
       // extendBody: true,
         appBar: AppBarWidget(title: _titleList[_selectedIndex], tag: 'main'),
        drawer: DrawerWidget(),
        bottomNavigationBar: BottomNavBarWidget(
          selectedIndex: _selectedIndex,
          onItemTapped: _onNavTapped,
        ),
        body: screenList[_selectedIndex],
      ),
    );
  }
}
