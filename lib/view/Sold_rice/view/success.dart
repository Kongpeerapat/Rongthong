import 'package:firebase_getx/roungtong/home/home.dart';
import 'package:firebase_getx/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Success extends StatelessWidget {
  const Success({super.key});

  @override
  Widget build(BuildContext context) {
    var w = Get.width;

    Future.delayed(const Duration(seconds: 3), () {
      Get.to(const Home1()); // นำทางไปหน้า Home
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
            "ทำรายการสำเร็จ",
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
