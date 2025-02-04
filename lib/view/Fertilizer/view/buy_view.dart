import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_getx/theme/color.dart';
import 'package:firebase_getx/theme/fonts.dart';
import 'package:firebase_getx/view/Fertilizer/controller/fertillizer_controller.dart';
import 'package:firebase_getx/view/Fertilizer/view/Basket/view/successbasket.dart';
import 'package:firebase_getx/view/History_orderbuy/controller/history_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuyView extends GetView<FertillizerController> {
  const BuyView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HistoryController());
    var w = Get.width;
    var h = Get.height;

    return GetBuilder<FertillizerController>(
      init: FertillizerController(),
      builder: (ctrl) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(w * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: h * 0.075),
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                            ctrl.addresses.clear();
                          },
                          child: Container(
                            width: w * 0.096,
                            height: h * 0.044,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: AppColor.white,
                            ),
                            child: Center(
                              child: Image.asset(
                                "images/back.png",
                                width: w * 0.03,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: w * 0.25,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: h * 0.075),
                        child: Text(
                          "ซื้อสินค้า",
                          style: AppFonts.fontpage,
                        ),
                      )
                    ],
                  ),

                  // Section: ภาพสินค้า
                  FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection("Product")
                        .doc(ctrl.idproduct.value)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError ||
                          !snapshot.hasData ||
                          !snapshot.data!.exists) {
                        return const Center(child: Text('ไม่พบข้อมูลสินค้า'));
                      }

                      var productData =
                          snapshot.data!.data() as Map<String, dynamic>;
                      var productImages =
                          productData['images'] as List<dynamic>;

                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: SizedBox(
                            height: h * 0.25,
                            child: PageView.builder(
                              itemCount: productImages.length,
                              itemBuilder: (context, index) {
                                return Image.network(
                                  productImages[index],
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: h * 0.02),

                  // Section: รายละเอียดสินค้า
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => Text("สินค้า: ${ctrl.name.value}",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold))),
                          const SizedBox(height: 8),
                          Text(
                            "อาหารสำหรับปลานิลเล็ก เหมาะสำหรับปลานิลที่อายุไม่ถึง 8 สัปดาห์",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.02),

                  // Section: ที่อยู่จัดส่ง
                  Row(
                    children: [
                      const Text("ที่อยู่จัดส่ง",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          ctrl.bottomdialog();
                        },
                        child: const Text("เพิ่มที่อยู่",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Obx(() => ctrl.addresses.isEmpty
                      ? Container(
                          width: w * 0.9,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColor.greyTextfield,
                          ),
                          child: const Center(
                              child: Text("เพิ่มที่อยู่เพื่อจัดส่ง")),
                        )
                      : Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: ctrl.addresses.map((address) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("ชื่อผู้รับ: ${address['name']}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        "ที่อยู่: ${address['house_number']} ${address['village']}"),
                                    Text(
                                        "เขต: ${address['district']} จังหวัด: ${address['province']}"),
                                    Text("รหัสไปรษณีย์: ${address['zipcode']}"),
                                    Text("โทรศัพท์: ${address['tel']}"),
                                    const Divider(),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        )),
                  SizedBox(height: h * 0.02),

                  // Section: สรุปคำสั่งซื้อ
                  const Text("สรุปคำสั่งซื้อ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          summaryRow("จำนวน", "${ctrl.qulityconfirm}"),
                          summaryRow("ราคา", "${ctrl.price} บาท"),
                          summaryRow("ค่าจัดส่ง", "${ctrl.shipping} บาท"),
                          const Divider(),
                          summaryRow("รวม", "${ctrl.sum} บาท", isBold: true),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.04),

                  // ปุ่มยืนยัน
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.yellowbottom,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                      ),
                      onPressed: () {
                        ctrl.addressesAddtoProduct.value =
                            List<Map<String, dynamic>>.from(ctrl.addresses);
                        ctrl.orderProduct();
                        ctrl.history();
                        ctrl.addresses.clear();
                        Get.to(const Successbasket());
                      },
                      child:
                          Text("ยืนยันการสั่งซื้อ", style: AppFonts.fontbotton),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget summaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
