import 'package:firebase_getx/Widget/widgetall.dart';
import 'package:firebase_getx/theme/color.dart';
import 'package:firebase_getx/theme/fonts.dart';
import 'package:firebase_getx/view/Address/controller/address_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class EditAdressView extends GetView<AddressController> {
  const EditAdressView({super.key});

  @override
  Widget build(BuildContext context) {
    var w = Get.width;
    var h = Get.height;

    // รับข้อมูลที่ส่งมาจากหน้า AddressView
    final Map<String, dynamic> address = Get.arguments ?? {};

    // ตัวควบคุมฟอร์ม
    TextEditingController _name = TextEditingController(text: address['name']);
    TextEditingController _tel = TextEditingController(text: address['tel']);
    TextEditingController _province = TextEditingController(text: address['province']);
    TextEditingController _district = TextEditingController(text: address['district']);
    TextEditingController _village = TextEditingController(text: address['village']);
    TextEditingController _house_number = TextEditingController(text: address['house_number']);
    TextEditingController _zipcode = TextEditingController(text: address['zipcode']);

    return GetBuilder(
      init: AddressController(),
      builder: (ctrl) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Widgetall.bottomBack(),
                    SizedBox(width: w * 0.25),
                    Padding(
                      padding: EdgeInsets.only(top: h * 0.075),
                      child: Text("แก้ไขที่อยู่", style: AppFonts.fontpage),
                    ),
                  ],
                ),
                SizedBox(height: h * 0.02),
                // ฟอร์มกรอกข้อมูลที่อยู่
                Widgetall.cotainerTextfield(
                  child: TextField(
                    controller: _name,
                    decoration: const InputDecoration(
                      hintText: "ชื่อ",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: h * 0.01),
                Widgetall.cotainerTextfield(
                  child: TextField(
                    controller: _tel,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "เบอร์โทรศัพท์",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: h * 0.01),
                Widgetall.cotainerTextfield(
                  child: TextField(
                    controller: _province,
                    decoration: const InputDecoration(
                      hintText: "จังหวัด",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: h * 0.01),
                Widgetall.cotainerTextfield(
                  child: TextField(
                    controller: _district,
                    decoration: const InputDecoration(
                      hintText: "อำเภอ",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: h * 0.01),
                Widgetall.cotainerTextfield(
                  child: TextField(
                    controller: _village,
                    decoration: const InputDecoration(
                      hintText: "หมู่บ้าน",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: h * 0.01),
                Widgetall.cotainerTextfield(
                  child: TextField(
                    controller: _house_number,
                    decoration: const InputDecoration(
                      hintText: "เลขที่บ้าน",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: h * 0.01),
                Widgetall.cotainerTextfield(
                  child: TextField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    controller: _zipcode,
                    decoration: const InputDecoration(
                      hintText: "รหัสไปรษณีย์",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: GestureDetector(
  onTap: () {
    if (_name.text.isEmpty ||
        _tel.text.isEmpty ||
        _province.text.isEmpty ||
        _district.text.isEmpty ||
        _village.text.isEmpty ||
        _house_number.text.isEmpty ||
        _zipcode.text.isEmpty) {
      // แสดงข้อความแจ้งเตือนหากมีฟิลด์ที่ว่าง
      Get.snackbar(
        "ข้อผิดพลาด",
        "กรุณากรอกข้อมูลให้ครบทุกช่อง",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      // อัปเดตข้อมูลใน Address List
      controller.updateAddress({
        "name": _name.text,
        "tel": _tel.text,
        "province": _province.text,
        "district": _district.text,
        "village": _village.text,
        "house_number": _house_number.text,
        "zipcode": _zipcode.text,
      });
      
      // รีเฟรช UI และกลับไปหน้าเดิม
      Get.back();
    }
  },
  child: Padding(
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    child: Container(
      width: w * 0.78,
      height: h * 0.05,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColor.yellowbottom,
      ),
      child: Center(
        child: Text("บันทึก", style: AppFonts.fontbotton),
      ),
    ),
  ),
),

        );
      },
    );
  }
}
