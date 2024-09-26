import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lastest_broo/controllers/client_controller.dart';

import '../view/login_page.dart';

class AuthControllerA extends ClientController {
  Account? account;
  Storage? storage;
  Databases? databases;
  final GetStorage _getStorage = GetStorage();

  RxBool isLoading = false.obs;
  RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus(); // Cek status login saat controller diinisialisasi
    // appwrite
    account = Account(client);
    storage = Storage(client);
    databases = Databases(client);
  }

  Future<void> checkLoginStatus() async {
    isLoggedIn.value = _getStorage.read('user_token') != null;
  }

  Future<void> registerUser(Map map) async {
    try {
      isLoading.value = true;
      final result = await account!.create(
        userId: map['userId'],
        email: map['email'],
        password: map['password'],
        name: map['name'],
      );
      print("AccountController:: createAccount $result");
      Get.snackbar('Success', 'Registration successful',
          backgroundColor: Colors.green);
      Get.off(LoginPage()); //Navigate ke Login Page
    } catch (error) {
      Get.snackbar('Error', 'Registration failed: $error',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginUser(Map map) async {
    try {
      isLoading.value = true;
      final result = await account!.createEmailSession(
        email: map['email'],
        password: map['password'],
      );
      print("AccountController:: createEmailSession $result");
      _getStorage.write('user_token', result.$id); // Simpan token sesi
      Get.snackbar('Success', 'Login successful',
          backgroundColor: Colors.green);
      isLoggedIn.value = true; // Set status login menjadi true
      Get.offAllNamed(
          '/home'); // Navigate ke HomePage dan hapus semua halaman sebelumnya
    } catch (error) {
      Get.snackbar('Error', 'Login failed: $error',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    _getStorage
        .remove('user_token'); // Hapus token autentikasi dari penyimpanan
    isLoggedIn.value = false; // Set status login menjadi false
    Get.offAllNamed(
        '/login'); // Navigate ke HomePage dan hapus semua halaman sebelumnya
  }
}
