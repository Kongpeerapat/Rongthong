import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_getx/Widget/widgetall.dart';
import 'package:firebase_getx/theme/fonts.dart';
import 'package:firebase_getx/view/Status_carOrder/controller/statuscar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatuscarView extends GetView<StatuscarController> {
  const StatuscarView({super.key});

  @override
  Widget build(BuildContext context) {
    var w = Get.width;
    var h = Get.height;

    final StatuscarController controller = Get.put(StatuscarController());

    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Widgetall.bottomBack(),
              SizedBox(
                width: w * 0.2,
              ),
              Padding(
                padding: EdgeInsets.only(top: h * 0.075),
                child: Text(
                  "สถานะเรียกรถขน",
                  style: AppFonts.fontpage,
                ),
              )
            ],
          ),
          // ใช้ Expanded เพื่อให้ ListView สามารถขยายได้
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: controller.odercar1(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(child: Text('Error loading data'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("ยังไม่มีข้อมูลการเรียกรถ"));
                }

                var orderList = snapshot.data!.docs.map((doc) {
                  return doc.data() as Map<String, dynamic>;
                }).toList();

                return ListView.builder(
                  itemCount: orderList.length,
                  itemBuilder: (context, index) {
                    final order = orderList[index];

                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: w * 0.05),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 6,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("ชื่อ: ", style: AppFonts.fontpage),
                                  const Spacer(),
                                  Text(order["name"] ?? "ไม่ระบุ"),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text("เบอร์โทรศัพท์: ",
                                      style: AppFonts.fontpage),
                                  const Spacer(),
                                  Text(order["tel"] ?? "ไม่ระบุ"),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text("ประเภทรถ: ", style: AppFonts.fontpage),
                                  const Spacer(),
                                  Text(order["cartype"] ?? "ไม่ระบุ"),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text("ราคา: ", style: AppFonts.fontpage),
                                  const Spacer(),
                                  Text("${order["sumprice"] ?? 0} บาท"),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text("สถานะ: ", style: AppFonts.fontpage),
                                  const Spacer(),
                                  Text(
                                    order['status'] == false
                                        ? "ยังไม่ยืนยัน"
                                        : "ยืนยันแล้ว",
                                    style: TextStyle(
                                      color: order["status"] == false
                                          ? Colors.red
                                          : Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Divider(
                                  thickness: 1, color: Colors.grey.shade300),
                            ],
                          ),
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
  }
}
