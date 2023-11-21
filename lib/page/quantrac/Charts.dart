// ignore_for_file: file_names, unused_import, unused_local_variable

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Charts extends StatefulWidget {
  const Charts({super.key});

  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  Map<String, dynamic> stationData = {
    "station1": {
      "temperature": [25, 24, 23, 24, 21, 27, 19, 18, 17, 16],
      "humidity": [67, 68, 65, 66, 65, 67, 66, 65, 66, 67],
      "pressure": [101, 102, 101, 103, 104, 102, 103, 100, 102, 101]
    },
    "station2": {
      "temperature": [28, 26, 23, 25, 24, 26, 24, 23, 22, 24],
      "humidity": [55, 56, 57, 58, 59, 60, 61, 62, 63, 64],
      "pressure": [102, 102, 101, 103, 102, 103, 103, 100, 102, 101]
    }
  };

  String selectedStation = 'station1';
  String selectedParameter = 'temperature';

  void _updateChartSeries(String station) {
    setState(() {
      selectedStation = station;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<int> selectedData =
        stationData[selectedStation][selectedParameter].cast<int>();

    return Scaffold(
      body: Column(
        children: [
          DropdownButton<String>(
            value: selectedStation,
            items: stationData.keys.map((String station) {
              return DropdownMenuItem<String>(
                value: station,
                child: Text(
                  station == 'station1'
                      ? 'Trạm 1'
                      : station == 'station2'
                          ? 'Trạm 2'
                          : station,
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _updateChartSeries(newValue);
                });
              }
            },
          ),
          DropdownButton<String>(
            value: selectedParameter,
            items: ['temperature', 'humidity', 'pressure'].map((String param) {
              return DropdownMenuItem<String>(
                value: param,
                child: Text(
                  param == 'temperature'
                      ? 'Nhiệt độ'
                      : param == 'humidity'
                          ? 'Độ ẩm'
                          : param == 'pressure'
                              ? 'Áp xuất'
                              : param,
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedParameter = newValue;
                });
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 30,
              ),
              Text(
                selectedParameter == 'temperature'
                    ? '°C'
                    : selectedParameter == 'humidity'
                        ? '%'
                        : selectedParameter == 'pressure'
                            ? ' ‰'
                            : selectedParameter,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: 400,
            height: 500,
            child: LineChart(
              LineChartData(
                lineBarsData: [
                  LineChartBarData(
                    spots: selectedData.asMap().entries.map((e) {
                      return FlSpot(e.key.toDouble(), e.value.toDouble());
                    }).toList(),
                  ),
                ],
                titlesData: const FlTitlesData(
                  topTitles: AxisTitles(axisNameWidget: Text("")),
                  rightTitles: AxisTitles(axisNameWidget: Text("")),
                ),
              ),
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Text("Phút")],
          )
        ],
      ),
    );
  }
}
