import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_getx/theme/color.dart';
import 'package:firebase_getx/theme/fonts.dart';
import 'package:firebase_getx/view/Fertilizer/controller/fertillizer_controller.dart';
import 'package:firebase_getx/view/Fertilizer/view/Basket/view/checkout_basket.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasketView extends GetView<FertillizerController> {
  const BasketView({super.key});

  @override
  Widget build(BuildContext context) {
    var w = Get.width;
    var h = Get.height;

    return GetBuilder(
        init: FertillizerController(),
        builder: (ctrl) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "ตะกร้าสินค้า",
                style: AppFonts.fontpage,
              ),
              backgroundColor: AppColor.yellowbottom,
              centerTitle: true,
            ),
            body: StreamBuilder<List<Map<String, dynamic>>>(
              stream: ctrl.getCartItems(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('ไม่มีสินค้าในตะกร้า'),
                  );
                }

                final cartItems = snapshot.data!;

                return ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];

                    // คำนวณค่าส่ง

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColor.greyTextfield,
                        ),
                        child: Row(
                          children: [
                            // แสดงรูปสินค้า
                            Container(
                              width: w * 0.2,
                              height: h * 0.1,
                              margin: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      item['imageproduct'][0]), // รูปสินค้า
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            // ข้อมูลสินค้า
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item["productname"],
                                    style: AppFonts.fontpage,
                                  ),
                                  StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('Product')
                                        .where('name',
                                            isEqualTo: item['productname'])
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Text("จำนวน: กำลังโหลด...");
                                      }

                                      if (!snapshot.hasData ||
                                          snapshot.data!.docs.isEmpty) {
                                        return Text("จำนวน: ไม่พบข้อมูล");
                                      }

                                      // ดึงค่าของ quantity
                                      var quantity =
                                          snapshot.data!.docs.first['quantity'];
                                      var priceProduct =
                                          snapshot.data!.docs.first['price'];
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("จำนวน: $quantity"),
                                          Text("ราคา: $priceProduct บาท"),
                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  ctrl.decreaseItemQuantity(
                                                      item['id'],
                                                      item['qulity']);
                                                },
                                                icon: const Icon(
                                                    Icons.remove_circle),
                                                color: AppColor.yellowbottom,
                                                iconSize: w * 0.07,
                                              ),
                                              Text("${item['qulity']}"),
                                              IconButton(
                                                onPressed: () {
                                                  if (item['qulity'] <
                                                      quantity) {
                                                    ctrl.increaseItemQuantity(
                                                        item['id'],
                                                        item['qulity']);
                                                  } else {
                                                    Get.snackbar(
                                                      "ข้อผิดพลาด",
                                                      "จำนวนสินค้าเกินจากที่มีในสต็อก",
                                                      snackPosition:
                                                          SnackPosition.BOTTOM,
                                                      backgroundColor:
                                                          Colors.red,
                                                      colorText: Colors.white,
                                                    );
                                                  }
                                                },
                                                icon: const Icon(
                                                    Icons.add_circle),
                                                color: AppColor.yellowbottom,
                                                iconSize: w * 0.07,
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            // ปุ่มลบสินค้า
                            Padding(
                              padding: EdgeInsets.only(bottom: h * 0.1),
                              child: IconButton(
                                onPressed: () {
                                  ctrl.removeItemFromCart(item['id']);
                                },
                                icon: const Icon(Icons.close_rounded),
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            bottomNavigationBar: StreamBuilder<double>(
              stream: ctrl.calculateTotalPrice(),
              builder: (context, snapshot) {
                final totalPrice = snapshot.data ?? 0.0;

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      final cartitems = await ctrl
                          .getCartItems()
                          .first; // ดึงข้อมูล cartitems
                      if (totalPrice == 0.0 || cartitems.isEmpty) {
                        Get.snackbar(
                          "ข้อผิดพลาด",
                          "ไม่มีสินค้าในตะกร้า",
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      } else {
                        int shippingCost = 0;
                        cartitems.forEach((item) {
                          // แปลง 'qulity' จาก String หรือ num เป็น int
                          int quantity = int.tryParse(
                                  item['qulity'].toString()) ??
                              0; // แปลงให้เป็น int ถ้าไม่ได้เป็น int หรือ String
                          shippingCost += quantity * 10; // คำนวณค่าส่ง
                        });

                        Get.to(CheckoutBasket(), arguments: {
                          'cartitems': cartitems, // ส่งรายการสินค้า
                          'totalPrice': totalPrice,
                          'shippingCost': shippingCost, // ส่งค่าส่ง
                          'productImages': ctrl.productImages,
                          'sumPrice': ctrl.sum.value,
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.yellowbottom,
                      padding: EdgeInsets.symmetric(vertical: h * 0.02),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Text(
                      "ยืนยันการสั่งซื้อ (รวม: ${totalPrice.toStringAsFixed(2)} บาท)",
                      style: AppFonts.fontpage.copyWith(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
