import 'package:flutter_test/flutter_test.dart';
import 'package:lastest_broo/controllers/product_controller.dart';

void main() {
  test('ProductController - ChangeNav Test', () {
    final productController = ProductController();

    // Verifikasi nilai awal indexWidget
    expect(productController.indexWidget.value, 0);

    // Panggil metode changeNav dengan indeks 1
    productController.changeNav(1);

    // Verifikasi perubahan nilai indexWidget setelah pemanggilan changeNav
    expect(productController.indexWidget.value, 1);
  });
}
