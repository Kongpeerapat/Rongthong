import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_getx/theme/color.dart';
import 'package:firebase_getx/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  late final DateTime now;
  late final String formattedDate;
  var w = Get.width;
  var h = Get.height;
  final FirebaseFirestore firebase = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    now = DateTime.now();
    formattedDate = DateFormat('dd/MM/yyyy').format(now); // จัดรูปแบบวันที่
  }

  Widget container(Widget page, String image, String name) {
    return GestureDetector(
      onTap: () {
        Get.to(page);
      },
      child: Container(
        width: w * 0.33,
        height: h * 0.15,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColor.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(0.2), // เงาสีดำครึ่งหนึ่งของความทึบแสง
              blurRadius: 10, // ความนุ่มนวลของเงา
              spreadRadius: 2, // ขนาดที่เงาขยายตัว
              offset: const Offset(0, 4), // ตำแหน่งของเงา
            ),
          ],
        ),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.asset(
                  image,
                  width: w * 0.20,
                  fit: BoxFit.cover,
                ),
              ),
              Text(name, style: AppFonts.fonmanu.copyWith(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
