// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _HomePageState();
}

class _HomePageState extends State<Notifications> {
  //tạo List buttondata và đăng ký route
  final List<Map<String, dynamic>> buttonData = [
    {'icon': Icons.home, 'label': 'Quan Trắc', 'route': '/homepage/home'},
    {'icon': Icons.settings, 'label': 'Settings', 'route': '/settings'},
    {'icon': Icons.settings, 'label': 'Settings', 'route': '/settings'},
    {'icon': Icons.settings, 'label': 'Settings', 'route': '/settings'},
    {'icon': Icons.settings, 'label': 'Settings', 'route': '/settings'},
    {'icon': Icons.settings, 'label': 'Settings', 'route': '/settings'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 35,
                  height: 35,
                ),
                const SizedBox(width: 10),
                const Text('CTU'),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Tên đăng nhập',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(width: 10),
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logo.png'),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'Logout') {
                      Navigator.pushReplacementNamed(context, '/');
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'Logout',
                      child: Text('Logout'),
                    ),
                  ],
                  child: const Icon(Icons.more_vert),
                ),
              ],
            ),
          ],
        ),
      ),
      body: const Text('Thông báo'),
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 238, 238, 238),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(height: 1, color: Color.fromARGB(255, 158, 158, 158)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/homepage');
                    },
                    icon: const Icon(Icons.home),
                    color: Colors.white),
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/Notifications');
                  },
                  icon: const Icon(Icons.notifications),
                  color: Colors.blue,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/Settings');
                  },
                  icon: const Icon(Icons.settings),
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
