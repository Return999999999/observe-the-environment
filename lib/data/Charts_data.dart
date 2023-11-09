// ignore_for_file: file_names

List<DataT> getChartData() {
  final List<DataT> chartData = [
    DataT(2017, 25, 89),
    DataT(2018, 12, 90),
    DataT(2019, 24, 87),
    DataT(2020, 18, 88),
    DataT(2021, 30, 90)
  ];
  return chartData;
}

// ignore: camel_case_types
class DataT {
  DataT(this.year, this.T, this.H);
  final double year;
  final double T;
  final double H;
}

List<salesData1> getChartData1() {
  final List<salesData1> chartData1 = [
    salesData1(2017, 20, 90),
    salesData1(2018, 13, 87),
    salesData1(2019, 23, 88),
    salesData1(2020, 19, 89),
    salesData1(2021, 31, 80)
  ];
  return chartData1;
}

// ignore: camel_case_types
class salesData1 {
  salesData1(this.year, this.sales, this.H);
  final double year;
  final double sales;
  final double H;
}
