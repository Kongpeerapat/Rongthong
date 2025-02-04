import 'package:firebase_getx/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Widgetall {
  static double w = Get.width;
  static double h = Get.height;

  static Widget bottomBack() {
    return Padding(
      padding: EdgeInsets.only(left: w * 0.062, top: h * 0.08),
      child: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          width: w * 0.096,
          height: h * 0.044,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: AppColor.white,
          ),
          child: Center(
            child: Image.asset(
              "images/back.png",
              width: w * 0.03,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  static Widget cotainerTextfield({required Widget child}) {
    return Container(
      width: w * 0.80,
      height: h * 0.057,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.greyTextfield,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: child,
      ),
    );
  }

  static Widget containerManu({required Widget child, Color? color}) {
    return Container(
        width: w * 0.33,
        height: h * 0.15,
        decoration: BoxDecoration(
          color: color, // ใช้สีจากพารามิเตอร์หรือสีเริ่มต้น
          borderRadius: BorderRadius.circular(30),
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
        child: child);
  }

  static Widget containerprofile({required Widget child}) {
    return Container(
      width: w * 0.85,
      height: h * 0.06,
      decoration: BoxDecoration(
        color: AppColor.white, // ใช้สีจากพารามิเตอร์หรือสีเริ่มต้น
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(0.2), // เงาสีดำครึ่งหนึ่งของความทึบแสง
            blurRadius: 10, // ความนุ่มนวลของเงา
            spreadRadius: 2, // ขนาดที่เงาขยายตัว
            offset: const Offset(0, 4), // ตำแหน่งของเงา
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: w * 0.025),
            child: child,
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(right: w * 0.025),
            child: Image.asset(
              "images/next.png",
              width: w * 0.025,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
