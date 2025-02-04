import 'package:firebase_getx/roungtong/home/controller.dart';
import 'package:firebase_getx/roungtong/status/status.dart';
import 'package:firebase_getx/theme/color.dart';
import 'package:firebase_getx/theme/fonts.dart';
import 'package:firebase_getx/roungtong/Sold_rice/view/view_soldrice.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class Home1 extends GetView<Homecontroller1> {
  const Home1({super.key});

  @override
  Widget build(BuildContext context) {
    var w = Get.width;
    var h = Get.height;

    return GetBuilder(
        init: Homecontroller1(),
        builder: (ctrl) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h * 0.075),
                  Text("ราคาข้าววันนี้", style: AppFonts.headder),
                  Obx(() {
                    if (ctrl.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (ctrl.ricePrices.isEmpty) {
                      return const Center(child: Text('ไม่มีข้อมูลราคาข้าว'));
                    }

                    return Column(
                      children: [
                        SizedBox(
                          height: h * 0.14, // กำหนดขนาดให้พอดีกับ container
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            controller:
                                ctrl.scrollController, // เชื่อมกับ controller
                            child: Row(
                              children: ctrl.ricePrices.map((data) {
                                final riceType =
                                    data['name'] ?? 'ไม่ระบุชนิดข้าว';
                                final price =
                                    data['price']?.toString() ?? '0.00';

                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Container(
                                    width: w * 0.8,
                                    height: h * 0.12,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Text(riceType,
                                                  style: AppFonts.midderd),
                                            ),
                                            const Spacer(),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: w * 0.04),
                                              child: Text(
                                                DateFormat('dd/MM/yyyy')
                                                    .format(DateTime.now()),
                                                style: AppFonts.midderd,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Center(
                                          child: Text("$price/กก.",
                                              style: AppFonts.big),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(height: h * 0.0025),
                        Obx(() => DotsIndicator(
                              dotsCount: controller.ricePrices.length,
                              position: controller.currentPage.value,
                              decorator: DotsDecorator(
                                activeColor: AppColor.yellowbottom,
                                size: const Size.square(9.0),
                                activeSize: const Size(18.0, 9.0),
                                activeShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            )),
                      ],
                    );
                  }),
                  Text(
                    "พอร์ตของฉัน",
                    style: AppFonts.headder,
                  ),
                  Container(
                    height: h * 0.17, // ✅ เพิ่มความสูงให้พอใส่ Pie Chart
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
                    child: Padding(
                      padding:
                          EdgeInsets.all(w * 0.04), // ✅ กำหนด padding ให้สมดุล
                      child: Row(
                        children: [
                          Expanded(
                            // ✅ Pie Chart ใช้พื้นที่ที่เหลือ
                            flex: 3,
                            child: PieChart(
                              PieChartData(
                                sections: [
                                  PieChartSectionData(
                                    value: 60,
                                    color: Colors.green,
                                    title: "รายรับ",
                                    radius: 50,
                                  ),
                                  PieChartSectionData(
                                    value: 40,
                                    color: Colors.red,
                                    title: "รายจ่าย",
                                    radius: 50,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(), // ✅ จัดให้ Pie Chart ชิดซ้าย
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    "รายรับ-รายจ่าย",
                                    style: AppFonts.midderd
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Text("รายรับ"),
                                    const Spacer(),
                                    ctrl.containerIncomeandexpenses(
                                      Colors.green.withOpacity(0.2),
                                      "62,000",
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: h * 0.002,
                                ),
                                Row(
                                  children: [
                                    const Text("รายจ่าย"),
                                    const Spacer(),
                                    ctrl.containerIncomeandexpenses(
                                      Colors.red.withOpacity(0.2),
                                      "2,000",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.015,
                  ),
                  Row(
                    children: [
                      ctrl.containerManu(
                          const ViewSoldrice(), "images/a.png", "ขายข้าว"),
                      const Spacer(),
                      GestureDetector(
                        onTap: () async {
                          String googleMapsUrl =
                              "https://maps.app.goo.gl/nPsMRBE8YQCaGFH89";
                          Uri url = Uri.parse(googleMapsUrl);

                          if (await canLaunchUrl(url)) {
                            await launchUrl(url,
                                mode: LaunchMode.externalApplication);
                          } else {
                            Get.snackbar(
                                "ข้อผิดพลาด", "ไม่สามารถเปิด Google Maps ได้");
                          }
                        },
                        child: Container(
                          width: w * 0.42,
                          height: h * 0.12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColor.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                    0.2), // เงาสีดำครึ่งหนึ่งของความทึบแสง
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
                                  "images/map.png",
                                  width: w * 0.15,
                                  fit: BoxFit.cover,
                                ),
                                Text("เส้นทางไปโรงสี",
                                    style: AppFonts.fonmanu
                                        .copyWith(fontSize: 16)),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: h * 0.015,
                  ),
                  Row(
                    children: [
                      Text(
                        "สถานะเรียกรถ",
                        style: AppFonts.headder,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Get.to(Status());
                        },
                        child: const Text(
                          "สถานะทั้งหมด",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange),
                        ),
                      )
                    ],
                  ),
                  Container(
                      height: h * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            spreadRadius: 0.2,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Obx(() {
                        // ตรวจสอบว่ามีข้อมูลใน carOrders หรือไม่
                        if (ctrl.carOrders.isEmpty) {
                          return Center(
                              child: Text(
                            "ยังไม่มีรายการจองรถ",
                            style: AppFonts.midderd,
                          )); // หรือข้อความอื่น ๆ
                        }

                        // ดึงข้อมูลการสั่งรถที่ต้องการ
                        var carOrder = ctrl
                            .carOrders.first; // หรือเลือกตาม index ที่ต้องการ

                        return Row(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: w * 0.025),
                              child: Text(
                                " รถสำหรับข้าว \n ${carOrder['cartype']}" ??
                                    "ยังไม่มีการเรียกรถ", // แสดง cartype
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: w * 0.025),
                              child: Text(
                                carOrder['status'] == 1
                                    ? "กำลังมาหาคุณ"
                                    : "ยังไม่มา", // แสดง status
                                style: AppFonts.headder.copyWith(
                                    color: carOrder['status'] == 1
                                        ? Colors.green
                                        : Colors.red),
                              ),
                            ),
                          ],
                        );
                      })),
                  SizedBox(
                    height: h * 0.015,
                  ),
                  Row(
                    children: [
                      Text(
                        "คะเเนนของคุณ",
                        style: AppFonts.headder,
                      ),
                      Text(" 620 ",
                          style:
                              AppFonts.headder.copyWith(color: Colors.orange)),
                      Text(
                        "คะเเนน",
                        style: AppFonts.headder,
                      ),
                      const Spacer(),
                      const Text(
                        "แลกรางวัล",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.orange),
                      ),
                    ],
                  ),
                  ctrl.reward("value",
                      "https://i.pinimg.com/originals/78/16/e1/7816e1930a35f03a2562859c9f0783d6.png")
                ],
              ),
            ),
          );
        });
  }
}
