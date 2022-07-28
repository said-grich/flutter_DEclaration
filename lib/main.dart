import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'themes/app_theme.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final seesion = GetStorage();
  var islogin=false;
  @override
  Widget build(BuildContext context) {
    seesion.read("isLogin") ==null?islogin=false:islogin=seesion.read("isLogin");
    print("==================================================================>"+seesion.read("isLogin").toString());
    return GetMaterialApp(
      initialRoute:islogin?AppRoutes.DASHBOARD:AppRoutes.LoginPage,
      getPages: AppPages.list,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
    );
  }
}
