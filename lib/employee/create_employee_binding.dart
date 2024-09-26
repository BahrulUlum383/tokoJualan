import 'package:get/get.dart';
import 'package:lastest_broo/controllers/client_controller.dart';
import 'package:lastest_broo/controllers/employee_controller.dart';
import 'package:lastest_broo/controllers/product_controller.dart';
import 'package:lastest_broo/utils/auth_repository.dart';

class CreateEmployeeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientController>(() => ClientController());
    Get.lazyPut<AuthRepository>(() => AuthRepository(Get.find<ClientController>()));
    Get.lazyPut<EmployeeController>(() => EmployeeController(Get.find<AuthRepository>()));
    Get.lazyPut<ProductController>(() => ProductController());
  }
}
