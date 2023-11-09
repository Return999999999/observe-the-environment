// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:luanvan/data/Charts_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Charts extends StatefulWidget {
  const Charts({super.key});

  @override
  State<Charts> createState() => _SettingsState();
}

class _SettingsState extends State<Charts> {
  late List<DataT> _chartData;
  late TooltipBehavior _tooltipBehavior;
  late List<salesData1> _chartData1;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
    _chartData1 = getChartData1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 180,
          child: SfCartesianChart(
            title:
                ChartTitle(text: 'Nhiệt độ', alignment: ChartAlignment.center),
            legend: const Legend(isVisible: true),
            tooltipBehavior: _tooltipBehavior,
            series: <ChartSeries>[
              LineSeries<DataT, double>(
                  name: 'Trạm 1',
                  dataSource: _chartData,
                  xValueMapper: (DataT T, _) => T.year,
                  yValueMapper: (DataT T, _) => T.T,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  enableTooltip: true),
              LineSeries<salesData1, double>(
                  name: 'Trạm 2',
                  dataSource: _chartData1,
                  xValueMapper: (salesData1 sales1, _) => sales1.year,
                  yValueMapper: (salesData1 sales1, _) => sales1.sales,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  enableTooltip: true)
            ],
            primaryXAxis: NumericAxis(
              edgeLabelPlacement: EdgeLabelPlacement.shift,
            ),
            primaryYAxis: NumericAxis(labelFormat: '{value}oC'),
          ),
        ),
        SizedBox(
          height: 180,
          child: SfCartesianChart(
            title: ChartTitle(text: 'Độ ẩm', alignment: ChartAlignment.center),
            legend: const Legend(isVisible: true),
            tooltipBehavior: _tooltipBehavior,
            series: <ChartSeries>[
              LineSeries<DataT, double>(
                  name: 'Trạm 1',
                  dataSource: _chartData,
                  xValueMapper: (DataT T, _) => T.year,
                  yValueMapper: (DataT T, _) => T.H,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  enableTooltip: true),
              LineSeries<salesData1, double>(
                  name: 'Trạm 2',
                  dataSource: _chartData1,
                  xValueMapper: (salesData1 sales1, _) => sales1.year,
                  yValueMapper: (salesData1 sales1, _) => sales1.H,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  enableTooltip: true)
            ],
            primaryXAxis: NumericAxis(
              edgeLabelPlacement: EdgeLabelPlacement.shift,
            ),
            primaryYAxis: NumericAxis(labelFormat: '{value}%'),
          ),
        ),
      ],
    ));
  }
}
