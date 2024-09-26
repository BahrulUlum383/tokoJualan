import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lastest_broo/controllers/auth_controller.dart';
// import 'package:lastest_broo/controllers/employee_controller.dart';
import 'package:lastest_broo/controllers/notification_handler.dart';
import 'package:lastest_broo/employee/create_employee_binding.dart';
import 'package:lastest_broo/firebase_options.dart';
import 'package:lastest_broo/view/addEmployee_page.dart';
import 'package:lastest_broo/view/adding.dart';
import 'package:lastest_broo/view/employee.dart';
import 'package:lastest_broo/view/home.dart';
import 'package:lastest_broo/view/dashboard.dart';
import 'package:lastest_broo/view/login_page.dart';
import 'package:lastest_broo/view/logindreg_page.dart';
import 'package:lastest_broo/view/route.dart';
import 'package:lastest_broo/view/sell.dart';
import 'package:lastest_broo/view/web/webview.dart';
import 'package:lastest_broo/view/register_page.dart';
import 'package:lastest_broo/view/user_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/appwireAuth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Get.putAsync(() async => await SharedPreferences.getInstance());
  await FirebaseMessagingHandler().initPushNotification();
  await FirebaseMessagingHandler().initLocalNotification();
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AuthControllerA _authController = Get.put(AuthControllerA());

  @override
  Widget build(BuildContext context) {
    // Get.put(EmployeeController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        scaffoldBackgroundColor: const Color(0xffF5F3EF),
      ),
      initialRoute: _authController.isLoggedIn.value ? '/route' : '/user',
      initialBinding: CreateEmployeeBinding(),
      getPages: [
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/dashboard', page: () => Dashboard()),
        GetPage(name: '/adding', page: () => Adding()),
        GetPage(name: '/sell', page: () => SellPage()),
        GetPage(name: '/employee', page: () => EmployeePage()),
        GetPage(name: '/webViewPage', page: () => WebviewPage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/user', page: () => UserPage()),
        GetPage(name: '/logind', page: () => LoginDRegPage()),
        GetPage(name: '/addE', page: () => AddEmployee()),
        GetPage(name: '/route', page: () => RoutePage()),
      ],
    );
  }
}
