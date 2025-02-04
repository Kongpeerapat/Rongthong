import 'package:firebase_getx/theme/color.dart';
import 'package:firebase_getx/view/Login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: use_key_in_widget_constructors
class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var w = Get.width;
    var h = Get.height;

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const LoginView()), // หน้าหลักหรือหน้าต่อไป
      );
    });

    return Scaffold(
      body: Stack(
        children: [
          // รูปภาพพื้นหลัง
          Positioned.fill(
            bottom: h * 0.05,
            child: Image.asset(
              "images/logo.png",
            ),
          ),
          Positioned(
            top: h * 0.52,
            left: w * 0.25,
            right: 0,
            child: Text(
              "รวงทอง",
              style: GoogleFonts.notoSerifThai(
                  fontSize: 60,
                  color: AppColor.brow,
                  fontWeight: FontWeight.w900),
            ),
          ),
          Positioned(
            top: h * 0.59,
            left: 0,
            right: 0,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.01),
                  child: Container(
                    width: w * 0.3,
                    height: h * 0.003,
                    decoration: const BoxDecoration(
                      color: AppColor.brow, // ใช้สีจาก AppColor
                    ),
                  ),
                ),
                Text(
                  "ชื่นจันทร์",
                  style: GoogleFonts.notoSerifThai(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: AppColor.yellow),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.001),
                  child: Container(
                    width: w * 0.3,
                    height: h * 0.003,
                    decoration: const BoxDecoration(
                      color: AppColor.brow, // ใช้สีจาก AppColor
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
