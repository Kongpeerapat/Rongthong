import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_getx/Widget/widgetall.dart';
import 'package:firebase_getx/roungtong/status/controller.dart';
import 'package:firebase_getx/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Status extends GetView<StatusController> {
  const Status({super.key});

  @override
  Widget build(BuildContext context) {
    var w = Get.width;
    var h = Get.height;

    return GetBuilder(
      init: StatusController(),
      builder: (ctrl) {
        return Scaffold(
          body: Column(
            children: [
              Row(
                children: [
                  Widgetall.bottomBack(),
                  SizedBox(width: w * 0.23),
                  Padding(
                    padding: EdgeInsets.only(top: h * 0.075),
                    child: Text(
                      "สถานะทั้งหมด",
                      style: AppFonts.fontpage,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: ctrl.getOrdersByUser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator()); // แสดงโหลด
                    }

                    if (snapshot.hasError) {
                      return Center(
                          child: Text("เกิดข้อผิดพลาดในการโหลดข้อมูล"));
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text("ไม่มีคำสั่งซื้อ"));
                    }

                    // แปลงข้อมูล Firestore เป็น List
                    var orders = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        var orderData =
                            orders[index].data() as Map<String, dynamic>;

                        return Card(
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(
                              horizontal: w * 0.05, vertical: h * 0.01),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: EdgeInsets.all(w * 0.05),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "ประเภทรถ: ${orderData['cartype'] ?? 'ไม่มีข้อมูล'}",
                                  style: AppFonts.midderd,
                                ),
                                Text(
                                  orderData['status'] == 1
                                      ? "กำลังมาหาคุณ"
                                      : "ยังไม่มา", // แสดง status
                                  style: AppFonts.headder.copyWith(
                                      color: orderData['status'] == 1
                                          ? Colors.green
                                          : Colors.red),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
