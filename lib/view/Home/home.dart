import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_getx/theme/color.dart';
import 'package:firebase_getx/theme/fonts.dart';
import 'package:firebase_getx/view/Fertilizer/view/fertillizer_view.dart';
import 'package:firebase_getx/view/Home/home_controller.dart';
import 'package:firebase_getx/view/Reward/view/reward.dart';
import 'package:firebase_getx/roungtong/Sold_rice/view/view_soldrice.dart';
import 'package:firebase_getx/view/Tractor/view/tracktor_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Home extends GetView<HomeController> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var w = Get.width;
    var h = Get.height;

    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (crtl) {
          return Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: h * 0.099, left: w * 0.041),
                  child: Text(
                    "ราคาข้าววันนี้",
                    style: GoogleFonts.notoSerifThai(
                        fontSize: w * 0.07,
                        fontWeight: FontWeight.w900,
                        color: AppColor.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('pricesRice')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(
                              child: Text('ไม่มีข้อมูลราคาข้าว'));
                        }

                        // ดึงข้อมูลราคาข้าว
                        final ricePrices = snapshot.data!.docs;

                        return Row(
                          children: ricePrices.map((doc) {
                            final data = doc.data() as Map<String, dynamic>;
                            final riceType =
                                data['name'] ?? 'ไม่ระบุชนิดข้าว'; // ชนิดข้าว
                            final price =
                                data['price']?.toString() ?? '0.00'; // ราคาข้าว

                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Container(
                                width: Get.width * 0.8,
                                height: Get.height * 0.17,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppColor.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            riceType, // ชนิดข้าว
                                            style: GoogleFonts.notoSerifThai(
                                                fontSize: Get.width * 0.04,
                                                fontWeight: FontWeight.w900,
                                                color: AppColor.black),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: Get.width * 0.2),
                                          child: Text(
                                            DateFormat('dd/MM/yyyy').format(
                                                DateTime.now()), // วันที่
                                            style: GoogleFonts.notoSerifThai(
                                                fontSize: Get.width * 0.04,
                                                fontWeight: FontWeight.w900,
                                                color: AppColor.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Center(
                                      child: Text(
                                        price, // ราคา
                                        style: GoogleFonts.notoSerifThai(
                                          color: AppColor.black,
                                          fontSize: Get.width * 0.2,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 25), // เพิ่มระยะห่างด้านล่าง

                // ส่วน Row ที่นำออกจาก SingleChildScrollView
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: w * 0.11),
                        child: crtl.container(
                            const ViewSoldrice(), "images/a.png", "ขายข้าว"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: w * 0.11),
                        child: crtl.container(const FertillizerView(),
                            "images/fertilzer.png", "ปุ๋ย/พันธุ์ข้าว"),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: w * 0.11),
                        child: crtl.container(const Viewtraactor(),
                            "images/tracktor.png", "รถไถ"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: w * 0.11),
                        child: crtl.container(
                            const Reward(), "images/gift.png", "ผลรางวัล"),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: w * 0.11),
                  child: Container(
                    width: w * 0.78,
                    height: h * 0.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColor.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          "images/map.png",
                          width: w * 0.2,
                          fit: BoxFit.cover,
                        ),
                        Text(
                          "เส้นทางไปรวงทอง",
                          style: AppFonts.fonmanu.copyWith(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
