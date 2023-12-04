// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username = "";
  String password = "";
  bool showPassword = false;
  List<Map<String, String>> users = [
    {'username': 'admin', 'password': 'admin'},
    {'username': 'diepb1906635', 'password': '123456'},
  ];
  void _togglePasswordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  void _login() {
    bool isValidUser = false;
    for (var user in users) {
      if (username == user['username'] && password == user['password']) {
        isValidUser = true;
        break;
      }
    }
    if (isValidUser) {
      Navigator.pushReplacementNamed(
        context,
        '/homepage',
        arguments: username,
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Đăng nhập không thành công'),
            content: const Text('Sai tên đăng nhập hoặc mật khẩu'),
            actions: <Widget>[
              TextButton(
                child: const Text('Thành công'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng Nhập'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                width: 200.0,
                height: 200.0,
              ),
              const SizedBox(height: 4.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tài khoản',
                ),
                onChanged: (value) {
                  setState(() {
                    username = value;
                  });
                },
              ),
              const SizedBox(height: 4.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Mật khẩu',
                ),
                obscureText: !showPassword,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              const SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  const Text('Ẩn/Hiện Mật Khẩu'),
                  Switch(
                    value: showPassword,
                    onChanged: (value) {
                      _togglePasswordVisibility();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: _login,
                child: const Text('Đăng Nhập'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
