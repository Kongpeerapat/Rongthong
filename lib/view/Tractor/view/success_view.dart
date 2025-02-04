import 'package:firebase_getx/bottombar/bottombar.dart';
import 'package:firebase_getx/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessTractor extends StatelessWidget {
  const SuccessTractor({super.key});

  @override
  Widget build(BuildContext context) {
    var w = Get.width;

    Future.delayed(const Duration(seconds: 3), () {
      Get.to(const BottomBar()); // นำทางไปหน้า Home
    });

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "images/success.png",
              width: w * 0.22,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            "เรียกรถสำเร็จ",
            style: AppFonts.succes,
          ),
          Text(
            "โปรดรอการยืนยัน",
            style: AppFonts.succes,
          ),
        ],
      ),
    );
  }
}
