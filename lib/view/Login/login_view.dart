import 'package:firebase_getx/theme/color.dart';
import 'package:firebase_getx/theme/fonts.dart';
import 'package:firebase_getx/view/Login/login_controller.dart';
import 'package:firebase_getx/view/Register/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    var w = Get.width;
    var h = Get.height;

    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (ctrl) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            // พื้นหลัง
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                width: w * 0.5,
                height: h * 0.3,
                child: Image.asset(
                  "images/rich.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: h * 0.05,
              left: w * 0.05,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  width: w * 0.85,
                  height: h * 0.85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColor.lightyellow,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Text(
                          "เข้าสู่ระบบ",
                          style: GoogleFonts.notoSerifThai(
                              fontSize: 48,
                              fontWeight: FontWeight.w900,
                              color: AppColor.yellow),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // ช่องกรอกเบอร์โทรศัพท์
                      Container(
                        width: w * 0.75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: AppColor.brow, width: h * 0.0015),
                          color: AppColor.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            controller: ctrl.emailController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "อีเมล",
                              hintStyle: GoogleFonts.notoSerifThai(
                                  color: AppColor.brow,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // ช่องกรอกรหัสผ่าน
                      Container(
                        width: w * 0.75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: AppColor.brow, width: h * 0.0015),
                          color: AppColor.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            controller: ctrl.passwordController,
                            obscureText: true, // ซ่อนรหัสผ่าน
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "รหัสผ่าน",
                              hintStyle: GoogleFonts.notoSerifThai(
                                  color: AppColor.brow,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: h * 0.01,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: w * 0.55),
                        child: GestureDetector(
                          onTap: () {},
                          child: Text("ลืมรหัสผ่าน",
                              style: AppFonts.fontpage
                                  .copyWith(color: AppColor.yellowbottom)),
                        ),
                      ),
                      const SizedBox(height: 40),
                      // ปุ่มยืนยัน
                      GestureDetector(
                        onTap: () async {
                          

                          ctrl.login(); // เรียกใช้งาน login ต่อไป
                        },
                        child: Container(
                          width: w * 0.75,
                          height: h * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColor.yellowbottom,
                          ),
                          child: Center(
                            child: Text(
                              "ยืนยัน",
                              style: GoogleFonts.notoSerifThai(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: AppColor.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // ลิงก์ไปหน้า Register
                      GestureDetector(
                        onTap: () {
                          Get.to(const Register());
                        },
                        child: Text(
                          "ลงทะเบียน",
                          style: GoogleFonts.notoSerifThai(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: AppColor.yellow),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // แสดงชื่อผู้ใช้
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
