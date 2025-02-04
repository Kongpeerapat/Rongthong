import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddressController extends GetxController {
  RxList<Map<String, dynamic>> Address = <Map<String, dynamic>>[].obs;

  // ดึง userId ของผู้ใช้ที่ล็อกอินอยู่
  String get currentUserId => FirebaseAuth.instance.currentUser?.uid ?? "";

  // ✅ เพิ่มที่อยู่ (เช็ค userId)
  void addAddress(Map<String, String> newAddress) async {
    try {
      if (currentUserId.isEmpty) {
        print("Error: User is not logged in.");
        return;
      }

      // เพิ่ม userId เข้าไปในข้อมูล
      newAddress['userId'] = currentUserId;

      // บันทึกลง Firestore
      await FirebaseFirestore.instance.collection('Address').add(newAddress);

      // อัปเดต Local State
      Address.add(newAddress);
      update();
    } catch (e) {
      print("Error adding address: $e");
    }
  }

  // ✅ อัปเดตที่อยู่ (เช็ค userId)
  void updateAddress(Map<String, String> updatedAddress) async {
    try {
      if (currentUserId.isEmpty) {
        print("Error: User is not logged in.");
        return;
      }

      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Address')
          .where('house_number', isEqualTo: updatedAddress['house_number'])
          .where('village', isEqualTo: updatedAddress['village'])
          .where('userId', isEqualTo: currentUserId) // ✅ เช็ค userId
          .get();

      if (snapshot.docs.isNotEmpty) {
        await snapshot.docs[0].reference.update(updatedAddress);

        int index = Address.indexWhere((address) =>
            address['house_number'] == updatedAddress['house_number'] &&
            address['village'] == updatedAddress['village'] &&
            address['userId'] == currentUserId);

        if (index != -1) {
          Address[index] = updatedAddress;
          update();
        }
      }
    } catch (e) {
      print("Error updating address: $e");
    }
  }


  
  // ✅ ลบที่อยู่ (เช็ค userId)
  void removeAddress(String documentId) async {
  try {
    if (currentUserId.isEmpty) {
      print("Error: User is not logged in.");
      return;
    }

    // ลบ document โดยใช้ documentId
    await FirebaseFirestore.instance.collection('Address').doc(documentId).delete();

    // ลบออกจาก Local List
    Address.removeWhere((address) => address['id'] == documentId);
    update();
  } catch (e) {
    print("Error deleting address: $e");
  }
}



  // ✅ ดึงรายการที่อยู่ของผู้ใช้ที่ล็อกอินอยู่
  Stream<QuerySnapshot> getAddressStream() {
    return FirebaseFirestore.instance
        .collection('Address')
        .where('userId', isEqualTo: currentUserId) // ✅ ดึงเฉพาะที่อยู่ของผู้ใช้
        .snapshots();
  }
}
