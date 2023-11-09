// ignore_for_file: file_names

enum ColorLabel {
  socTrang('1', 'Sóc Trăng'),
  canTho('2', 'Cần Thơ'),
  vinhLong('3', 'Vĩnh Long'),
  traVinh('4', 'Trà Vinh'),
  anGiang('5', 'An Giang');

  const ColorLabel(this.id, this.label);
  final String label;
  final String id;
}

enum IconLabel {
  tram1ST('1', 'Trạm 1', '26oC', '90%'),
  tram2ST('1', 'Trạm 2', '30oC', '89%'),
  tram3CT('2', 'Trạm 3', '31oC', '90%'),
  tram4CT('2', 'Trạm 4', '29oC', '88%');

  const IconLabel(this.id, this.label, this.temperature, this.humidity);
  final String id;
  final String label;
  final String temperature;
  final String humidity;
}
