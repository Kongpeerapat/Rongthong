import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_getx/Widget/widgetall.dart';
import 'package:firebase_getx/theme/color.dart';
import 'package:firebase_getx/theme/fonts.dart';
import 'package:firebase_getx/view/Address/controller/address_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAdresee extends GetView<AddressController> {
  const AddAdresee({super.key});

  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    var w = Get.width;

    // ตัวควบคุมฟอร์ม
    TextEditingController _nameController = TextEditingController();
    TextEditingController _telController = TextEditingController();
    TextEditingController _provinceController = TextEditingController();
    TextEditingController _districtController = TextEditingController();
    TextEditingController _villageController = TextEditingController();
    TextEditingController _houseNumberController = TextEditingController();
    TextEditingController _zipcodeController = TextEditingController();

    return GetBuilder<AddressController>(
      init: AddressController(),
      builder: (ctrl) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Widgetall.bottomBack(),
                    SizedBox(
                      width: w * 0.235,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: h * 0.075),
                      child: Text("เพิ่มที่อยู่", style: AppFonts.fontpage),
                    )
                  ],
                ),
                SizedBox(
                  height: h * 0.025,
                ),
                // ฟอร์มกรอกข้อมูลที่อยู่
                Widgetall.cotainerTextfield(
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: "ชื่อ",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: h * 0.01),
                Widgetall.cotainerTextfield(
                  child: TextField(
                    controller: _telController,
                    decoration: const InputDecoration(
                      hintText: "เบอร์โทรศัพท์",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: h * 0.01),
                Widgetall.cotainerTextfield(
                  child: TextField(
                    controller: _provinceController,
                    decoration: const InputDecoration(
                      hintText: "จังหวัด",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: h * 0.01),
                Widgetall.cotainerTextfield(
                  child: TextField(
                    controller: _districtController,
                    decoration: const InputDecoration(
                      hintText: "อำเภอ",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: h * 0.01),
                Widgetall.cotainerTextfield(
                  child: TextField(
                    controller: _villageController,
                    decoration: const InputDecoration(
                      hintText: "หมู่บ้าน",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: h * 0.01),
                Widgetall.cotainerTextfield(
                  child: TextField(
                    controller: _houseNumberController,
                    decoration: const InputDecoration(
                      hintText: "เลขที่บ้าน",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: h * 0.01),
                Widgetall.cotainerTextfield(
                  child: TextField(
                    controller: _zipcodeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "รหัสไปรษณีย์",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: w * 0.75,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: AppColor.yellow,
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      // ดึง userId จาก Firebase Authentication
                      String? userId = FirebaseAuth.instance.currentUser?.uid;

                      if (userId == null) {
                        Get.snackbar(
                            "ข้อผิดพลาด", "กรุณาเข้าสู่ระบบก่อนเพิ่มที่อยู่");
                        return;
                      }

                      // ตรวจสอบว่ากรอกข้อมูลครบทุกฟิลด์หรือไม่
                      if (_nameController.text.isEmpty ||
                          _telController.text.isEmpty ||
                          _provinceController.text.isEmpty ||
                          _districtController.text.isEmpty ||
                          _villageController.text.isEmpty ||
                          _houseNumberController.text.isEmpty ||
                          _zipcodeController.text.isEmpty) {
                        Get.snackbar("ข้อผิดพลาด", "กรุณากรอกข้อมูลให้ครบถ้วน");
                        return;
                      }

                      // เพิ่มข้อมูลที่อยู่พร้อม userId
                      ctrl.addAddress({
                        "userId":
                            userId, // ⭐️ เพิ่ม userId เข้าไปในข้อมูลที่อยู่
                        "name": _nameController.text,
                        "tel": _telController.text,
                        "province": _provinceController.text,
                        "district": _districtController.text,
                        "village": _villageController.text,
                        "house_number": _houseNumberController.text,
                        "zipcode": _zipcodeController.text,
                      });

                      // ล้างฟอร์มหลังจากเพิ่มที่อยู่
                      _nameController.clear();
                      _telController.clear();
                      _provinceController.clear();
                      _districtController.clear();
                      _villageController.clear();
                      _houseNumberController.clear();
                      _zipcodeController.clear();

                      // รีเฟรช UI
                      Get.back();
                      ctrl.update(); // อัปเดตค่าที่อยู่เพื่อให้ UI แสดงข้อมูลใหม่
                    },
                    child: Center(
                      child: Text(
                        "บันทึกที่อยู่",
                        style:
                            AppFonts.fontbotton.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
