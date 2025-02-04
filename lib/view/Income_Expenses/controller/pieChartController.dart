import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Piechartcontroller extends GetxController {
  var touchedIndex = (-1).obs;

  // ข้อมูลสำหรับ PieChart
  var data = [
    {'value': 7000000, 'color': Colors.blue, 'label': 'รายรับ'},
    {'value': 10, 'color': Colors.yellow, 'label': 'ราายจ่าย'},
  ].obs;

  void updateTouchedIndex(int index) {
    touchedIndex.value = index;
  }
}
