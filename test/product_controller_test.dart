import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:lastest_broo/controllers/product_controller.dart';
import 'package:mockito/annotations.dart';

import 'product_controller_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('ProductController', () {
    test('fetchProducts success', () async {
      final mockClient = MockClient();
      final productController = ProductController();

      // Konfigurasi respons palsu dari server
      when(mockClient.get(Uri.parse('https://fakestoreapi.com/products')))
          .thenAnswer((_) async => http.Response(
                '[{"id": 1, "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops", "price": 109.95, "description": "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday", "category": "men\'s clothing", "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg", "rating": {"rate": 3.9, "count": 120}}]',
                200,
              ));

      // Panggil metode fetchProducts
      await productController.fetchProducts(mockClient);

      // Verifikasi bahwa produk telah diambil dan diassign dengan benar
      expect(productController.products.length, 1); 
      expect(productController.products[0].title,
          'Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops');
      // Tambahkan asertion lain sesuai dengan kebutuhan
    });

    test('fetchProducts failure', () async {
      final mockClient = MockClient();
      final productController = ProductController();

      // Konfigurasi respons palsu dari server dengan status code 400
      when(mockClient.get(Uri.parse('https://fakestoreapi.com/products')))
          .thenAnswer((_) async => http.Response('Internal Server Error', 400));

      // Verifikasi bahwa produk tetap kosong karena terjadi kesalahan
      expect(productController.products.isEmpty, true);
    });
  });
}
