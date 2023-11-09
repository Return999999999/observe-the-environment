// ignore_for_file: file_names, unused_field
import 'package:flutter/material.dart';
import 'package:luanvan/page/quantrac/Charts.dart';
import 'package:luanvan/page/quantrac/Location.dart';
import 'package:luanvan/page/quantrac/Map.dart';
import 'package:luanvan/page/quantrac/Setting.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> _tabNames = [
    const ListTile(
      leading: Icon(Icons.location_on),
      title: Text('Dữ liệu đo'),
    ),
    const ListTile(
      leading: Icon(Icons.map),
      title: Text('Xem Bản đồ'),
    ),
    const ListTile(
      leading: Icon(Icons.area_chart_sharp),
      title: Text('Biểu đồ'),
    ),
    const ListTile(
      leading: Icon(Icons.settings),
      title: Text('Cài đặt'),
    ),
  ];
  int _selectedIndex = 0;
  final List<Widget> _tabs = [
    const Location(),
    const Map(),
    const Charts(),
    const Setting(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quan Trắc'),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/homepage');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/logo.png'),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Tên đăng nhập',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard,
                  color: _selectedIndex == 0 ? Colors.blue : Colors.black),
              title: Text(
                "Dữ liệu đo",
                selectionColor:
                    _selectedIndex == 0 ? Colors.blue : Colors.black,
              ),
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context); // Đóng Drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.map,
                  color: _selectedIndex == 1 ? Colors.blue : Colors.black),
              title: Text("Xem bản đồ",
                  selectionColor:
                      _selectedIndex == 0 ? Colors.blue : Colors.black),
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context); // Đóng Drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.insert_chart,
                  color: _selectedIndex == 2 ? Colors.blue : Colors.black),
              title: Text("Biểu đồ",
                  selectionColor:
                      _selectedIndex == 0 ? Colors.blue : Colors.black),
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context); // Đóng Drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.settings,
                  color: _selectedIndex == 3 ? Colors.blue : Colors.black),
              title: Text("Cài đặt",
                  selectionColor:
                      _selectedIndex == 0 ? Colors.blue : Colors.black),
              onTap: () {
                _onItemTapped(3);
                Navigator.pop(context); // Đóng Drawer
              },
            ),
          ],
        ),
      ),
      body: _tabs[_selectedIndex],
    );
  }
}
