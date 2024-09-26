import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  void _navigateTo(String route) {
    Get.toNamed(route);
  }

  Container _customButton(String text, String route) {
    return Container(
      height: 50,
      width: 330,
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Color.fromARGB(94, 167, 88, 24),
        borderRadius: BorderRadius.circular(25),
      ),
      child: InkWell(
        onTap: () {
          _navigateTo(route);
        },
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 5),
              Text(
                text,
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo_petstoree.png',
                    height: 300,
                  ),
                  SizedBox(height: 130),
                  _customButton('Register', '/register'),
                  SizedBox(height: 20),
                  _customButton('Login', '/login'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
