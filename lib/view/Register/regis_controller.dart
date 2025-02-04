import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_getx/view/Login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> register() async {
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      Get.snackbar(
        "ข้อผิดพลาด",
        "กรุณากรอกข้อมูลให้ครบถ้วน",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      // ลงทะเบียน Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      String uid = userCredential.user!.uid;

      // บันทึกข้อมูลลง Firestore
      await FirebaseFirestore.instance.collection('Users').doc(uid).set({
        'username': usernameController.text.trim(),
        'email': emailController.text.trim(),
        'createdAt': Timestamp.now(),
      });

      Get.snackbar(
        "สำเร็จ",
        "ลงทะเบียนสำเร็จ",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // นำทางไปหน้า Login
      Get.offAll(const LoginView());
    } catch (e) {
      Get.snackbar(
        "ข้อผิดพลาด",
        "ไม่สามารถลงทะเบียนได้: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
