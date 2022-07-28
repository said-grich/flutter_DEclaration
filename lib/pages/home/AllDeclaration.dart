import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/pages/home/widget/card.dart';

import '../complaintsWedgets/ComplaintDtailesController.dart';
import 'AllDeclarationController.dart';



class AllDeclarations extends StatefulWidget {
  @override
  State<AllDeclarations> createState() => _AllDeclarationsState();
}

class _AllDeclarationsState extends State<AllDeclarations> {
  ComplaintDetailesController detailController= Get.find();
  final controller = Get.put(AllDeclarationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle:true,title: Text("Declarations",style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),), backgroundColor: Colors.white, elevation: 0.0,),
        body: Obx(() {
          if(controller.isDataLoading.value){
            return Center(child: CircularProgressIndicator());
          }else{
            return ListView.builder(
              itemCount: controller.declarationList.value.length,
              itemBuilder: (BuildContext context, int index) {
                print(controller.declarationList.value[index].dateDecl);

                return AllComplaintCard(
                    complaint: controller.declarationList.value[index],
                    onCardClick: () {
                      detailController.getComplaintDetails1(controller.declarationList.value[index].id);
                    }
                );
              },
            );
          }

        })
    );
  }
}
