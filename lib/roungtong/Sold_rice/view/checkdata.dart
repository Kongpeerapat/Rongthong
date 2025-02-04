import 'package:firebase_getx/Widget/widgetall.dart';
import 'package:firebase_getx/theme/color.dart';
import 'package:firebase_getx/theme/fonts.dart';
import 'package:firebase_getx/roungtong/Sold_rice/view/success.dart';
import 'package:firebase_getx/view/Status_carOrder/controller/statuscar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../controller/controller_soldrice.dart';

class Checkdata extends GetView<ControllerSoldrice> {
  const Checkdata({super.key});

  @override
  Widget build(BuildContext context) {
    var w = Get.width;
    var h = Get.height;
    final statusCarController = Get.put(StatuscarController());
    return GetBuilder(
      init: ControllerSoldrice(),
      builder: (ctlr) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Widgetall.bottomBack(),
                  SizedBox(
                    width: w * 0.18,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: h * 0.075),
                    child: Text(
                      "ตรวจสอบข้อมูล",
                      style: AppFonts.fontpage,
                    ),
                  ),
                ],
              ),

              SizedBox(height: h * 0.05),
              // ข้อมูลทั้งหมดใน Card ขนาดที่กำหนด
              Container(
                height: h * 0.28, // กำหนดความสูงของ Card
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: ListView(
                      children: [
                        _buildInfoRow("ชื่อ :", ctlr.name.value),
                        SizedBox(height: h * 0.02),
                        _buildInfoRow("เบอร์โทรศัพท์ :", ctlr.tel.value),
                        SizedBox(height: h * 0.02),
                        _buildInfoRow("ที่อยู่ :", ctlr.address.value),
                        SizedBox(height: h * 0.02),
                        _buildCarInfoRow(ctlr),
                        SizedBox(height: h * 0.02),
                        _buildInfoRow("รวมค่ารถ :", "${ctlr.sumpey}"),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: h * 0.025,
              ),
              // ปุ่มยืนยันด้านล่าง
              GestureDetector(
                onTap: () {
                  ctlr.addcarOrder();
                  statusCarController.addOrder2({
                    'name': ctlr.name.value,
                    'tel': ctlr.tel.value,
                    'address': ctlr.address.value,
                    'cartype': ctlr.carwidth.value,
                    'sumprice': ctlr.sumpey.value,
                    'status': ctlr.status.value,
                  });
                  Get.to(const Success());
                },
                child: Container(
                  width: w * 0.9,
                  height: h * 0.05,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColor.yellowbottom,
                  ),
                  child: Center(
                      child: Text(
                    "ยืนยัน",
                    style: AppFonts.fontbotton,
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String data) {
    return Row(
      children: [
        Text(
          title,
          style: AppFonts.fonthinttext,
        ),
        const Spacer(),
        Text(
          data,
          style: AppFonts.dataTextfiled,
        ),
      ],
    );
  }

  Widget _buildCarInfoRow(ControllerSoldrice ctlr) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "รถสำหรับขนข้าว",
              style: AppFonts.fonthinttext,
            ),
            Text(
              ctlr.carwidth.value,
              style: AppFonts.fonthinttext,
            ),
          ],
        ),
        const Spacer(),
        Text(
          "${ctlr.pricecarwidth.value}",
          style: AppFonts.dataTextfiled,
        ),
      ],
    );
  }
}
