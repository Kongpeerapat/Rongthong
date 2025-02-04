import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_getx/roungtong/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // Controllers สำหรับ TextFormField
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // ตัวแปรเก็บชื่อผู้ใช้แบบ Observable
  RxString username = ''.obs;

  // ฟังก์ชันเข้าสู่ระบบ
  Future<void> login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        "ข้อผิดพลาด",
        "กรุณากรอกข้อมูลให้ครบ",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      // เข้าสู่ระบบผ่าน Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // ดึง UID ของผู้ใช้ที่ล็อกอิน
      String userId = userCredential.user!.uid;

      // ดึงข้อมูลผู้ใช้จาก Firestore
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(userId)
              .get();

      if (userSnapshot.exists) {
        // อัปเดต username จาก Firestore
        username.value = userSnapshot.data()?['username'] ?? 'ไม่มีชื่อผู้ใช้';

        // แสดงข้อความแจ้งเตือนพร้อมชื่อผู้ใช้
        Get.snackbar(
          "สำเร็จ",
          "ยินดีต้อนรับ, ${username.value}!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // นำผู้ใช้ไปยังหน้าหลัก
        Get.offAll(() => Home1()); // ใช้ Get.offAll เพื่อเคลียร์ Stack
      } else {
        Get.snackbar(
          "ข้อผิดพลาด",
          "ไม่พบข้อมูลผู้ใช้",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "ข้อผิดพลาด",
        e.message ?? "เกิดข้อผิดพลาด",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print("FirebaseAuthException: ${e.message}");
    } catch (e) {
      Get.snackbar(
        "ข้อผิดพลาด",
        "เกิดข้อผิดพลาดในการดึงข้อมูล",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print("Exception: $e");
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
