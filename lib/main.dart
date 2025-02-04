import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_getx/view/Address/controller/address_controller.dart';
import 'package:firebase_getx/view/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   Get.put(AddressController()); // 👈 เพิ่มตรงนี้
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print('Firbase error:$e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',

      home: Splash(), // หน้าแรกที่แสดงก่อน
    );
  }
}
