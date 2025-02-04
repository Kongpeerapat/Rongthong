import 'package:firebase_getx/Widget/widgetall.dart';
import 'package:firebase_getx/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_getx/theme/color.dart';
import 'package:firebase_getx/view/History_orderbuy/controller/history_controller.dart';
import 'package:intl/intl.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    var w = Get.width;
    var h = Get.height;

    return GetBuilder(
        init: HistoryController(),
        builder: (ctrl) {
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
                Expanded(
                  child: Obx(() {
                    if (controller.history.isEmpty) {
                      return const Center(
                          child: Text("ไม่มีประวัติการสั่งซื้อ"));
                    }

                    return ListView.builder(
                      itemCount: controller.history.length,
                      itemBuilder: (context, index) {
                        final item = controller.history[index];
                        if (item.isEmpty) {
                          return const Center(
                            child: Text("ยังไม่มีสินค้าสั่งซื้อ"),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 15.0),
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              color: AppColor.white,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: w * 0.15,
                                      height: w * 0.15,
                                      decoration: BoxDecoration(
                                        color: AppColor.greyfont,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        Icons.shopping_cart_outlined,
                                        size: w * 0.1,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: w * 0.05),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "ชื่อสินค้า: ${item['productName']}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: AppColor.black,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            "จำนวน: ${item['quantity']}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: AppColor.black,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            "ราคา: ${item['total']} บาท",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: AppColor.black,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            "วันที่: ${DateFormat('dd/MM/yyyy hh:mm a').format(item['orderDate'].toDate())}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: AppColor.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    );
                  }),
                ),
              ],
            ),
          );
        });
  }
}
