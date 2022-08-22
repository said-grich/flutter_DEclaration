import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'themes/app_theme.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const  MyApp({Key? key}) : super(key: key);
   static final isLogin = GetStorage().read("isLogin") ?? false;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: isLogin ? AppRoutes.dashboard : AppRoutes.loginPage,
      getPages: AppPages.list,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
    );
  }
}
