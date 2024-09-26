import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lastest_broo/controllers/appwireAuth_controller.dart';

class LoginDRegPage extends StatefulWidget {
  @override
  State<LoginDRegPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginDRegPage> {
  final AuthControllerA _authController = Get.put(AuthControllerA());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Container _customButton(String text, Function() onPressed) {
    return Container(
      height: 50,
      width: 150, // Adjust the width according to your design
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Color.fromARGB(94, 167, 88, 24),
        borderRadius: BorderRadius.circular(25),
      ),
      child: InkWell(
        onTap: _authController.isLoading.value ? null : onPressed,
        child: Center(
          child: _authController.isLoading.value
              ? CircularProgressIndicator()
              : Text(
                  text,
                  style: TextStyle(
                    color: Colors.brown,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(94, 167, 88, 24),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _customButton('Login', () {
                  _authController.loginUser({
                    'email': _emailController.text,
                    'password': _passwordController.text,
                  });
                }),
                _customButton('Register', () {
                  _authController.registerUser({
                    'userId': ID.unique(),
                    'email': _emailController.text,
                    'password': _passwordController.text,
                    'name': _nameController.text,
                  });
                }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
