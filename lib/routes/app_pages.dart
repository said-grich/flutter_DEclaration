import 'package:get/get.dart';
import 'package:untitled/pages/auth/Login_page.dart';
import 'package:untitled/pages/home/AllDeclaration.dart';
import 'package:untitled/pages/home/home_page.dart';
import '../pages/auth/Register_Page.dart';
import '../pages/complaintsWedgets/ComplaintDtailes.dart';
import '../pages/complaintsWedgets/complaint_page.dart';
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
    GetPage(
      name: AppRoutes.ListDeclaration,
      page: () => Declarations_Page(),
      binding: DashboardBinding(),
    ),  GetPage(
      name: AppRoutes.ComplaintDetails,
      page: () => ComplaintDetails(),
      binding: DashboardBinding(),
    ), GetPage(
      name: AppRoutes.Home,
      page: () => HomePage(),
      binding: DashboardBinding(),
    ),GetPage(
      name: AppRoutes.AllDEclaration,
      page: () => AllDeclarations(),
      binding: DashboardBinding(),
    ),
  ];
}
