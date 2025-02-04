import 'package:firebase_getx/theme/color.dart';
import 'package:firebase_getx/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RewardController extends GetxController {
  var w = Get.width;
  var h = Get.height;

  late final DateTime now;
  late final String formattedDate;

  @override
  void onInit() {
    super.onInit();
    now = DateTime.now();
    formattedDate = DateFormat('dd/MM/yyyy').format(now); // จัดรูปแบบวันที่
  }

  Widget reward(String rank, String number) {
    return Container(
      width: w * 0.85,
      height: h * 0.06,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColor.greyTextfield),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: w * 0.05),
            child: Text(rank),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(right: w * 0.05),
            child: Text(number),
          )
        ],
      ),
    );
  }

  Widget gift(String image , String rank) {
    return Padding(
      padding: EdgeInsets.only(left: w * 0.07),
      child: Container(
        width: w * 0.85,
        height: h * 0.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(255, 225, 225, 225)),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: w * 0.05),
              child: Text(
                rank,
                style: AppFonts.fontpage.copyWith(fontSize: w * 0.035),
              ),
            ),
            Spacer(),
          
            Padding(
              padding: EdgeInsets.only(right: w * 0.05),
              child: Image.network(
                image,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
