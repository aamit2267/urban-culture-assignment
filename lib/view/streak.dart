import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../res/colors.dart';
import '../res/fonts.dart';

class Streaks extends StatelessWidget {
  final int streak;
  final List<int> stats;
  const Streaks({super.key, required this.streak, required this.stats});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                'Today\'s Goal: ${streak + 1} streak days',
                style: AppFonts.bigHeading,
              ),
            ),
            Container(
              height: 110,
              padding: const EdgeInsets.all(20.0),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColor.checkButtonColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Streak Days',
                    style: AppFonts.smallHeading,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$streak',
                    style: AppFonts.primarytextBig2,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Daily Streak',
              style: AppFonts.smallHeading,
            ),
            const SizedBox(height: 8),
            Text(
              '$streak',
              style: AppFonts.primarytextBig1,
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                text: 'Last 30 Days',
                style: AppFonts.secondarytextBig3,
                children: [
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: '+100%',
                    style: AppFonts.statusPercentage,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 240,
              child: SfCartesianChart(
                series: <CartesianSeries>[
                  SplineSeries<ChartData, String>(
                    splineType: SplineType.clamped,
                    color: AppColor.secondarytextColor,
                    dataSource: List.generate(stats.length, (index) {
                      return ChartData(index, stats[index]);
                    }),
                    xValueMapper: (ChartData data, _) => data.x.toString(),
                    yValueMapper: (ChartData data, _) => data.y,
                  ),
                ],
                primaryXAxis: CategoryAxis(
                  majorGridLines: const MajorGridLines(width: 0),
                  axisLine: const AxisLine(width: 0),
                  majorTickLines: const MajorTickLines(size: 0),
                  labelStyle: AppFonts.graphLabel,
                  interval: 1,
                  axisLabelFormatter: (axisLabelRenderArgs) {
                    return ChartAxisLabel(
                      (axisLabelRenderArgs.value + 1 < 7)
                          ? "${(axisLabelRenderArgs.value + 1).toInt()}D"
                          : (axisLabelRenderArgs.value + 1 < 30 &&
                                  ((axisLabelRenderArgs.value + 1) % 7 == 0))
                              ? "${(axisLabelRenderArgs.value + 1) ~/ 7}W"
                              : (axisLabelRenderArgs.value + 1 < 365 &&
                                      (axisLabelRenderArgs.value + 1) % 30 == 0)
                                  ? "${(axisLabelRenderArgs.value + 1) ~/ 30}M"
                                  : (axisLabelRenderArgs.value + 1 < 365 &&
                                          (axisLabelRenderArgs.value + 1) %
                                                  365 ==
                                              0)
                                      ? "${(axisLabelRenderArgs.value + 1) ~/ 365}Y"
                                      : "",
                      AppFonts.graphLabel,
                    );
                  },
                ),
                primaryYAxis: const NumericAxis(
                  majorGridLines: MajorGridLines(width: 0),
                  axisLine: AxisLine(width: 0),
                  labelStyle: TextStyle(color: Colors.transparent),
                  minimum: 0,
                  maximum: 5,
                  interval: 1,
                  majorTickLines: MajorTickLines(size: 0),
                ),
                borderColor: Colors.transparent,
                borderWidth: 0.0,
                plotAreaBorderWidth: 0.0,
                backgroundColor: AppColor.backgroundColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Keep it up! You\'re on a roll.',
              style: AppFonts.smallHeading,
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.checkButtonColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: const Size(
                  double.infinity,
                  40,
                ),
              ),
              onPressed: () {},
              child: Center(
                child: Text(
                  'Get Started',
                  style: AppFonts.buttonText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final int y;
}
