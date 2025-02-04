import 'package:firebase_getx/view/Home/home.dart';
import 'package:firebase_getx/view/Profile/profile.dart';
import 'package:firebase_getx/roungtong/Sold_rice/view/checkdata.dart';
import 'package:firebase_getx/roungtong/Sold_rice/view/success.dart';
import 'package:get/get.dart';

class RoutScreen extends GetxController {
  static final routes = [
    GetPage(name: '/home', page: () => const Home()),
    GetPage(name: '/profile', page: () => const Profile()),
    GetPage(name: '/checkdata', page: () => const Checkdata()),
    GetPage(name: '/success', page: () => const Success()),
  ];
}
