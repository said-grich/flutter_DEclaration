import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../complaintsWedgets/complaint_page.dart';
import '../home/home_page.dart';
import '../news/complaint_page.dart';
import '../profile/profile_page.dart';
import 'dashboard_controller.dart';

class DashboardPage extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
        return Scaffold(
          body: SafeArea(
            child:Obx((){
             return IndexedStack(
                index: controller.tabIndex.value,
                children: [
                  HomePage(),
                  ComplaintPage(),
                  Declarations_Page(),
                  AccountPage(),
                ],
              );
            })
          ),
          bottomNavigationBar:Obx(()=>BottomNavigationBar(
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.redAccent,
            onTap: controller.changeTabIndex,
            currentIndex: controller.tabIndex.value,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
            items: [
              _bottomNavigationBarItem(
                icon: CupertinoIcons.home,
                label: 'Home',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.pen,
                label: 'Ajouter',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.square_list,
                label: 'déclarations',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.person,
                label: 'Profile',
              ),
            ],
          ),)
        );
  }

  _bottomNavigationBarItem({required IconData icon, required String label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
