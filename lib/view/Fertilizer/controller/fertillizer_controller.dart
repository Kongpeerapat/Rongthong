import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_getx/theme/color.dart';
import 'package:firebase_getx/view/Login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class FertillizerController extends GetxController {
  RxString name = "".obs;
  RxString nameconfirm = "".obs;
  RxInt price = 0.obs;
  RxInt priceconfirm = 0.obs;
  RxInt qulity = 1.obs;
  RxInt qulityconfirm = 0.obs; // จำนวนสินค้าในการยืนยัน
  RxInt shipping = 0.obs; // ค่าจัดส่ง
  RxInt sum = 0.obs; // ราคาทั้งหมด (รวมสินค้าและค่าจัดส่ง)
  RxInt sumbasket = 0.obs; // ราคาทั้งหมด (รวมสินค้าและค่าจัดส่ง)
  RxDouble totalWithShipping = 0.0.obs;
  RxString idproduct = "".obs;
  RxBool status = false.obs;
  RxList<dynamic> productImages = <dynamic>[].obs;
  RxList<Map<String, dynamic>> cartitems = <Map<String, dynamic>>[].obs;
  final user = Get.put(LoginController());

  var w = Get.width;
  var h = Get.height;

  void add() {
    qulity++; // เพิ่มจำนวนสินค้า
  }

  void desclip() {
    if (qulity.value > 1) {
      qulity--; // ลดจำนวนสินค้า
    }
  }

  void confirmPrice() {
    priceconfirm.value = price.value * qulityconfirm.value; // คำนวณราคาสินค้า
    shipping.value = qulity.value * 10; // ค่าจัดส่ง
    sum.value = shipping.value + priceconfirm.value; // รวมราคา
  }

  Future<void> addcart() async {
    try {
      if (name.isEmpty || productImages.isEmpty) {
        Get.snackbar("ข้อผิดพลาด", "กรุณากรอกข้อมูลให้ครบถ้วน");
        return;
      }

      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        Get.snackbar("ข้อผิดพลาด", "กรุณาเข้าสู่ระบบอีกครั้ง");
        return;
      }

      final userSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser.uid)
          .get();

      if (!userSnapshot.exists) {
        Get.snackbar("ข้อผิดพลาด", "ไม่พบข้อมูลผู้ใช้");
        return;
      }

      // เพิ่ม ID ของสินค้า (IDproduct) และ UserID
      print(
          "Adding to cart: $name, $priceconfirm, $qulityconfirm, $productImages");

      await FirebaseFirestore.instance.collection("Cart").add({
        "productname": name.value,
        "userID": currentUser.uid, // เปลี่ยนจาก username เป็น userID
        "price": priceconfirm.value,
        "qulity": qulityconfirm.value,
        "imageproduct": productImages,
        "timestamp": FieldValue.serverTimestamp(),
        "idproduct": idproduct.value, // เพิ่ม ID ของสินค้า
      });

      Get.snackbar("สำเร็จ", "เพิ่มสินค้าไปยังตะกร้าเรียบร้อยแล้ว",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar("ข้อผิดพลาด", "เกิดข้อผิดพลาด: $e");
    }
  }

  // ดึงข้อมูลสินค้าในตะกร้า
  Stream<List<Map<String, dynamic>>> getCartItems() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return const Stream.empty();

    return FirebaseFirestore.instance
        .collection("Cart")
        .where("userID",
            isEqualTo: currentUser.uid) // เปลี่ยนจาก username เป็น userID
        .orderBy("timestamp", descending: true) // เรียงจากล่าสุดไปเก่าสุด
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              return {
                "id": doc.id,
                "productname": data["productname"] ?? "ไม่มีชื่อสินค้า",
                "price": data["price"] ?? 0,
                "qulity": data["qulity"] ?? 0,
                "imageproduct": data["imageproduct"] ?? [],
                "idproduct": data["idproduct"] ?? "", // เพิ่ม IDproduct
              };
            }).toList());
  }

  // เพิ่มจำนวนสินค้า
  void increaseItemQuantity(String cartId, int currentQuantity) {
    FirebaseFirestore.instance
        .collection("Cart")
        .doc(cartId)
        .update({"qulity": currentQuantity + 1});
  }

  // ลดจำนวนสินค้า
  void decreaseItemQuantity(String cartId, int currentQuantity) {
    if (currentQuantity > 1) {
      FirebaseFirestore.instance
          .collection("Cart")
          .doc(cartId)
          .update({"qulity": currentQuantity - 1});
    } else {
      FirebaseFirestore.instance.collection("Cart").doc(cartId).delete();
    }
  }

  // ลบสินค้า
  void removeItemFromCart(String cartId) {
    FirebaseFirestore.instance.collection("Cart").doc(cartId).delete();
  }

  // คำนวณราคารวม
  Stream<double> calculateTotalPrice() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return const Stream.empty();

    return FirebaseFirestore.instance
        .collection("Cart")
        .where("userID",
            isEqualTo: currentUser.uid) // เปลี่ยนจาก username เป็น userID
        .snapshots()
        .map((snapshot) {
      double total = 0.0;
      for (var doc in snapshot.docs) {
        final data = doc.data();
        total += (data["price"] * data["qulity"]);
      }
      return total;
    });
  }

  Future<void> orderProduct() async {
    try {
      // ตรวจสอบว่าข้อมูลสินค้าครบถ้วน
      if (name.value.isEmpty) {
        Get.snackbar("ข้อผิดพลาด", "กรุณากรอกข้อมูลให้ครบถ้วน");
        return;
      }

      // ดึง UID ของผู้ใช้ที่ล็อกอิน
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        Get.snackbar(
            "ข้อผิดพลาด", "ไม่พบข้อมูลผู้ใช้ กรุณาเข้าสู่ระบบอีกครั้ง");
        return;
      }

      // ดึงข้อมูลชื่อผู้ใช้จาก Firestore
      final userSnapshot = await FirebaseFirestore.instance
          .collection('Users') // ชื่อ collection ที่เก็บข้อมูลผู้ใช้
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

      // ดึงชื่อผู้ใช้
      final usernameFromFirestore =
          userSnapshot.data()?['username'] ?? "ไม่ทราบชื่อ";

      // บันทึกคำสั่งซื้อไปยัง Firestore
      await FirebaseFirestore.instance.collection("OrderProduct").add({
        "userId": currentUser.uid, // UID ของผู้ใช้
        "username": usernameFromFirestore, // ชื่อผู้ใช้ที่ดึงมาจาก Firestore
        "productName": name.value, // ชื่อสินค้า
        "quantity": qulityconfirm.value, // จำนวนสินค้า
        "priceProduct": price.value, // ราคาสินค้าต่อชิ้น
        "shipPing": shipping.value, // ค่าจัดส่ง
        "total": sum.value, // ราคาสุทธิ (รวมค่าจัดส่ง)
        "orderDate": Timestamp.now(), // เวลาที่สั่งซื้อ
        "status": status.value,
        "addresess": addressesAddtoProduct
      });

      // แสดงข้อความสำเร็จ
      Get.snackbar(
        "สำเร็จ",
        "บันทึกคำสั่งซื้อเรียบร้อยแล้ว",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print("Error: $e");
      Get.snackbar(
        "ข้อผิดพลาด",
        "ไม่สามารถบันทึกคำสั่งซื้อได้",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> history() async {
    try {
      // ตรวจสอบว่าข้อมูลสินค้าครบถ้วน
      if (name.value.isEmpty) {
        Get.snackbar("ข้อผิดพลาด", "กรุณากรอกข้อมูลให้ครบถ้วน");
        return;
      }

      // ดึง UID ของผู้ใช้ที่ล็อกอิน
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        Get.snackbar(
            "ข้อผิดพลาด", "ไม่พบข้อมูลผู้ใช้ กรุณาเข้าสู่ระบบอีกครั้ง");
        return;
      }

      // ดึงข้อมูลชื่อผู้ใช้จาก Firestore
      final userSnapshot = await FirebaseFirestore.instance
          .collection('Users') // ชื่อ collection ที่เก็บข้อมูลผู้ใช้
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

      // ดึงชื่อผู้ใช้
      final usernameFromFirestore =
          userSnapshot.data()?['username'] ?? "ไม่ทราบชื่อ";

      // บันทึกคำสั่งซื้อไปยัง Firestore
      await FirebaseFirestore.instance.collection("History").add({
        "userId": currentUser.uid, // UID ของผู้ใช้
        "username": usernameFromFirestore, // ชื่อผู้ใช้ที่ดึงมาจาก Firestore
        "productName": name.value, // ชื่อสินค้า
        "quantity": qulityconfirm.value, // จำนวนสินค้า
        "priceProduct": price.value, // ราคาสินค้าต่อชิ้น
        "shipPing": shipping.value, // ค่าจัดส่ง
        "total": sum.value, // ราคาสุทธิ (รวมค่าจัดส่ง)
        "orderDate": Timestamp.now(), // เวลาที่สั่งซื้อ
        "status": status.value
      });

      // แสดงข้อความสำเร็จ
      Get.snackbar(
        "สำเร็จ",
        "บันทึกคำสั่งซื้อเรียบร้อยแล้ว",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print("Error: $e");
      Get.snackbar(
        "ข้อผิดพลาด",
        "ไม่สามารถบันทึกคำสั่งซื้อได้",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  RxList<Map<String, dynamic>> addresses =
      <Map<String, dynamic>>[].obs; // สร้าง RxList เพื่อเก็บที่อยู่ที่เลือก
  RxList<Map<String, dynamic>> addressesAddtoProduct =
      <Map<String, dynamic>>[].obs; // สร้าง RxList เพื่อเก็บที่อยู่ที่เลือก

  void bottomdialog() {
    // ดึง userId จาก Firebase Authentication
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      Get.snackbar("ข้อผิดพลาด", "กรุณาเข้าสู่ระบบก่อนเพิ่มที่อยู่");
      return;
    }

    // สร้าง Stream เพื่อนำข้อมูลที่อยู่จาก Firestore มา
    Stream<QuerySnapshot> addressStream = FirebaseFirestore.instance
        .collection('Address')
        .where('userId', isEqualTo: userId) // ใช้ userId ในการกรองข้อมูล
        .snapshots();

    Get.bottomSheet(
      StreamBuilder<QuerySnapshot>(
        stream: addressStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator()); // กำลังโหลดข้อมูล
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No addresses available'));
          }

          var addressList = snapshot.data!.docs.map((doc) {
            return doc.data() as Map<String, dynamic>;
          }).toList();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize
                  .min, // ให้ขนาดของ column มีขนาดพอดีกับเนื้อหาภายใน
              children: [
                const Text(
                  "เลือกที่อยู่เพื่อจัดส่ง",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // กำหนดสีของข้อความ
                  ),
                ),
                const SizedBox(height: 20),
                // แสดงรายการที่อยู่
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: addressList.length,
                  itemBuilder: (context, index) {
                    var address = addressList[index];

                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: GestureDetector(
                        onTap: () {
                          // เพิ่มข้อมูลที่อยู่ที่เลือกไปยัง RxList
                          addresses.add(address);
                          print("Selected Address: $addresses");
                          // ตรวจสอบข้อมูลที่เลือก
                          Get.back();
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColor.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "ชื่อผู้รับ: ${address['name']}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Divider(
                                    color: Color.fromARGB(118, 5, 5, 5)),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "บ้านเลขที่: ${address['house_number']}, หมู่บ้าน: ${address['village']}",
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "เขต: ${address['district']}, จังหวัด: ${address['province']}",
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "รหัสไปรษณีย์: ${address['zipcode']}",
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    const Spacer(),
                                    const Icon(Icons.location_on,
                                        color: Colors.black),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(Icons.phone,
                                        size: 16, color: Colors.black),
                                    const SizedBox(width: 5),
                                    Text(
                                      "${address['tel']}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
      isScrollControlled: true, // ให้ขนาดของ Bottom Sheet ปรับตามเนื้อหาภายใน
      backgroundColor: Colors.white, // กำหนดสีพื้นหลังของ Bottom Sheet
    );
  }
}
