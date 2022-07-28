import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled/pages/home/home_controller.dart';


import '../complaintsWedgets/ComplaintListController.dart';
import '../home/AllDeclarationController.dart';

class DashboardController extends GetxController {
  static DashboardController instance = Get.find();
  ListDeclarationController  listController= Get.find();
  HomeController  homeController=  Get.put(HomeController());
  final allDeclarationController = Get.put(AllDeclarationController());

  var tabIndex = 0.obs;
  var isLogin=true;
  final seesion = GetStorage();

  void onInit() {
    this.tabIndex.value=3;
    super.onInit();
  }


  @override
  void onReady() {
  }
  Future<void> changeTabIndex(int index) async {
    if(index==0){
      homeController.isDataLoading.value = true;
      await homeController.getVousDec();
      homeController.isDataLoading.value = false;
    }
    tabIndex.value = index;
    update();
  }


}
