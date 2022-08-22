import 'package:get/get.dart';
import 'package:untitled/pages/home/AllDeclaration.dart';
import 'package:untitled/pages/home/home_page.dart';
import '../pages/auth/Login_page.dart';
import '../pages/auth/Register_Page.dart';
import '../pages/complaintsWedgets/ComplaintDtailes.dart';
import '../pages/complaintsWedgets/complaint_page.dart';
import '../pages/dashboard/dashboard_binding.dart';
import '../pages/dashboard/dashboard_page.dart';
import '../pages/news/complaint_page.dart';
import 'app_routes.dart';

class AppPages {
  static List<GetPage> list = [
    GetPage(
      name: AppRoutes.dashboard,
      page: () => DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.loginPage,
      page: () => LoginPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.registerPage,
      page: () => const RegisterPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.addPage,
      page: () => ComplaintPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.listDeclaration,
      page: () => DeclarationsPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.complaintDetails,
      page: () => const ComplaintDetails(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.allDeclaration,
      page: () => AllDeclarations(),
      binding: DashboardBinding(),
    ),
  ];
}
