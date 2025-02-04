import 'package:firebase_getx/Widget/widgetall.dart';
import 'package:firebase_getx/theme/color.dart';
import 'package:firebase_getx/theme/fonts.dart';
import 'package:firebase_getx/view/Tractor/controller/tractor_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Viewtraactor extends GetView<ControllerTractor> {
  const Viewtraactor({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController tel = TextEditingController();
    TextEditingController qulity = TextEditingController();
    var w = Get.width;
    var h = Get.height;

    return GetBuilder(
      init: ControllerTractor(),
      builder: (crtl) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Widgetall.bottomBack(),
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.25, top: h * 0.085),
                      child: Text(
                        "บริการไถนา",
                        style: AppFonts.fontpage,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: w * 0.096, top: h * 0.02),
                  child: Text(
                    'โปรดกรอกข้อมูลและสถานที่ไถ',
                    style: AppFonts.nameTextfiled,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: w * 0.096),
                  child: Widgetall.cotainerTextfield(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: h * 0.002, horizontal: w * 0.05),
                      child: TextField(
                        controller: name,
                        decoration: InputDecoration(
                            hintText: "ชื่อเจ้าของที่",
                            hintStyle: AppFonts.fonthinttext,
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: h * 0.015,
                ),
                Padding(
                  padding: EdgeInsets.only(left: w * 0.096),
                  child: Widgetall.cotainerTextfield(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: h * 0.002, horizontal: w * 0.05),
                      child: TextField(
                        controller: tel,
                         keyboardType: TextInputType
                            .number, // ตั้งค่าคีย์บอร์ดให้เป็นตัวเลข
                        inputFormatters: [
                          FilteringTextInputFormatter
                              .digitsOnly, // อนุญาตเฉพาะตัวเลข
                        ],
                        decoration: InputDecoration(
                            hintText: "เบอร์โทรศัพท์",
                            hintStyle: AppFonts.fonthinttext,
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: h * 0.015,
                ),
                Padding(
                  padding: EdgeInsets.only(left: w * 0.096),
                  child: Widgetall.cotainerTextfield(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: h * 0.002, horizontal: w * 0.05),
                      child: TextField(
                        controller: qulity,
                        keyboardType: TextInputType
                            .number, // ตั้งค่าคีย์บอร์ดให้เป็นตัวเลข
                        inputFormatters: [
                          FilteringTextInputFormatter
                              .digitsOnly, // อนุญาตเฉพาะตัวเลข
                        ],
                        decoration: InputDecoration(
                          hintText: "จำนวนไร่",
                          hintStyle: AppFonts.fonthinttext,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: h * 0.055,
                ),
                Padding(
                  padding: EdgeInsets.only(left: w * 0.096),
                  child: Text(
                    "โปรดปักหมุด",
                    style: AppFonts.nameTextfiled,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: w * 0.096),
                  child: Widgetall.cotainerTextfield(
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: h * 0.002, horizontal: w * 0.05),
                        child: const Text("")),
                  ),
                ),
                SizedBox(
                  height: h * 0.025,
                ),
                Padding(
                  padding: EdgeInsets.only(left: w * 0.096),
                  child: Text(
                    "โปรดเลือกประเภทรถไถ",
                    style: AppFonts.headlinemanu,
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: w * 0.1,
                      ),
                      child: Obx(
                        () => GestureDetector(
                          onTap: () {
                            crtl.pricecartype.value = 800;
                            crtl.cartype("ไถพรวนดิน");
                            crtl.choose("car1");
                          },
                          child: Widgetall.containerManu(
                            // ignore: unrelated_type_equality_checks
                            color: crtl.choose == "car1"
                                ? AppColor.yellowbottom
                                : AppColor.white,
                            child: Column(
                              children: [
                                Image.asset(
                                  'images/tracktor1.png',
                                  width: w * 0.20,
                                  fit: BoxFit.cover,
                                ),
                                Text("ไถพรวนดิน",
                                    textAlign: TextAlign.center,
                                    style: AppFonts.fonmanu
                                        .copyWith(fontSize: 15)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.14),
                      child: Obx(
                        () => GestureDetector(
                          onTap: () {
                            crtl.pricecartype.value = 1000;
                            crtl.cartype("ไถปั่น");
                            crtl.choose("car2");
                          },
                          child: Widgetall.containerManu(
                            // ignore: unrelated_type_equality_checks
                            color: crtl.choose == "car2"
                                ? AppColor.yellowbottom
                                : AppColor.white,
                            child: Column(
                              children: [
                                Image.asset(
                                  'images/tracktor2.png',
                                  width: w * 0.20,
                                  fit: BoxFit.cover,
                                ),
                                Text("ไถปั่น",
                                    textAlign: TextAlign.center,
                                    style: AppFonts.fonmanu
                                        .copyWith(fontSize: 15)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: h * 0.05,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: w * 0.1,
                      ),
                      child: Obx(
                        () => GestureDetector(
                          onTap: () {
                            crtl.pricecartype.value = 1500;
                            crtl.cartype("ไถยกล่อง");
                            crtl.choose('car3');
                          },
                          child: Widgetall.containerManu(
                            // ignore: unrelated_type_equality_checks
                            color: crtl.choose == "car3"
                                ? AppColor.yellowbottom
                                : AppColor.white,
                            child: Column(
                              children: [
                                Image.asset(
                                  'images/tracktor3.png',
                                  width: w * 0.20,
                                  fit: BoxFit.cover,
                                ),
                                Text("ไถยกล่อง",
                                    textAlign: TextAlign.center,
                                    style: AppFonts.fonmanu
                                        .copyWith(fontSize: 15)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.14),
                      child: Obx(
                        () => GestureDetector(
                          onTap: () {
                            crtl.pricecartype.value = 8000;
                            crtl.cartype("ปรับพื้นดิน");
                            crtl.choose('car4');
                          },
                          child: Widgetall.containerManu(
                            // ignore: unrelated_type_equality_checks
                            color: crtl.choose == 'car4'
                                ? AppColor.yellowbottom
                                : AppColor.white,
                            child: Column(
                              children: [
                                Image.asset(
                                  'images/tracktor4.png',
                                  width: w * 0.20,
                                  fit: BoxFit.cover,
                                ),
                                Text("ปรับพื้นดิน",
                                    textAlign: TextAlign.center,
                                    style: AppFonts.fonmanu
                                        .copyWith(fontSize: 15)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: h * 0.02,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () =>
                        crtl.checkValue(qulity.text, name.text, tel.text),
                    child: Container(
                      width: w * 0.78,
                      height: h * 0.05,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: AppColor.yellowbottom,
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 1,
                                offset: Offset(0, -1),
                                color: AppColor.black)
                          ]),
                      child: Center(
                        child: Text(
                          "ยืนยัน",
                          style: AppFonts.fontbotton,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
