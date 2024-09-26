import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lastest_broo/models/Employee.dart';
import 'package:lastest_broo/utils/auth_repository.dart';

import '../utils/apwrite_constant.dart';

class EmployeeController extends GetxController
    with StateMixin<List<Employee>> {
  AuthRepository authRepository;
  EmployeeController(this.authRepository);

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController nameEditingController = TextEditingController();
  TextEditingController departmentEditingController = TextEditingController();

  bool isFormValid = false;

  final GetStorage _getStorage = GetStorage();
  late List<Employee> employeeList = [];

  var imagePath = ''.obs;
  final ImagePicker _picker = ImagePicker();

  late String uploadedFileId;

  var isEdit = false.obs;
  var imageUrl = ''.obs;
  late Employee employee;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    getEmployee();
    if (Get.arguments != null) {
      employee = Get.arguments;
      nameEditingController.text = employee.name;
      departmentEditingController.text = employee.department;
      imageUrl.value =
          '${AppwriteConstants.endPoint}/storage/buckets/${AppwriteConstants.employeeBucketId}/files/${employee.image}/view?project=${AppwriteConstants.projectId}';
    }
  }

  @override
  void onClose() {
    super.onClose();
    nameEditingController.dispose();
    departmentEditingController.dispose();
  }

  void clearTextEditingControllers() {
    nameEditingController.clear();
    departmentEditingController.clear();
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return "provide valid name";
    }
    return null;
  }

  String? validateDepartment(String value) {
    if (value.isEmpty) {
      return "provide valid department";
    }
    return null;
  }

  void selectImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath.value = image.path;
    } else {
      Get.snackbar(
        "Error",
        "Image selection cancelled",
        backgroundColor: Colors.red,
      );
    }
  }

  void validateAndSave(
      {required String name,
      required String department,
      required isEdit}) async {
    isFormValid = formkey.currentState!.validate();
    if (!isFormValid) {
      return;
    } else {
      formkey.currentState!.save();
      if (!isEdit) {
        if (imagePath.isNotEmpty) {
          try {
            await authRepository
                .uploadEmployeeImage(imagePath.value)
                .then((value) async {
              uploadedFileId = value.$id;

              await authRepository.createEmployee({
                "name": name,
                "department": department,
                "createdBy": department,
                "image": uploadedFileId,
                "createdAt": DateTime.now().toIso8601String(),
              }).then((value) {
                Get.snackbar(
                  'Success',
                  'data saved',
                  backgroundColor: Colors.green,
                );
              }).catchError((error) async {
                if (error is AppwriteException) {
                  Get.snackbar(
                    'Error',
                    'message : $error',
                    backgroundColor: Colors.red,
                  );
                } else {
                  Get.snackbar(
                    'Error',
                    'something went wrong',
                    backgroundColor: Colors.red,
                  );
                }

                await authRepository.deleteEmployeeImage(uploadedFileId);
              });
            }).catchError((error) {
              if (error is AppwriteException) {
                Get.snackbar(
                  'Error',
                  'message: $error',
                  backgroundColor: Colors.red,
                );
              } else {
                Get.snackbar(
                  'Error',
                  'something went wrong',
                  backgroundColor: Colors.red,
                );
              }
            });
          } catch (error) {
            print('Error: $error');
            Get.snackbar(
              'Error',
              'Something went wrong: $error',
              backgroundColor: Colors.red,
            );
          }
        } else {
          Get.snackbar(
            "Error",
            "Please Select Image",
            backgroundColor: Colors.red,
          );
        }
      } else {
        if (imagePath.isNotEmpty) {
          try {
            await authRepository
                .uploadEmployeeImage(imagePath.value)
                .then((value) async {
              uploadedFileId = value.$id;
              await authRepository.deleteEmployeeImage(employee.image);
              await authRepository.updateEmployee({
                "name": name,
                "department": department,
                "createdBy": _getStorage.read("user_token"),
                "image": uploadedFileId,
                "documentId": employee.documentId,
              }).then((value) {
                Get.snackbar(
                  'Success',
                  'data saved',
                  backgroundColor: Colors.green,
                );
                Get.offAllNamed('/addE');
              }).catchError((error) async {
                if (error is AppwriteException) {
                  Get.snackbar(
                    'Error',
                    'message : $error',
                    backgroundColor: Colors.red,
                  );
                } else {
                  Get.snackbar(
                    'Error',
                    'something went wrong',
                    backgroundColor: Colors.red,
                  );
                }

                await authRepository.deleteEmployeeImage(uploadedFileId);
              });
            }).catchError((error) {
              if (error is AppwriteException) {
                Get.snackbar(
                  'Error',
                  'message: $error',
                  backgroundColor: Colors.red,
                );
              } else {
                Get.snackbar(
                  'Error',
                  'something went wrong',
                  backgroundColor: Colors.red,
                );
              }
            });
          } catch (error) {
            print('Error: $error');
            Get.snackbar(
              'Error',
              'Something went wrong: $error',
              backgroundColor: Colors.red,
            );
          }
        } else {
          Get.snackbar(
            "Error",
            "Please Select Image",
            backgroundColor: Colors.red,
          );
        }
      }
    }
  }

  getEmployee() async {
    try {
      change(null, status: RxStatus.loading());
      await authRepository.getEmployees().then((value) {
        Map<String, dynamic> data = value.toMap();
        List d = data['documents'].toList();
        employeeList = d
            .map(
              (e) => Employee.fromMap(e['data']),
            )
            .toList();
        change(employeeList, status: RxStatus.success());
      }).catchError((error) {
        if (error is AppwriteException) {
          change(null, status: RxStatus.error(error.response['message']));
        } else {
          change(null, status: RxStatus.error("Something went wrong"));
        }
      });
    } catch (e) {
      change(null, status: RxStatus.error("Something went wrong"));
    }
  }

  moveToEditEmployee(Employee employee) {
    Get.toNamed('/addE', arguments: employee);
  }

  deleteEmployee(Employee employee) async {
    try {
      await authRepository.deleteEmployee({
        "documentId": employee.documentId,
      }).then((value) async {
        await authRepository.deleteEmployeeImage(employee.image);
        Get.snackbar(
          "Success",
          "Employee deleted",
          backgroundColor: Colors.green,
        );
        Get.offAllNamed('/addE');
      }).catchError((error) async {
        if (error is AppwriteException) {
          Get.snackbar(
            "Error",
            "$error.response['message]",
            backgroundColor: Colors.red,
          );
        } else {
          Get.snackbar(
            "Error",
            "Something went wrongg",
            backgroundColor: Colors.red,
          );
        }
      });
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wronggg",
        backgroundColor: Colors.red,
      );
    }
  }
}
