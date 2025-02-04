import 'package:firebase_getx/bottombar/bottombar.dart';
import 'package:firebase_getx/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Successbasket extends StatelessWidget {
  const Successbasket({super.key});

  @override
  Widget build(BuildContext context) {
    var w = Get.width;

    // ดึง selectedItems จาก Get.arguments
    // final selectedItems = Get.arguments?['selectedItems'] ?? [];

    Future.delayed(const Duration(seconds: 3), () {
      Get.to(
        BottomBar(),
        // arguments: {'selectedItems': selectedItems}, // ส่งข้อมูล
      );
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
