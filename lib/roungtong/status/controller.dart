import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class StatusController extends GetxController {
  Stream<QuerySnapshot> getOrdersByUser() {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    return FirebaseFirestore.instance
        .collection("carOder")
        .where("userId", isEqualTo: userId) // กรองเฉพาะเอกสารที่ userId ตรงกัน
        .snapshots();
  }
}
