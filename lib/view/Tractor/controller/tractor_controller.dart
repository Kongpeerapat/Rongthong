import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_getx/view/Tractor/view/checkdata_tracktor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControllerTractor extends GetxController {
  RxString choose = ''.obs;
  RxString cartype = ''.obs;
  RxString name = ''.obs;
  RxString tel = ''.obs;
  RxString address = ''.obs;
  RxInt pricecartype = 0.obs;
  RxInt distance = 0.obs;
  RxInt pricedistance = 0.obs;
  RxInt sumpey = 0.obs;
  RxBool status = false.obs;

  // ignore: non_constant_identifier_names
  void Choose(String cartype) {
    choose = cartype.obs;
    update();
  }

  void SumcarPrice() {
    try {
      // แปลง address.value จาก String เป็น int
      int addressInt = int.parse(address.value);
      // คำนวณและอัปเดตค่า sumpey
      sumpey.value = pricecartype.value * addressInt;
    } catch (e) {
      // จัดการข้อผิดพลาด หาก address.value ไม่ใช่ตัวเลข
      Get.dialog(
        AlertDialog(
          title: const Text(
            "ข้อผิดพลาด",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          content: const Text(
            "กรุณากรอกจำนวนไร่เป็นตัวเลข",
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text("ตกลง"),
            ),
          ],
        ),
      );
    }
  }

  void checkValue(String addressUser, String nameUser, String telUsre) {
    address.value = addressUser;
    name.value = nameUser;
    tel.value = telUsre;
    if (address.isEmpty || cartype.isEmpty || tel.isEmpty) {
      Get.dialog(
        AlertDialog(
          title: const Text(
            "กรุณากรอกข้อมูลให้ครบ",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            TextButton(onPressed: () => Get.back(), child: const Text("ตกลง"))
          ],
        ),
      );
    } else {
      Get.to(
          () => const CheckdataTractor()); // ตรวจสอบว่ามีโค้ดลักษณะนี้หรือไม่
    }
    SumcarPrice();
    update();
  }

  String? userId = FirebaseAuth.instance.currentUser?.uid;

  Future<void> tactorOder() async {
    if (userId == null) {
      Get.snackbar("ผิดพลาด", "ล็อกอินอีกครั้ง");
    }
    await FirebaseFirestore.instance.collection("tactorOder").add({
      'name': name.value,
      'tel': tel.value,
      'qulity': address.value,
      'cartype': cartype.value,
      'sumprice': sumpey.value,
      'status': status.value,
      'userId': userId
    });
  }

}
