import 'package:get/get.dart';
import 'package:untitled/pages/auth/Login_page.dart';


import '../pages/auth/Register_Page.dart';
import '../pages/dashboard/dashboard_binding.dart';
import '../pages/dashboard/dashboard_page.dart';
import '../pages/news/complaint_page.dart';
import 'app_routes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.DASHBOARD,
      page: () => DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.LoginPage,
      page: () => Login_page(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.RegisterPage,
      page: () => Register_Page(),
      binding: DashboardBinding(),
    ), GetPage(
      name: AppRoutes.AddPage,
      page: () => ComplaintPage(),
      binding: DashboardBinding(),
    ),
  ];
}
