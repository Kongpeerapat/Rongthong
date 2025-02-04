import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_getx/theme/color.dart';
import 'package:firebase_getx/theme/fonts.dart';
import 'package:firebase_getx/view/Fertilizer/view/Basket/view/basket_view.dart';
import 'package:firebase_getx/view/Fertilizer/controller/fertillizer_controller.dart';
import 'package:firebase_getx/view/Fertilizer/view/checkouut_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FertillizerView extends GetView<FertillizerController> {
  const FertillizerView({super.key});

  @override
  Widget build(BuildContext context) {
    var w = Get.width;
    var h = Get.height;

    return GetBuilder(
      init: FertillizerController(),
      builder: (ctrl) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: h * 0.028),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
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
                        const Spacer(),
                        Text(
                          "สินค้า",
                          style: AppFonts.fontpage,
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.to(const BasketView());
                          },
                          child: Image.asset(
                            "images/basket.png",
                            width: w * 0.07,
                            fit: BoxFit.cover,
                            color: AppColor.brow,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: h * 0.02),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Product')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text('ไม่มีข้อมูล'));
                      }

                      final fertilizers = snapshot.data!.docs;

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: fertilizers.length,
                        itemBuilder: (context, index) {
                          final fertilizerData =
                              fertilizers[index].data() as Map<String, dynamic>;
                          final productName =
                              fertilizerData['name'] ?? 'ไม่มีชื่อสินค้า';
                          final productPrice = fertilizerData['price'] ?? 0;
                          final productImages =
                              fertilizerData['images'] as List<dynamic>;
                          final productImage = productImages.isNotEmpty
                              ? productImages[0] as String
                              : "images/fertilzer.png";

                          return GestureDetector(
                            onTap: () {
                              Get.to(const CheckouutView());
                              ctrl.idproduct.value = fertilizers[index].id;
                              ctrl.name.value = productName;
                              ctrl.price.value = productPrice;
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(15)),
                                    child: Image.network(
                                      productImage,
                                      height: 150,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          productName,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Text(
                                              "ราคา",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[700]),
                                            ),
                                            const Spacer(),
                                            Text(
                                              "$productPrice บาท",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ],
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
