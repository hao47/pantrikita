import 'package:flutter/material.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/feature/home/presentation/pages/home_page.dart';
import 'package:pantrikita/feature/pantry/presentation/pages/pantry_page.dart';
import 'package:pantrikita/feature/profile/presentation/pages/profile_page.dart';
import 'package:pantrikita/feature/recipe/presentation/pages/recipe_page.dart';
import 'package:pantrikita/feature/scan/presentation/pages/scan_page.dart';

class BottomNavigation extends StatefulWidget {
  final int index;

  const BottomNavigation({super.key, this.index = 0});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late int _currentIndex;

  static final _pages = [
    HomePage(),
    PantryPage(),
    ScanPage(),
    RecipePage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index;
  }

  void _onItemTapped(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomAppBar(
        height: 85,
        color: ColorValue.whiteColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home_outlined, Icons.home, 'Home', 0),
            _buildNavItem(Icons.kitchen_outlined, Icons.kitchen, 'Pantry', 1),
            const SizedBox(width: 40),
            _buildNavItem(Icons.menu_book_outlined, Icons.menu_book, 'Recipes', 3),
            _buildNavItem(Icons.person_outline, Icons.person, 'Profile', 4),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onItemTapped(2),
        backgroundColor: ColorValue.primary,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: ColorValue.whiteColor, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildNavItem(IconData icon, IconData activeIcon, String label, int index) {
    final isActive = _currentIndex == index;
    return Expanded(
      child: GestureDetector(

        onTap: () => _onItemTapped(index),
        child: Container(
          height: 85,
          color: ColorValue.whiteColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isActive ? activeIcon : icon,
                size: 24,
                color: isActive ? ColorValue.primary : ColorValue.gray,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: isActive ? ColorValue.primary : ColorValue.gray,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}