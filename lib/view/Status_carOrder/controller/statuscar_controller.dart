import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class StatuscarController extends GetxController {
  RxList<Map<String, dynamic>> orderTrackter = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> orderTrackter2 = <Map<String, dynamic>>[].obs;

  void addOrder(Map<String, dynamic> order) {
    orderTrackter.add(order);
  }

  void addOrder2(Map<String, dynamic> order2) {
    orderTrackter2.add(order2);
  }

  String? userId = FirebaseAuth.instance.currentUser?.uid;

  Stream<QuerySnapshot> odercar1() {
    return FirebaseFirestore.instance
        .collection("carOder")
        .where("userId", isEqualTo: userId)
        .snapshots();
  }
  
  Stream<QuerySnapshot> odercar2() {
    return FirebaseFirestore.instance
        .collection("tactorOder")
        .where("userId", isEqualTo: userId)
        .snapshots();
  }
}
