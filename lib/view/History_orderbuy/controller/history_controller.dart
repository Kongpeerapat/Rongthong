import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  var history =
      <Map<String, dynamic>>[].obs; // เก็บข้อมูลประวัติการสั่งซื้อแบบเรียลไทม์

  @override
  void onInit() {
    super.onInit();
    streamHistory(); // เรียกใช้งานเมื่อ Controller ถูกสร้าง
  }
void streamHistory() {
  // ดึง userId จาก Firebase Authentication
  String? userId = FirebaseAuth.instance.currentUser?.uid;

  if (userId == null) {
    print("Error: User not logged in.");
    return;
  }

  FirebaseFirestore.instance
      .collection("History")
      .where('userId', isEqualTo: userId) // กรองข้อมูลตาม userId
      .snapshots() // สตรีมข้อมูลแบบเรียลไทม์
      .listen((snapshot) {
    history.value = snapshot.docs.map((doc) {
      return {
        'productName': doc['productName'] ?? "ไม่มีชื่อสินค้า",
        'quantity': doc['quantity'] ?? 0,
        'price': doc['priceProduct'] ?? 0,
        'total': doc['total'] ?? 0,
        'orderDate': doc['orderDate'] ?? "",
      };
    }).toList();
  }, onError: (e) {
    print("Error fetching history: $e");
  });
}

}
