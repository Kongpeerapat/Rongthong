import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_getx/view/Fertilizer/controller/fertillizer_controller.dart';
import 'package:firebase_getx/view/Fertilizer/view/Basket/view/successbasket.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_getx/theme/color.dart';
import 'package:firebase_getx/theme/fonts.dart';

class CheckoutBasket extends GetView<FertillizerController> {
  const CheckoutBasket({super.key});

  @override
  Widget build(BuildContext context) {
    var w = Get.width;
    var h = Get.height;

    // รับค่าจาก arguments ที่ส่งมา

    final cartitems = Get.arguments['cartitems'] ?? [];
    final totalPrice = Get.arguments['totalPrice'] ?? 0;
    final shippingCost = Get.arguments['shippingCost'] ?? 0;

    return GetBuilder<FertillizerController>(
      init: FertillizerController(),
      builder: (ctrl) {
        double totalWithShipping = totalPrice + shippingCost;

        return Scaffold(
          appBar: AppBar(
            title: const Text("ยืนยันการสั่งซื้อ"),
          ),
          body: Column(
            children: [
              // รายการสินค้า
              Expanded(
                child: ListView.builder(
                  itemCount: cartitems.length,
                  itemBuilder: (context, index) {
                    final item = cartitems[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Container(
                        width: w * 0.8,
                        height: h * 0.12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColor.greyTextfield,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: w * 0.15,
                              height: h * 0.10,
                              margin: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    (item['imageproduct'] is List &&
                                            item['imageproduct'].isNotEmpty)
                                        ? item['imageproduct'][0]
                                        : 'https://variety.com/wp-content/uploads/2024/02/Lalisa-Manobal-headshot-credit-Vivi-Suthathip-Saepung-e1707758978642.jpg', // URL สำรองในกรณีที่ไม่มีรูป
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${item['productname']}",
                                      style: AppFonts.fontpage),
                                  Text("จำนวน: ${item['qulity']}"),
                                ],
                              ),
                            ),
                            Text("${item['price']} บาท"),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: w * 0.1),
                    child: InkWell(
                      onTap: () {
                        ctrl.bottomdialog();
                      },
                      child: const Text(
                        'เพิ่ม',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              Obx(
                () => ctrl.addresses.isEmpty
                    ? Container(
                        width: w * 0.8,
                        height: h * 0.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColor.greyTextfield,
                        ),
                        child: const Center(
                          child: Text("เพิ่มที่อยู่เพื่อจัดส่ง"),
                        ),
                      )
                    : Container(
                        width: w * 0.8, // กำหนดขนาดให้แน่นอน
                        height: h * 0.2, // ปรับความสูงตามต้องการ
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColor.greyTextfield,
                        ),
                        child: ListView.builder(
                          shrinkWrap: true, // ป้องกันการขยายเกินขนาด
                          physics:
                              const NeverScrollableScrollPhysics(), // ปิดการ scroll ถ้าอยู่ใน Column
                          itemCount: ctrl.addresses.length,
                          itemBuilder: (context, index) {
                            var address = ctrl.addresses[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("ชื่อผู้รับ: ${address['name']}"),
                                  Row(children: [
                                    Text(
                                        "บ้านเลขที่: ${address['house_number']}"),
                                    SizedBox(width: w * 0.025),
                                    Text("หมู่บ้าน: ${address['village']}"),
                                    SizedBox(width: w * 0.025),
                                    Text("เขต: ${address['district']}"),
                                  ]),
                                  Row(children: [
                                    Text("จังหวัด: ${address['province']}"),
                                    SizedBox(width: w * 0.025),
                                    Text("รหัสไปรษณีย์: ${address['zipcode']}"),
                                  ]),
                                  Row(children: [
                                    Text("โทรศัพท์: ${address['tel']}"),
                                  ]),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
              ),
              // แสดงรวมราคาสินค้า
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("ราคาสินค้า"),
                        Text("${totalPrice.toStringAsFixed(2)} บาท"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("ค่าจัดส่ง"),
                        Text("${shippingCost.toStringAsFixed(2)} บาท"),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "รวม",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${totalWithShipping.toStringAsFixed(2)} บาท",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: h * 0.05),
              // ปุ่มยืนยันการสั่งซื้อ
              GestureDetector(
                onTap: () async {
                  // ดึงข้อมูลผู้ใช้จาก Firebase Authentication
                  User? user = FirebaseAuth.instance.currentUser;
                  String userId = user?.uid ?? 'defaultUserId';

                  // ดึงข้อมูลชื่อผู้ใช้จาก Firestore
                  final currentUser = FirebaseAuth.instance.currentUser;
                  if (currentUser == null) {
                    Get.snackbar("ข้อผิดพลาด",
                        "ไม่พบข้อมูลผู้ใช้ กรุณาเข้าสู่ระบบอีกครั้ง");
                    return;
                  }
                  final userSnapshot = await FirebaseFirestore.instance
                      .collection(
                          'Users') // ชื่อ collection ที่เก็บข้อมูลผู้ใช้
                      .doc(currentUser.uid)
                      .get();

                  // ตรวจสอบว่ามีข้อมูลหรือไม่
                  if (!userSnapshot.exists) {
                    Get.snackbar(
                      "ข้อผิดพลาด",
                      "ไม่พบข้อมูลผู้ใช้ กรุณาตรวจสอบอีกครั้ง",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    return;
                  }
                  ctrl.addressesAddtoProduct.value =
                      List<Map<String, dynamic>>.from(ctrl.addresses);

                  // ดึงชื่อผู้ใช้
                  final username =
                      userSnapshot.data()?['username'] ?? "ไม่ทราบชื่อ";

                  // ล้างตะกร้าและเตรียมข้อมูลสำหรับการบันทึก
                  List<Map<String, dynamic>> selectedItems = [];
                  double totalAmount = 0.0;

                  cartitems.forEach((item) {
                    // แปลง 'price' และ 'qulity' ให้เป็น double ก่อนคำนวณ
                    int price = (item['price'] is int)
                        ? item['price']
                        : item['price'].toInt();
                    int quantity = (item['qulity'] is int)
                        ? item['qulity']
                        : item['qulity'].toInt();

                    int totalItem =
                        price * quantity; // คำนวณราคารวมของแต่ละชิ้น
                    int shippingCost = quantity *
                        10; // ค่าจัดส่งตามจำนวนชิ้น (เช่น 10 บาทต่อชิ้น)

                    selectedItems.add({
                      'priceProduct': price,
                      'productName': item['productname'],
                      'quantity': quantity,
                      'shipping': shippingCost,
                      'total':
                          totalItem + shippingCost, // ราคารวมสินค้าบวกค่าจัดส่ง
                      'userId': userId,
                      'username': username,
                      "addresses": ctrl.addressesAddtoProduct
                    });

                    totalAmount +=
                        totalItem + shippingCost; // คำนวณราคารวมทั้งหมด
                  });

                  // ล้างตะกร้า
                  ctrl.addresses.clear();
                  cartitems.clear();
                  print("${ctrl.addresses}");

                  // เพิ่มข้อมูลไปยัง Firebase ในคอลเล็กชัน OrderProduct
                  try {
                    CollectionReference orders =
                        FirebaseFirestore.instance.collection('OrderProduct');

                    // บันทึกข้อมูลการสั่งซื้อใน Firebase
                    DocumentReference orderRef = await orders.add({
                      'items': selectedItems, // รายการสินค้าที่สั่งซื้อ
                      'totalPrice': totalAmount, // ราคาทั้งหมด
                      'createdAt':
                          FieldValue.serverTimestamp(), // เวลาที่บันทึก
                      'userId': userId, // userId
                      'username': username, // username
                    });

                    // เพิ่ม Order ID (ID ของเอกสาร) ลงใน order
                    await orderRef.update({
                      'orderID': orderRef.id, // เพิ่มฟิลด์ orderID
                    });

                    // ล้างข้อมูลตะกร้าใน Firestore ตาม userId
                    try {
                      // ลบข้อมูลจาก collection Cart
                      CollectionReference cartRef =
                          FirebaseFirestore.instance.collection('Cart');
                      var userCart = cartRef.where('userID', isEqualTo: userId);
                      var snapshot = await userCart.get();

                      // ลบเอกสารทั้งหมดที่ตรงกับ userId
                      for (var doc in snapshot.docs) {
                        await doc.reference.delete();
                      }

                      print('Cart cleared successfully');
                    } catch (e) {
                      print('Error clearing cart: $e');
                    }

                    // ไปยังหน้าสำเร็จ
                    Get.to(const Successbasket());
                  } catch (e) {
                    Get.snackbar(
                      "ข้อผิดพลาด",
                      "ไม่สามารถบันทึกข้อมูลได้: $e",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                  try {
                    CollectionReference historyRef =
                        FirebaseFirestore.instance.collection("History");

                    for (var item in selectedItems) {
                      await historyRef.add({
                        'priceProduct': item['priceProduct'],
                        'productName': item['productName'],
                        'quantity': item['quantity'],
                        'total': item['total'], // ราคารวมสินค้าบวกค่าจัดส่ง
                        'userId': userId,
                        'status': ctrl.status.value,
                        'username': username,
                        'orderDate': Timestamp.now(), // เพิ่ม timestamp
                      });
                    }

                    print("History added successfully");
                  } catch (e) {
                    print("Error adding to History: $e");
                  }
                },
                child: Container(
                  width: w * 0.8,
                  height: h * 0.055,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColor.yellowbottom,
                  ),
                  child: Center(
                    child: Text(
                      "ยืนยัน",
                      style: AppFonts.fontbotton,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
