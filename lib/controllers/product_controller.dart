import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lastest_broo/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:lastest_broo/view/adding.dart';
import 'package:lastest_broo/view/dashboard.dart';
import 'dart:convert';

import 'package:lastest_broo/view/employee.dart';
import 'package:lastest_broo/view/home.dart';
import 'package:lastest_broo/view/sell.dart';

class ProductController extends GetxController {
  final products = <Product>[].obs;

  RxInt indexWidget = 0.obs;

  void changeNav(int index) {
    indexWidget.value = index;
    update();
  }

  List<Widget> myWidgets = [
    HomePage(),
    EmployeePage(),
    Adding(),
    SellPage(),
    Dashboard()
  ];

  @override
  void onInit() {
    super.onInit();
    final http.Client client = http.Client();
    fetchProducts(client);
  }

  Future<void> fetchProducts(http.Client client) async {
    try {
      final response =
          await client.get(Uri.parse('https://fakestoreapi.com/products'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        products.assignAll(data
            .map((item) => Product(
                  id: item['id'],
                  title: item['title'],
                  price: item['price'].toDouble(),
                  image: item['image'],
                  description: item['description'],
                  rating: Rating(
                    rate: item['rating']['rate'].toDouble(),
                    count: item['rating']['count'],
                  ),
                  category: item['category'],
                ))
            .toList());
      } else {
        throw Exception(
            'Failed to load products. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      client
          .close(); // Pastikan untuk menutup http.Client setelah pengambilan produk selesai
    }
  }
}
