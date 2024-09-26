import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:get/get.dart';
import 'package:lastest_broo/utils/apwrite_constant.dart';

class ClientController extends GetxController {
  Client client = Client();

  Storage? storage;

  Databases? databases;

  ClientController() {
    client
        .setEndpoint(AppwriteConstants.endPoint)
        .setProject(AppwriteConstants.projectId)
        .setSelfSigned(status: true);
    storage = Storage(client);
    databases = Databases(client);
  }

  Future<models.File> uploadEmployeeImage(String imagePath) {
    String fileName = "${DateTime.now().millisecondsSinceEpoch}"
        "${imagePath.split(".").last}";

    final response = storage!.createFile(
        bucketId: AppwriteConstants.employeeBucketId,
        fileId: ID.unique(),
        file: InputFile(path: imagePath, filename: fileName));

    return response;
  }

  Future<dynamic> deleteEmployeeImage(String fileId) {
    final response = storage!.deleteFile(
      bucketId: AppwriteConstants.employeeBucketId,
      fileId: fileId,
    );

    return response;
  }

  Future<models.Document> createEmployee(Map map) async {
    final response = databases!.createDocument(
        databaseId: AppwriteConstants.dbId,
        collectionId: AppwriteConstants.employeeCollectionId,
        documentId: ID.unique(),
        data: {
          "name": map["name"],
          "department": map["department"],
          "createdBy": map["name"],
          "image": map["image"],
          "createdAt": map["createdAt"],
        });
    return response;
  }

  Future<models.DocumentList> getEmployees() async {
    final response = databases!.listDocuments(
        databaseId: AppwriteConstants.dbId,
        collectionId: AppwriteConstants.employeeCollectionId);
    return response;
  }

  Future<models.Document> updateEmployee(Map map) async {
    final response = databases!.updateDocument(
        databaseId: AppwriteConstants.dbId,
        collectionId: AppwriteConstants.employeeCollectionId,
        documentId: map["documentId"],
        data: {
          "name": map["name"],
          "department": map["department"],
          "createdBy": map["createdBy"],
          "image": map["image"],
        });

    return response;
  }

  Future<dynamic> deleteEmployee(Map map) async {
    final response = databases!.deleteDocument(
      databaseId: AppwriteConstants.dbId,
      collectionId: AppwriteConstants.employeeCollectionId,
      documentId: map["documentId"],
    );
    return response;
  }
}
