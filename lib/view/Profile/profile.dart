import 'package:firebase_getx/Widget/widgetall.dart';
import 'package:firebase_getx/theme/fonts.dart';
import 'package:firebase_getx/view/Address/view/address_view.dart';
import 'package:firebase_getx/view/History_orderbuy/view/history_view.dart';
import 'package:firebase_getx/view/Login/login_view.dart';
import 'package:firebase_getx/view/Profile/profile_controller.dart';
import 'package:firebase_getx/view/Reward/view/reward.dart';
import 'package:firebase_getx/view/Status_carOrder/view/statuscar2_view.dart';
import 'package:firebase_getx/view/Status_carOrder/view/statuscar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends GetView<ProfileController> {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    var w = Get.width;
    var h = Get.height;
    return GetBuilder(
      init: ProfileController(),
      builder: (ctrl) {
        return Scaffold(
          body: Column(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: w * 0.15),
                  child: Text(
                    "โปรไฟล์ของฉัน",
                    style: AppFonts.fontpage,
                  ),
                ),
              ),
              SizedBox(
                height: h * 0.05,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(StatuscarView());
                },
                child: Widgetall.containerprofile(
                  child: Text(
                    "สถานะเรียกรถขน",
                    style: AppFonts.dataTextfiled,
                  ),
                ),
              ),
              SizedBox(
                height: h * 0.015,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(StatuscarView2());
                },
                child: Widgetall.containerprofile(
                  child: Text(
                    "สถานะเรียกรถไถ",
                    style: AppFonts.dataTextfiled,
                  ),
                ),
              ),
              SizedBox(
                height: h * 0.015,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(HistoryView());
                },
                child: Widgetall.containerprofile(
                  child: Text(
                    "สินค้าที่สั่งซื้อ",
                    style: AppFonts.dataTextfiled,
                  ),
                ),
              ),
              SizedBox(
                height: h * 0.015,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(AddressView());
                },
                child: Widgetall.containerprofile(
                  child: Text(
                    "ที่อยู่สำหรับจัดส่ง",
                    style: AppFonts.dataTextfiled,
                  ),
                ),
              ),
              SizedBox(
                height: h * 0.015,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(Reward());
                },
                child: Widgetall.containerprofile(
                  child: Text(
                    "ผลรางวัล",
                    style: AppFonts.dataTextfiled,
                  ),
                ),
              ),
              SizedBox(height: h * 0.09),
              TextButton(
                onPressed: () {
                  Get.to(const LoginView());
                },
                child: const Text(
                  "ออกจากระบบ",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
