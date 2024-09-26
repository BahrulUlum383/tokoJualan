import 'package:appwrite/models.dart' as models;
import 'package:lastest_broo/controllers/client_controller.dart';

class AuthRepository {
  final ClientController clientController;
  AuthRepository(this.clientController);

  Future<models.File> uploadEmployeeImage(String imagePath) =>
      clientController.uploadEmployeeImage(imagePath);
  Future<dynamic> deleteEmployeeImage(String fileId) =>
      clientController.deleteEmployeeImage(fileId);
  Future<models.Document> createEmployee(Map map) =>
      clientController.createEmployee(map);
  Future<models.DocumentList> getEmployees() => clientController.getEmployees();
  Future<models.Document> updateEmployee(Map map) =>
      clientController.updateEmployee(map);
  Future<dynamic> deleteEmployee(Map map) =>
      clientController.deleteEmployee(map);
}
