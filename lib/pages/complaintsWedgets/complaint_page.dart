
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ComplaintDtailesController.dart';
import 'ComplaintListController.dart';
import 'declarationCard.dart';

class Declarations_Page extends GetView<ListDeclarationController> {
  ComplaintDetailesController detailController= Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle:true,title: Text("Votre Declarations",style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),), backgroundColor: Colors.white, elevation: 0.0,),
      body: Obx(() {
          if(controller.isDataLoading.value){
            return Center(child: CircularProgressIndicator());
          }else{
            return controller.declarationList.value.length==0?
            Center(child: Text("Empty"),):
              ListView.builder(
              itemCount: controller.declarationList.value.length,
              itemBuilder: (BuildContext context, int index) {

                return ComplaintCard(
                    complaint: controller.declarationList.value[index],
                    onCardClick: () {
                      detailController.getComplaintDetails(controller.declarationList.value[index].id);
                    }
                );
              },
            );
          }

      })
    );
  }
}
