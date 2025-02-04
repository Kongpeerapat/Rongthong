import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_getx/theme/color.dart';
import 'package:firebase_getx/theme/fonts.dart';
import 'package:firebase_getx/view/Fertilizer/controller/fertillizer_controller.dart';
import 'package:firebase_getx/view/Fertilizer/view/Basket/view/basket_view.dart';
import 'package:firebase_getx/view/Fertilizer/view/buy_view.dart';

class CheckouutView extends GetView<FertillizerController> {
  const CheckouutView({super.key});

  @override
  Widget build(BuildContext context) {
    var w = Get.width;
    var h = Get.height;

    return GetBuilder<FertillizerController>(
      init: FertillizerController(),
      builder: (ctrl) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Get.back(),
            ),
            title: const Text(
              "สินค้า",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.black),
                onPressed: () => Get.to(() => const BasketView()),
              ),
            ],
          ),
          body: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('Product')
                .doc(ctrl.idproduct.value)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || !snapshot.data!.exists) {
                return const Center(child: Text('ไม่พบข้อมูลสินค้า'));
              }

              var productData = snapshot.data!.data() as Map<String, dynamic>;
              var productImages = productData['images'] as List<dynamic>;
              var productQuantity = productData['quantity'];

              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: SizedBox(
                          height: h * 0.3,
                          child: PageView.builder(
                            itemCount: productImages.length,
                            itemBuilder: (context, index) {
                              return Image.network(
                                productImages[index],
                                fit: BoxFit.cover,
                                width: double.infinity,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Product Details
                    _buildDetailRow("ชื่อสินค้า", ctrl.name.value),
                    _buildDetailRow("ราคา", "${ctrl.price.value} บาท"),
                    _buildDetailRow("จำนวนสินค้าคงเหลือ", "$productQuantity"),
                    const SizedBox(height: 30),

                    // Quantity Selector
                    Center(
                      child:
                          _buildQuantitySelector(ctrl, productQuantity, w, h),
                    ),
                    const SizedBox(height: 20),

                    // Action Buttons
                    _buildActionButton(
                      label: "เพิ่มใส่ตระกร้า",
                      color: AppColor.yellowbottom,
                      onTap: () {
                        if (ctrl.qulity > productQuantity) {
                          _showErrorSnackbar();
                        } else {
                          ctrl.qulityconfirm.value = ctrl.qulity.value;
                          ctrl.nameconfirm.value = ctrl.name.value;
                          ctrl.productImages.value = productImages;
                          ctrl.confirmPrice();
                          ctrl.addcart();
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildActionButton(
                      label: "ซื้อตอนนี้",
                      color: AppColor.yellowbottom,
                      onTap: () {
                        if (ctrl.qulity.value <= productQuantity) {
                          ctrl.qulityconfirm.value = ctrl.qulity.value;
                          ctrl.nameconfirm.value = ctrl.name.value;
                          ctrl.confirmPrice();
                          Get.to(() => const BuyView());
                        } else {
                          _showErrorSnackbar();
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector(
      FertillizerController ctrl, int stock, double w, double h) {
    return Container(
      width: w * 0.5,
      height: h * 0.07,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: AppColor.greyTextfield,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildQuantityButton("-", () => ctrl.desclip(), w, h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Obx(() =>
                Text("${ctrl.qulity}", style: const TextStyle(fontSize: 18))),
          ),
          _buildQuantityButton("+", () => ctrl.add(), w, h),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(
      String text, VoidCallback onTap, double w, double h) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: w * 0.085,
        height: h * 0.04,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppColor.yellowbottom,
        ),
        child: Center(
          child: Text(text,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildActionButton(
      {required String label,
      required Color color,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(label, style: AppFonts.fontbotton),
        ),
      ),
    );
  }

  void _showErrorSnackbar() {
    Get.snackbar(
      "ข้อผิดพลาด",
      "จำนวนสินค้าที่เลือกเกินกว่าจำนวนสินค้าที่มีในสต็อก",
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}
