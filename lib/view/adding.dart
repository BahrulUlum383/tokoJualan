import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lastest_broo/controllers/profile_controler.dart';

class Adding extends StatefulWidget {
  Adding({Key? key}) : super(key: key);

  @override
  _AddingState createState() => _AddingState();
}

class _AddingState extends State<Adding> {
  final ImagePickerController controller = Get.put(ImagePickerController());
  int currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 214, 210, 210),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(() {
              return ClipRRect(
                borderRadius: BorderRadius.circular(135),
                child: Container(
                  width: 250,
                  height: 250,
                  color: Colors.grey,
                  child: controller.selectedImage.value != null
                      ? Image.file(controller.selectedImage.value!,
                          fit: BoxFit.cover)
                      : Image.asset('assets/images/logo_petstoree.png',
                          fit: BoxFit.cover),
                ),
              );
            }),
            SizedBox(height: 200),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(94, 167, 88, 24),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () => controller.pickImageFromCamera(),
                      child: Text(
                        'Pick from Camera',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(94, 167, 88, 24),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () => controller.pickImageFromGallery(),
                    child: Text(
                      'Pick from Gallery',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
