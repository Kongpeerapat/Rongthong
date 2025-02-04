import 'package:firebase_getx/Widget/widgetall.dart';
import 'package:firebase_getx/theme/fonts.dart';
import 'package:firebase_getx/view/Reward/controller/reward_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Reward extends GetView<RewardController> {
  const Reward({super.key});

  @override
  Widget build(BuildContext context) {
    var w = Get.width;
    var h = Get.height;
    return GetBuilder(
      init: RewardController(),
      builder: (ctrl) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Widgetall.bottomBack(),
                    SizedBox(
                      width: w * 0.25,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: h * 0.075),
                      child: Text(
                        "ผลรางวัล",
                        style: AppFonts.fontpage,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: w * 0.7),
                  child: Text(
                    ctrl.formattedDate,
                    style: TextStyle(fontSize: w * 0.04),
                  ),
                ),
                ctrl.reward("รางวัลที่ 1", "15151"),
                SizedBox(
                  height: h * 0.01,
                ),
                ctrl.reward("รางวัลที่ 2", "15151"),
                SizedBox(
                  height: h * 0.01,
                ),
                ctrl.reward("รางวัลที่ 3", "15151"),
                SizedBox(
                  height: h * 0.01,
                ),
                ctrl.reward("รางวัลที่ 4", "15151"),
                SizedBox(
                  height: h * 0.01,
                ),
                ctrl.reward("รางวัลที่ 5", "15151"),
                SizedBox(
                  height: h * 0.05,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "ของรางวัล",
                    style: AppFonts.fontpage,
                    textAlign: TextAlign.start,
                  ),
                ),
                Row(
                  children: [
                    ctrl.gift(
                        "https://down-th.img.susercontent.com/file/9d86dbbcc45206766780264ff6a4e2b2",
                        "รางวัลที่ 1")
                  ],
                ),
                SizedBox(
                  height: h * 0.02,
                ),
                Row(
                  children: [
                    ctrl.gift(
                        "https://down-th.img.susercontent.com/file/9d86dbbcc45206766780264ff6a4e2b2",
                        "รางวัลที่ 2")
                  ],
                ),
                SizedBox(
                  height: h * 0.02,
                ),
                Row(
                  children: [
                    ctrl.gift(
                        "https://down-th.img.susercontent.com/file/9d86dbbcc45206766780264ff6a4e2b2",
                        "รางวัลที่ 3")
                  ],
                ),
                SizedBox(
                  height: h * 0.02,
                ),
                Row(
                  children: [
                    ctrl.gift(
                        "https://down-th.img.susercontent.com/file/9d86dbbcc45206766780264ff6a4e2b2",
                        "รางวัลที่ 4")
                  ],
                ),
                SizedBox(
                  height: h * 0.02,
                ),
                Row(
                  children: [
                    ctrl.gift(
                        "https://down-th.img.susercontent.com/file/9d86dbbcc45206766780264ff6a4e2b2",
                        "รางวัลที่ 5")
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
