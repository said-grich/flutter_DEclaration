import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ComplaintDtailesController.dart';
import 'ComplaintListController.dart';
import 'declarationCard.dart';

class DeclarationsPage extends GetView<ListDeclarationController> {
  DeclarationsPage({Key? key}) : super(key: key);
  final ComplaintDetailesController detailController =
      Get.find<ComplaintDetailesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Votre Declarations",
          style: GoogleFonts.poppins(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Obx(
        () {
          if (controller.isDataLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return controller.declarationList.isEmpty
                ? const Center(
                    child: Text("Empty"),
                  )
                : ListView.builder(
                    itemCount: controller.declarationList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ComplaintCard(
                        complaint: controller.declarationList[index],
                        onCardClick: () {
                          detailController.getComplaintDetails(
                            controller.declarationList[index].id,
                          );
                        },
                      );
                    },
                  );
          }
        },
      ),
    );
  }
}
