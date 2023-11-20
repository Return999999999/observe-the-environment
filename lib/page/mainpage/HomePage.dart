// ignore_for_file: file_names

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: Column(
        children: [
          const SizedBox(
            //color: const Color.fromARGB(255, 255, 19, 7),
            height: 200.0,
            width: 30,
          ),
          Column(
            children: [
              Center(
                  child: SizedBox(
                //color: const Color.fromARGB(255, 247, 255, 7),
                height: 113.0,
                width: 420.0,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 0.1,
                      mainAxisExtent: 60.0),
                  itemCount: buttonData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        ElevatedButton(
                            onPressed: () {
                              // Xử lý sự kiện khi nhấn nút
                              Navigator.pushReplacementNamed(
                                  context, buttonData[index]['route']);
                            },
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(80, 50),
                                maximumSize: const Size(80, 50)),
                            child: Column(
                              children: <Widget>[
                                Icon(buttonData[index]['icon']),
                                Center(
                                  child: Text(
                                    buttonData[index]['label'],
                                    textScaleFactor: 0.7,
                                  ),
                                )
                              ],
                            )),
                      ],
                    );
                  },
                ),
              ))
            ],
          ),
        ],
      ),
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
                    color: Colors.blue),
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/Notifications');
                  },
                  icon: const Icon(Icons.notifications),
                  color: Colors.white,
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
