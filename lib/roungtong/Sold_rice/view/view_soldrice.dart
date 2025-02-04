import 'package:firebase_getx/Widget/widgetall.dart';
import 'package:firebase_getx/theme/color.dart';
import 'package:firebase_getx/theme/fonts.dart';
import 'package:firebase_getx/roungtong/Sold_rice/controller/controller_soldrice.dart';
import 'package:firebase_getx/roungtong/Sold_rice/view/checkdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ViewSoldrice extends GetView<ControllerSoldrice> {
  const ViewSoldrice({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController tel = TextEditingController();
    TextEditingController address = TextEditingController();
    var w = Get.width;
    var h = Get.height;

    return GetBuilder(
      init: ControllerSoldrice(),
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
                      padding: EdgeInsets.only(left: w * 0.19, top: h * 0.085),
                      child: Text(
                        "บริการซื้อข้าวถึงที่",
                        style: AppFonts.fontpage,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: w * 0.096, top: h * 0.02),
                  child: Text(
                    'โปรดกรอกข้อมูลและสถานที่รับข้าว',
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
                            hintText: "ชื่อเจ้าของข้าว",
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
                            .number, // ✅ กำหนดให้เป็นคีย์บอร์ดตัวเลข
                        inputFormatters: [
                          FilteringTextInputFormatter
                              .digitsOnly, // ✅ อนุญาตเฉพาะตัวเลข 0-9
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
                        controller: address,
                        decoration: InputDecoration(
                            hintText:
                                "ที่อยู่ข้าว เช่น ม.5,ต.เจ็ด อ.พุทไธสง จ.บุรีรัมย์",
                            hintStyle: AppFonts.fonthinttext,
                            border: InputBorder.none),
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
                    "โปรดปักหมุดจุดที่ให้ไปรับข้าว",
                    style: AppFonts.nameTextfiled,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: w * 0.096),
                  child: GestureDetector(
                    onTap: () async {
                      await Get.dialog(crtl.dialog());
                    },
                    child: Widgetall.cotainerTextfield(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: h * 0.002, horizontal: w * 0.05),
                        child: Obx(() => Center(
                            child: Text(
                                crtl.currentLocation.value))), // ✅ แสดงค่าพิกัด
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: h * 0.025,
                ),
                Padding(
                  padding: EdgeInsets.only(left: w * 0.096),
                  child: Text(
                    "โปรดเลือกรถที่จะให้ไปรับข้าว",
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
                            crtl.point.value = 10;
                            crtl.pricecarwidth.value = 800;
                            crtl.carwidth("1000-3000 กิโลกรัม");
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
                                  'images/car1.png',
                                  width: w * 0.20,
                                  fit: BoxFit.cover,
                                ),
                                Text("รถสำหรับข้าว 1000-1500 กก.",
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
                            crtl.point.value = 30;
                            crtl.pricecarwidth.value = 1000;
                            crtl.carwidth("1500-3000 กิโลกรัม");
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
                                  'images/car2.png',
                                  width: w * 0.20,
                                  fit: BoxFit.cover,
                                ),
                                Text("รถสำหรับข้าว 1500-3000 กก.",
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
                            crtl.point.value = 50;
                            crtl.pricecarwidth.value = 1500;
                            crtl.carwidth("6000-10000 กิโลกรัม");
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
                                  'images/car3.png',
                                  width: w * 0.20,
                                  fit: BoxFit.cover,
                                ),
                                Text("รถสำหรับข้าว 6000-10000 กก.",
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
                            crtl.point.value = 120;
                            crtl.pricecarwidth.value = 8000;
                            crtl.carwidth("20000-30000 กิโลกรัม");
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
                                  'images/car4.png',
                                  width: w * 0.20,
                                  fit: BoxFit.cover,
                                ),
                                Text("รถสำหรับข้าว 20000-30000 กก.",
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
                    onTap: () {
                      crtl.SumcarPrice();
                      crtl.address.value = address.text;
                      crtl.name.value = name.text;
                      crtl.tel.value = tel.text;
                      if (crtl.address.isEmpty ||
                          crtl.carwidth.isEmpty ||
                          crtl.tel.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text(
                              "กรุณากรอกข้อมูลให้ครบ",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("ตกลง"))
                            ],
                          ),
                        );
                      } else {
                        Get.to(
                            const Checkdata()); // ตรวจสอบว่ามีโค้ดลักษณะนี้หรือไม่
                      }
                    },
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
