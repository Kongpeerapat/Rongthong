import 'package:firebase_getx/theme/color.dart';
import 'package:firebase_getx/view/register/regis_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends GetView<RegisController> {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return GetBuilder<RegisController>(
        init: RegisController(),
        builder: (controller) {
          return Scaffold(
            resizeToAvoidBottomInset: false, // ป้องกันจอเลื่อนเมื่อเปิดคีย์บอร์ด
            body: Stack(
              children: [
                // รูปภาพพื้นหลัง
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
                // Container สำหรับฟอร์มลงทะเบียน
                Positioned(
                  bottom: h * 0.05, // ระยะห่างจากขอบล่าง
                  left: w * 0.05, // ระยะห่างจากขอบซ้าย
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
                              "ลงทะเบียน",
                              style: GoogleFonts.notoSerifThai(
                                  fontSize: 48,
                                  fontWeight: FontWeight.w900,
                                  color: AppColor.yellow),
                            ),
                          ),
                          // Input ชื่อผู้ใช้
                          _buildInputField(
                              controller: controller.usernameController,
                              hintText: "ชื่อผู้ใช้",
                              width: w,
                              height: h),
                          const SizedBox(height: 20),
                          // Input อีเมล
                          _buildInputField(
                              controller: controller.emailController,
                              hintText: "อีเมล",
                              width: w,
                              height: h),
                          const SizedBox(height: 20),
                          // Input รหัสผ่าน
                          _buildInputField(
                              controller: controller.passwordController,
                              hintText: "รหัสผ่าน",
                              width: w,
                              height: h,
                              obscureText: true),
                          const SizedBox(height: 60),
                          // ปุ่มยืนยัน
                          GestureDetector(
                            onTap: controller.register, // ใช้ Logic จาก Controller
                            child: Container(
                              width: w * 0.75,
                              height: h * 0.05,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColor.yellowbottom),
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
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required double width,
    required double height,
    bool obscureText = false,
  }) {
    return Container(
      width: width * 0.75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColor.brow,
          width: height * 0.0015,
        ),
        color: AppColor.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: GoogleFonts.notoSerifThai(
                color: AppColor.brow,
                fontSize: 20,
                fontWeight: FontWeight.w300),
          ),
        ),
      ),
    );
  }
}
