import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../auth/Login_page.dart';

class DashboardController extends GetxController {
  var tabIndex = 0;
  var isLogin=true;
  final seesion = GetStorage();

  void onInit() {
    super.onInit();

  }
  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }
}
