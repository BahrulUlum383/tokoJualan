import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lastest_broo/controllers/employee_controller.dart';

class AddEmployee extends GetView<EmployeeController> {
  AddEmployee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Employee'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formkey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "name",
                  ),
                  keyboardType: TextInputType.text,
                  controller: controller.nameEditingController,
                  validator: (value) {
                    return controller.validateName(value!);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Department",
                  ),
                  keyboardType: TextInputType.text,
                  controller: controller.departmentEditingController,
                  validator: (value) {
                    return controller.validateDepartment(value!);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() => !controller.isEdit.value
                        ? (controller.imagePath.value == ''
                            ? const Text(
                                'select image from galerry',
                                style: TextStyle(fontSize: 20),
                              )
                            : CircleAvatar(
                                radius: 80,
                                backgroundImage:
                                    FileImage(File(controller.imagePath.value)),
                              ))
                        : (controller.imagePath.value != ''
                            ? CircleAvatar(
                                radius: 80,
                                backgroundImage:
                                    FileImage(File(controller.imagePath.value)),
                              )
                            : CachedNetworkImage(
                                imageUrl: controller.imageUrl.value,
                                width: 100,
                                height: 100,
                              ))),
                    IconButton(
                        onPressed: () {
                          controller.selectImage();
                        },
                        icon: const Icon(Icons.image)),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: context.width),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(14)),
                      ),
                      child: const Text(
                        "create employee",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        controller.validateAndSave(
                            name: controller.nameEditingController.text,
                            department:
                                controller.departmentEditingController.text,
                            isEdit: controller.isEdit.value);
                      },
                    )),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
