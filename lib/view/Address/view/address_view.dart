import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_getx/Widget/widgetall.dart';
import 'package:firebase_getx/theme/color.dart';
import 'package:firebase_getx/theme/fonts.dart';
import 'package:firebase_getx/view/Address/controller/address_controller.dart';
import 'package:firebase_getx/view/Address/view/add_adresee.dart';
import 'package:firebase_getx/view/Address/view/edit_adress_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressView extends GetView<AddressController> {
  const AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    var w = Get.width;
    var h = Get.height;
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Widgetall.bottomBack(),
              SizedBox(width: w * 0.25),
              Padding(
                padding: EdgeInsets.only(top: h * 0.075),
                child: Text("ที่อยู่ของฉัน", style: AppFonts.fontpage),
              ),
            ],
          ),
          SizedBox(height: h * 0.02),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: Get.find<AddressController>().getAddressStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.to(const AddAdresee());
                          },
                          icon: Icon(
                            Icons.location_on_rounded,
                            color: AppColor.yellow,
                            size: w * 0.25,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(const AddAdresee());
                          },
                          child: Text(
                            "เพิ่มที่อยู่",
                            style: AppFonts.fontpage.copyWith(color: AppColor.black),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                var addresses = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: addresses.length,
                  itemBuilder: (context, index) {
                    var address = addresses[index].data() as Map<String, dynamic>;
                    return Card(
                      child: ListTile(
                        title: Text("ชื่อ: ${address['name']}"),
                        subtitle: Text("ที่อยู่: ${address['house_number']}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Get.to(const EditAdressView(), arguments: address);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                Get.find<AddressController>().removeAddress(addresses[index].id);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: h * 0.02),
          GestureDetector(
            onTap: () {
              Get.to(const AddAdresee());
            },
            child: Container(
              width: w * 0.6,
              height: h * 0.05,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: AppColor.yellow,
              ),
              child: Center(
                child: Text(
                  "เพิ่มที่อยู่ใหม่",
                  style: AppFonts.fontbotton.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(height: h * 0.05),
        ],
      ),
    );
  }
}
