import 'package:firebase_getx/theme/color.dart';
import 'package:firebase_getx/view/Home/home.dart';
import 'package:firebase_getx/view/Income_Expenses/view/income_view.dart';
import 'package:firebase_getx/view/Profile/profile.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 1; // ตั้งค่าให้ Home เป็นหน้าแรก

  final List<Widget> _pages = [
    PieChartView(),
    const Home(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColor.white,
        elevation: 2,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image(
              image: _currentIndex == 0
                  ? const AssetImage("images/Vector (3).png")
                  : const AssetImage("images/Group.png"),
              width: 25,
              height: 25,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: _currentIndex == 1
                  ? const AssetImage("images/Vector.png")
                  : const AssetImage("images/Vector (1).png"),
              width: 25,
              height: 25,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: _currentIndex == 2
                  ? const AssetImage("images/Vector (2).png")
                  : const AssetImage("images/Vector (4).png"),
              width: 25,
              height: 25,
            ),
            label: "",
          ),
        ],
      ),
    );
  }
}
