import 'package:firebase_getx/view/Income_Expenses/controller/pieChartController.dart';
import 'package:firebase_getx/view/Income_Expenses/widget/indicator.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PieChartView extends StatelessWidget {
  final Piechartcontroller controller = Get.put(Piechartcontroller());

  PieChartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Column(
          children: <Widget>[
            Expanded(
              child: AspectRatio(
                aspectRatio: 1.3,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback:
                                  (FlTouchEvent event, pieTouchResponse) {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  controller.updateTouchedIndex(-1);
                                  return;
                                }
                                controller.updateTouchedIndex(
                                  pieTouchResponse
                                      .touchedSection!.touchedSectionIndex,
                                );
                              },
                            ),
                            borderData: FlBorderData(show: false),
                            sectionsSpace: 0,
                            centerSpaceRadius: 40,
                            sections: _buildSections(controller),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: controller.data.map((item) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Indicator(
                            color: item['color'] as Color,
                            text: item['label'] as String,
                            isSquare: true,
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(width: 28),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  List<PieChartSectionData> _buildSections(Piechartcontroller controller) {
    return List.generate(controller.data.length, (i) {
      final isTouched = i == controller.touchedIndex.value;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;

      return PieChartSectionData(
        color: controller.data[i]['color'] as Color,
        value: (controller.data[i]['value'] as int).toDouble(),
        title: '${controller.data[i]['value']}',
        radius: radius,
        titleStyle: GoogleFonts.mitr(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      );
    });
  }
}
