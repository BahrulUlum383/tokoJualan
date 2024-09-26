import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lastest_broo/controllers/product_controller.dart';
import 'package:lastest_broo/models/detail.dart';
import 'package:lastest_broo/models/product.dart';

class SellPage extends StatefulWidget {
  @override
  _SellPageState createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  int currentIndex = 1;

  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sell Page'),
        backgroundColor: Color.fromARGB(94, 167, 88, 24),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Center(
        child: Obx(
          () => controller.products.isEmpty
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) {
                    Product product = controller.products[index];
                    return ListTile(
                      title: Text(product.title),
                      subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
                      leading: Image.network(
                        product.image,
                        width: 60,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => Detail(
                              id: product.id,
                              title: product.title,
                              price: product.price,
                              image: product.image,
                              description: product.description,
                              rating: product.rating,
                              category: product.category,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/sell');
              break;
            case 2:
              Navigator.pushNamed(context, '/employee');
              break;
            case 3:
              Navigator.pushNamed(context, '/webViewPage');
              break;
            case 4:
              Navigator.pushNamed(context, '/dashboard');
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add_rounded),
            label: 'Buy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_3_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
