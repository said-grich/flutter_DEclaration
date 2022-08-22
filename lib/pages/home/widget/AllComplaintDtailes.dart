import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/Constant.dart';
import 'package:untitled/Model/CommentModel.dart';

import '../../complaintsWedgets/ComplaintDtailesController.dart';

class AllComplaintDetails extends StatefulWidget {
  const AllComplaintDetails({Key? key}) : super(key: key);

  @override
  State<AllComplaintDetails> createState() => _AllComplaintDetailsState();
}

class _AllComplaintDetailsState extends State<AllComplaintDetails> {
  final controller = Get.put(ComplaintDetailesController());
  final formKey = GlobalKey<FormState>();
  final constant = new Constant();
  final TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    controller.dateConroller.text = controller.acctuelComplaint.value.dateDecl;

    controller.descController.text = controller.acctuelComplaint.value.content;

    controller.addressController.text =
        controller.acctuelComplaint.value.adresse;

    controller.addressController.text = "null";

    controller.cateController.text = controller.acctuelComplaint.value.categ;

    controller.titreConroller.text = controller.acctuelComplaint.value.title;

    var libelle = controller.acctuelComplaint.value.listEtat![0].etat.libelle;
    MaterialAccentColor color;
    if (libelle == "en attente") {
      color = Colors.redAccent;
    } else if (libelle == "en cours de traitement") {
      color = Colors.amberAccent;
    } else {
      color = Colors.greenAccent;
    }
    Widget commentChild(List<CommentModel> data) {
      return ListView(
        children: [
          for (int i = 0; i < data.length; i++)
            Padding(
              padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
              child: ListTile(
                leading: GestureDetector(
                  onTap: () async {
   
                  },
                ),
                title: Text(
                  data[i].user.prenom,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(data[i].comment),
              ),
            )
        ],
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            controller.acctuelComplaint.value.title,
            style: GoogleFonts.poppins(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
        ),
        body: Obx(
          () => Container(
            margin: const EdgeInsets.only(top: 10, left: 16, right: 16),
            width: context.width,
            height: context.height,
            child: SingleChildScrollView(
              child: Form(
                key: const GlobalObjectKey<FormState>(33),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(constant.baseUrl2 +
                            controller.acctuelComplaint.value.photoUri)),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(width: context.width),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(color),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(14)),
                        ),
                        child: Text(
                            controller.acctuelComplaint.value.listEtat![0].etat
                                .libelle,
                            style: GoogleFonts.roboto(
                                fontSize: 15, color: Colors.white)),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Date",
                          prefixIcon: const Icon(Icons.date_range),
                        ),
                        keyboardType: TextInputType.multiline,
                        controller: controller.dateConroller,
                        enabled: false, //Not clickable and not editable
                        readOnly: true),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Titre",
                        prefixIcon: const Icon(Icons.title),
                      ),
                      keyboardType: TextInputType.multiline,
                      controller: controller.titreConroller,
                      textInputAction: TextInputAction.newline,
                      enabled: false, //Not clickable and not editable
                      readOnly: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Description",
                          prefixIcon: const Icon(Icons.comment),
                        ),
                        keyboardType: TextInputType.multiline,
                        controller: controller.descController,
                        minLines: 1,
                        maxLines: 5,
                        textInputAction: TextInputAction.newline,
                        enabled: false, //Not clickable and not editable
                        readOnly: true),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Address",
                          prefixIcon: const Icon(Icons.maps_home_work),
                        ),
                        keyboardType: TextInputType.multiline,
                        controller: controller.addressController,
                        enabled: false, //Not clickable and not editable
                        readOnly: true),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Categorie",
                        prefixIcon: const Icon(Icons.category),
                      ),
                      keyboardType: TextInputType.multiline,
                      controller: controller.cateController,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        labelText: "Ajouter une commentaire",
                        prefixIcon: const Icon(Icons.comment_bank),
                      ),
                      keyboardType: TextInputType.multiline,
                      controller: commentController,
                      minLines: 1,
                      maxLines: 5,
                      textInputAction: TextInputAction.newline,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(width: context.width),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(14)),
                        ),
                        child: const Text(
                          "Commenter",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        onPressed: () {
                          controller
                              .addCommentOfComplaint(commentController.text);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Column(
                      children: controller.commentsList.map((item) {
                        return GestureDetector(
                          onTap: () {
                          },
                          child: Container(
                              margin: const EdgeInsets.all(10),
                              height: 120,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                        height: 120,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.indigo)),
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 8),
                                      child: Row(
                                        children: [
                                          Center(
                                            child: Text(item.user.nom,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 40,
                                    left: 10,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 8),
                                      child: Row(
                                        children: [
                                          Center(
                                            child: Text(item.comment,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
