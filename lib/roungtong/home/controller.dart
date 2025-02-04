import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart'; // นำเข้า Firebase Firestore เพื่อดึงข้อมูล
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_getx/theme/color.dart';
import 'package:firebase_getx/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // นำเข้า GetX สำหรับจัดการ state
import 'package:flutter/widgets.dart'; // นำเข้า Widgets เพื่อใช้ ScrollController

class Homecontroller1 extends GetxController {
  var ricePrices = <Map<String, dynamic>>[]
      .obs; // เก็บข้อมูลราคาข้าวในรูปแบบ List ของ Map โดยใช้ .obs เพื่อให้ UI อัปเดตอัตโนมัติ
  RxList<Map<String, dynamic>> carOrders = <Map<String, dynamic>>[].obs;
  var w = Get.width;
  var h = Get.height;
  var isLoading = true
      .obs; // ใช้เก็บสถานะการโหลดข้อมูล (true = กำลังโหลด, false = โหลดเสร็จ)
  var currentPage = 0.0.obs; // เก็บตำแหน่งการเลื่อนของ ScrollView

  final ScrollController scrollController =
      ScrollController(); // ตัวควบคุม ScrollView เพื่อตรวจสอบตำแหน่งการเลื่อน

  @override
  void onInit() {
    // ฟังก์ชันนี้จะทำงานอัตโนมัติเมื่อ Controller ถูกสร้างขึ้น
    super.onInit(); // เรียกใช้งาน onInit() ของ GetxController
    fetchCarOrders();
    fetchRicePrices(); // เรียกใช้ฟังก์ชันโหลดข้อมูลราคาข้าวจาก Firestore
    scrollController.addListener(() {
      // เพิ่ม Listener เพื่อตรวจจับการเลื่อน ScrollView
      double page = scrollController.offset /
          Get.width; // คำนวณตำแหน่งของหน้า (Page) จากระยะที่เลื่อน
      currentPage.value =
          page; // อัปเดตค่าตำแหน่งให้ currentPage เพื่อใช้กับ dots_indicator
    });
  }

  void fetchRicePrices() {
    // ฟังก์ชันดึงข้อมูลราคาข้าวจาก Firestore
    FirebaseFirestore.instance.collection('pricesRice').snapshots().listen(
      // อ่านข้อมูลจากคอลเลกชัน 'pricesRice' แบบเรียลไทม์
      (snapshot) {
        // เมื่อ Firestore ส่งข้อมูลกลับมา
        ricePrices.value = snapshot.docs // ดึงเอกสารทั้งหมดจาก Firestore
            .map((doc) => doc.data() as Map<String,
                dynamic>) // แปลงแต่ละเอกสารเป็น Map<String, dynamic>
            .toList(); // แปลงเป็น List ของ Map แล้วกำหนดให้ ricePrices
        isLoading.value =
            false; // เปลี่ยนสถานะ isLoading เป็น false เพราะโหลดเสร็จแล้ว
      },
      onError: (error) {
        // หากเกิดข้อผิดพลาดในการดึงข้อมูล
        print(
            "Error fetching rice prices: $error"); // แสดงข้อความ error ใน console
        isLoading.value =
            false; // เปลี่ยนสถานะ isLoading เป็น false เพื่อหยุดแสดง Loading Indicator
      },
    );
  }

  void fetchCarOrders() {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      print("No user logged in");
      return;
    }

    FirebaseFirestore.instance.collection('carOder').snapshots().listen(
      (snapshot) {
        carOrders.value = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .where(
                (order) => order['userId'] == userId) // กรองเฉพาะของ userId นี้
            .toList();
      },
      onError: (error) {
        print("Error fetching car orders: $error");
      },
    );
  }

  Widget containerIncomeandexpenses(Color color, String value) {
    return Container(
      width: w * 0.3,
      height: h * 0.05,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(15), color: color),
      child: Center(child: Text(value, style: AppFonts.midderd)),
    );
  }

  Widget containerManu(Widget page, String image, String name) {
    return GestureDetector(
      onTap: () {
        Get.to(page);
      },
      child: Container(
        width: w * 0.42,
        height: h * 0.12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColor.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(0.2), // เงาสีดำครึ่งหนึ่งของความทึบแสง
              blurRadius: 10, // ความนุ่มนวลของเงา
              spreadRadius: 2, // ขนาดที่เงาขยายตัว
              offset: const Offset(0, 4), // ตำแหน่งของเงา
            ),
          ],
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: h * 0.0075,
              ),
              Image.asset(
                image,
                width: w * 0.15,
                fit: BoxFit.cover,
              ),
              Text(name, style: AppFonts.fonmanu.copyWith(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }

  Widget reward(String value, String image) {
    return SizedBox(
      height: h * 0.2, // ✅ กำหนดความสูงที่แน่นอน(
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // ให้เลื่อนแนวนอน
        itemCount: 10, // จำนวนรายการ (ปรับตามต้องการ)
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.02), // เว้นระยะห่าง
            child: Container(
              width: w * 0.4,
              height: h * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey[300],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: h * 0.005),
                    child: Container(
                      width: w * 0.35,
                      height: h * 0.15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      clipBehavior:
                          Clip.hardEdge, // บังคับให้ตัดขอบตาม BorderRadius
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.035),
                        child: Text(
                          value,
                          maxLines: 1, // ✅ กำหนดให้มีแค่ 1 บรรทัด
                          overflow:
                              TextOverflow.ellipsis, // ✅ แสดง ... ถ้ายาวเกิน
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
