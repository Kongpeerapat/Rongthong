import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class ControllerSoldrice extends GetxController {
  RxString choose = ''.obs;
  RxString carwidth = ''.obs;
  RxString name = ''.obs;
  RxString tel = ''.obs;
  RxString address = ''.obs;
  RxInt pricecarwidth = 0.obs;
  RxInt distance = 0.obs;
  RxInt pricedistance = 0.obs;
  RxInt sumpey = 0.obs;
  RxInt status = 0.obs;
  var currentLocation = "".obs; // ✅ ตัวแปรเก็บที่อยู่


  // ignore: non_constant_identifier_names
  void Choose(String cartype) {
    choose = cartype.obs;
    update();
  }

  // ignore: non_constant_identifier_names
  void SumcarPrice() {
    sumpey = pricecarwidth + distance.value;
  }

  String? curenUserid = FirebaseAuth.instance.currentUser?.uid;
  DocumentReference docRef =
      FirebaseFirestore.instance.collection("carOder").doc();

  Future<void> addcarOrder() async {
    if (curenUserid == null) {
      Get.snackbar("ข้อผิดพลาด", "กรุณาล็อกอินอีกตรั้ง");
    }
    await FirebaseFirestore.instance.collection("carOder").add({
      'id': docRef.id,
      'name': name.value,
      'tel': tel.value,
      'address': address.value,
      'cartype': carwidth.value,
      'sumprice': sumpey.value,
      'status': status.value,
      "userId": curenUserid
    });
  }


  //  Future<void> getCurrentLocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   // ✅ เช็คว่าบริการ Location เปิดอยู่หรือไม่
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     Get.snackbar("ข้อผิดพลาด", "กรุณาเปิด GPS");
  //     return;
  //   }

  //   // ✅ เช็คและขอสิทธิ์การเข้าถึงตำแหน่ง
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       Get.snackbar("ข้อผิดพลาด", "กรุณาให้สิทธิ์การเข้าถึงตำแหน่ง");
  //       return;
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     Get.snackbar("ข้อผิดพลาด", "กรุณาเปิดสิทธิ์ GPS ในการตั้งค่า");
  //     return;
  //   }

  //   // ✅ ดึงตำแหน่งปัจจุบัน
  //   Position position = await Geolocator.getCurrentPosition(
  //       // ignore: deprecated_member_use
  //       desiredAccuracy: LocationAccuracy.high);
    
  //   currentLocation.value =
  //       "ละติจูด: ${position.latitude}, ลองจิจูด: ${position.longitude}";
  // }
}
