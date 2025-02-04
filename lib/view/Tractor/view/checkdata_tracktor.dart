import 'package:firebase_getx/Widget/widgetall.dart';
import 'package:firebase_getx/theme/color.dart';
import 'package:firebase_getx/theme/fonts.dart';
import 'package:firebase_getx/view/Sold_rice/view/success.dart';
import 'package:firebase_getx/view/Status_carOrder/controller/statuscar_controller.dart';
import 'package:firebase_getx/view/Tractor/controller/tractor_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckdataTractor extends GetView<ControllerTractor> {
  const CheckdataTractor({super.key});

  @override
  Widget build(BuildContext context) {
    var w = Get.width;
    var h = Get.height;
    final statusCarController = Get.put(StatuscarController());
    return GetBuilder(
        init: ControllerTractor(),
        builder: (ctlr) {
          return Scaffold(
            body: Stack(
              children: [
                Column(
                  children: [
                    // Header
                    Row(
                      children: [
                        Widgetall.bottomBack(),
                        Padding(
                          padding:
                              EdgeInsets.only(left: w * 0.22, top: h * 0.085),
                          child: Text(
                            "ตรวจสอบข้อมูล",
                            style: AppFonts.fontpage,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h * 0.05),
                    // ข้อมูลต่างๆ
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        children: [
                          Widgetall.cotainerTextfield(
                            child: Row(
                              children: [
                                Text(
                                  "ชื่อ :",
                                  style: AppFonts.fonthinttext,
                                ),
                                const Spacer(),
                                Text(
                                  ctlr.name.value,
                                  style: AppFonts.dataTextfiled,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: h * 0.02),
                          Widgetall.cotainerTextfield(
                            child: Row(
                              children: [
                                Text(
                                  "เบอร์โทรศัพท์ :",
                                  style: AppFonts.fonthinttext,
                                ),
                                const Spacer(),
                                Obx(
                                  () => Text(
                                    controller.tel.value,
                                    style: AppFonts.dataTextfiled,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: h * 0.02),
                          Widgetall.cotainerTextfield(
                            child: Row(
                              children: [
                                Text(
                                  "จำนวนไร่",
                                  style: AppFonts.fonthinttext,
                                ),
                                const Spacer(),
                                Text(
                                  ctlr.address.value,
                                  style: AppFonts.dataTextfiled,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: h * 0.02),
                          Widgetall.cotainerTextfield(
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: h * 0.007),
                                      child: Text(
                                        "รถสำหรับ",
                                        style: AppFonts.fonthinttext,
                                      ),
                                    ),
                                    Text(
                                      ctlr.cartype.value,
                                      style: AppFonts.fonthinttext,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Text(
                                  "${ctlr.pricecartype.value}",
                                  style: AppFonts.dataTextfiled,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: h * 0.02),
                          Widgetall.cotainerTextfield(
                            child: Row(
                              children: [
                                Text(
                                  "รวมค่ารถ :",
                                  style: AppFonts.fonthinttext,
                                ),
                                const Spacer(),
                                Text(
                                  "${ctlr.sumpey}",
                                  style: AppFonts.dataTextfiled,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // ปุ่มยืนยันด้านล่าง
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: GestureDetector(
                    onTap: () {
                      ctlr.tactorOder();
                      // เพิ่มข้อมูลใน StatuscarController
                      statusCarController.addOrder({
                        'name': ctlr.name.value,
                        'tel': ctlr.tel.value,
                        'qulity': ctlr.address.value,
                        'cartype': ctlr.cartype.value,
                        'sumprice': ctlr.sumpey.value,
                        'status': ctlr.status.value,
                      });

                      // เพิ่มข้อมูลใน ControllerTractor ด้วย (ถ้าจำเป็น)

                      // นำทางไปยังหน้าสำเร็จ
                      Get.to(const Success());
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
                            color: AppColor.black,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "ยืนยัน",
                          style: AppFonts.fontbotton,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
