import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/pages/home/AllDeclaration.dart';
import 'package:untitled/pages/home/widget/CarouselLoading.dart';
import 'package:untitled/pages/home/widget/CarouselWithIndicator.dart';
import 'package:untitled/pages/home/widget/DashCard.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(child: Obx(
            () {
          if (controller.isLoading.value) {
            return const Center(
              child: CarouselLoading(),
            );
          } else {
            if (controller.carouselItemList.isNotEmpty) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Bienvenue à Ajiw",
                      style: GoogleFonts.poppins(fontSize: 18, color: Colors.black87 ,fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CarouselWithIndicator(
                        data: controller.carouselItemList),
                       controller.isDataLoading.value?Column(children: [
                         SizedBox(height: 50,),
                         Center(child: CarouselLoading())
                       ],):
                       Column(
                         children: [
                           GestureDetector(
                             onTap: () {
                               Get.to(()=>AllDeclarations());
                             },
                             child: Container(
                                 margin: EdgeInsets.all(10),
                                 height: 70,
                                 child: Stack(
                                   alignment: Alignment.center,
                                   children: [
                                     Positioned(
                                       bottom: 0,
                                       left: 0,
                                       right: 0,
                                       child: Container(
                                           height: 70,
                                           decoration: BoxDecoration(
                                               borderRadius: BorderRadius.circular(10),
                                               color: Colors.blueGrey
                                           )),
                                     ),
                                     Positioned(
                                       top: 0,
                                       left: 0,
                                       right: 0,
                                       bottom: 0,
                                       child: Padding(
                                         padding: const EdgeInsets.symmetric(horizontal: 40),
                                         child: Row(
                                           children: [
                                             Center(
                                               child: Text("Explorer autres Déclarations",
                                                   style:GoogleFonts.poppins(fontSize: 15, color: Colors.white ,fontWeight: FontWeight.bold)),
                                             ),
                                           ],
                                         ),
                                       ),
                                     ),

                                   ],
                                 )),
                           ),

                           DashCard(title: "en attente", nomber: this.controller.attend.value),
                           DashCard(title: "en cours de traitement", nomber: this.controller.enCours.value),
                           DashCard(title: "traite", nomber: this.controller.traite.value),
                         ],
                       ),

                  ],
                ),
              );
            } else {
              return  Center(child: CircularProgressIndicator());
            }
          }
        },
      )),
    );
  }
}
