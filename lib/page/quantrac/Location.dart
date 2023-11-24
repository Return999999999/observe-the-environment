// ignore_for_file: non_constant_identifier_names, avoid_print, duplicate_ignore, unnecessary_new, depend_on_referenced_packages, file_names, unrelated_type_equality_checks

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:intl/intl.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  Timer? _timer;
  bool isRed = false;
  late MqttServerClient _client;
  String selectedStation = "station1";
  Map<String, dynamic> stationData = {
    "station1": {
      "sensor1": {"name": "temperature", "value": 25, "unit": "oC"},
      "sensor2": {"name": "humidity", "value": 60, "unit": "%"},
      "sensor3": {"name": "pressure", "value": 1.01325, "unit": "Pa"}
    },
    "station2": {
      "sensor1": {"name": "temperature", "value": 35, "unit": "oC"},
      "sensor2": {"name": "humidity", "value": 55, "unit": "%"},
      "sensor3": {"name": "pressure", "value": 1.02312, "unit": "Pa"}
    }
  };
  Map<String, dynamic> parseMessage(String message) {
    // Replace this with your actual parsing logic
    // For example, if the message is in JSON format:
    return json.decode(message);
  }

  @override
  void initState() {
    super.initState();
    _connect();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (stationData[selectedStation]['sensor1']['value'] >= 30) {
          isRed = !isRed; // Đảo ngược giá trị màu sắc
        } else {
          isRed = false; // Đặt màu sắc về màu đen nếu nhiệt độ dưới 30
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Hủy timer trước khi dispose widget
    super.dispose();
  }

  void _connect() async {
    _client = MqttServerClient('dev.iotlab.net.vn', 'mqttx_93bbd475');
    _client.logging(on: true);
    _client.onDisconnected = _onDisconnected;

    final connMess = MqttConnectMessage()
        // ignore: deprecated_member_use
        .keepAliveFor(60)
        .withClientIdentifier('a')
        .authenticateAs('ui1@Iotlab', 'Iotlab@2023')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    _client.connectionMessage = connMess;

    try {
      await _client.connect();
    } catch (e) {
      // ignore: avoid_print
      print('Exception: $e');
    }

    if (_client.connectionStatus?.state == MqttConnectionState.connected) {
      // ignore: avoid_print
      print('Connected to broker!');
      _client.updates?.listen(_onMessage);
      _subscribe();
    } else {
      // ignore: avoid_print
      print('Failed to connect to broker!');
      _client.disconnect();
    }
  }

  void _subscribe() {
    _client.subscribe('Data/view', MqttQos.atMostOnce);
  }

  void _onMessage(List<MqttReceivedMessage> event) {
    final MqttPublishMessage recMess = event[0].payload as MqttPublishMessage;
    final String topic = event[0].topic;
    final String message =
        MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

    if (topic == 'Data/view') {
      setState(() {
        Map<String, dynamic> parsedData = parseMessage(message);
        stationData = parsedData;
      });
    }
  }

  void _onDisconnected() {
    print('Disconnected from broker!');
    _connect(); // Reconnect to the broker when disconnected
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 50),
            DropdownButton<String>(
              value: selectedStation,
              items: stationData.keys.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    value == 'station1'
                        ? 'Trạm 1'
                        : value == 'station2'
                            ? 'Trạm 2'
                            : value,
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedStation = newValue!;
                });
              },
            ),
            const SizedBox(height: 50),
            Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                    color: Colors.white,
                    width: 0), // Đặt màu sắc và độ dày cho viền
                borderRadius:
                    BorderRadius.circular(15.0), // Đặt độ cong của góc thẻ
              ),
              child: Column(
                children: [
                  Text(
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      '${now.hour}:${now.minute}:${now.second}  Ngày ${DateFormat('dd/MM/yyyy').format(now)}'),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 400,
                    height: 270,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.red, width: 2.0),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: <Widget>[
                                  const Icon(
                                    Icons.thermostat,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Nhiệt độ:  ${stationData[selectedStation]['sensor1']['value']}${stationData[selectedStation]['sensor1']['unit']}",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 80),
                                  Icon(
                                    Icons.warning,
                                    color: isRed ? Colors.red : Colors.black,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.blue,
                                  width: 2.0), // Đặt màu sắc và độ dày cho viền
                              borderRadius: BorderRadius.circular(
                                  15.0), // Đặt độ cong của góc thẻ
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: <Widget>[
                                  const Icon(
                                    IconData(0x22C7,
                                        fontFamily: 'WeatherIcons'),
                                    color: Colors.blue,
                                    size: 30,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Độ ẩm: ${stationData[selectedStation]['sensor2']['value']}${stationData[selectedStation]['sensor2']['unit']}",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.green,
                                  width: 2.0), // Đặt màu sắc và độ dày cho viền
                              borderRadius: BorderRadius.circular(
                                  15.0), // Đặt độ cong của góc thẻ
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: <Widget>[
                                  const Icon(
                                    Icons.trending_up, // Biểu tượng áp suất
                                    color: Colors
                                        .green, // Màu sắc của biểu tượng áp suất
                                    size:
                                        30, // Kích thước của biểu tượng áp suất
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Áp suất: ${stationData[selectedStation]['sensor3']['value']}${stationData[selectedStation]['sensor3']['unit']}",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
