import 'dart:convert';

import 'package:comment_box/comment/comment.dart';
import 'package:flutter/cupertino.dart';
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
  final constant=new Constant();
  final TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    controller.dateConroller.text=controller.acctuelComplaint.value.dateDecl;
    controller.descController.text=controller.acctuelComplaint.value.content;
    if(controller.acctuelComplaint.value.adresse!=null){
      controller.addressController.text=controller.acctuelComplaint.value.adresse;
    }else{
      controller.addressController.text="null";
    }
    if(controller.acctuelComplaint.value.categ!=null){
      controller.cateController.text=controller.acctuelComplaint.value.categ;
    }else{
      controller.cateController.text="null";
    }
    this.controller.titreConroller.text=controller.acctuelComplaint.value.title;

    var libelle=controller.acctuelComplaint.value.listEtat![0].etat.libelle;
    MaterialAccentColor color;
    if(libelle=="en attente"){
      color=Colors.redAccent;
    }else if(libelle=="en cours de traitement"){
      color=Colors.amberAccent;
    }else{
      color=Colors.greenAccent;
    }
    Widget commentChild(List<CommentModel> data) {
      return ListView(
        children: [
          for (var i = 0; i < data.length; i++)
            Padding(
              padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
              child: ListTile(
                leading: GestureDetector(
                  onTap: () async {
                    // Display the image in large form.
                    print("Comment Clicked");
                  },
                ),
                title: Text(
                  data[i].user.prenom,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(data[i].comment),
              ),
            )
        ],
      );
    }
    return Scaffold(
      appBar: AppBar(title:Text(
        this.controller.acctuelComplaint.value.title,
        style: GoogleFonts.poppins(fontSize: 18 ,color: Colors.black,fontWeight: FontWeight.bold),
      ),elevation: 0,centerTitle: true,automaticallyImplyLeading: false,backgroundColor: Colors.white,),
      body:  Obx(()=> Container(
          margin: EdgeInsets.only(top: 10, left: 16, right: 16),
          width: context.width,
          height: context.height,
          child: SingleChildScrollView(
            child: Form(
              key: new GlobalObjectKey<FormState>(33),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(20),child: Image.network(constant.baseUrl2+controller.acctuelComplaint.value.photoUri)),
                  SizedBox(
                    height: 15,
                  ),


                  SizedBox(
                    height: 15,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: context.width),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        backgroundColor:
                        MaterialStateProperty.all(color),
                        padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                      ),
                      child: Text(controller.acctuelComplaint.value.listEtat![0].etat.libelle,style: GoogleFonts.roboto(fontSize: 15, color: Colors.white)),
                      onPressed: () {
                      },
                    ),
                  ),

              SizedBox(
              height: 15,
            ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Date",
                      prefixIcon: Icon(Icons.date_range),
                    ),

                    keyboardType: TextInputType.multiline,
                    controller: controller.dateConroller,
                      enabled: false, //Not clickable and not editable
                      readOnly: true

                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Titre",
                      prefixIcon: Icon(Icons.title),
                    ),
                    keyboardType: TextInputType.multiline,
                    controller: controller.titreConroller,
                    textInputAction: TextInputAction.newline,
                      enabled: false, //Not clickable and not editable
                      readOnly: true,

                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Description",
                      prefixIcon: Icon(Icons.comment),
                    ),
                    keyboardType: TextInputType.multiline,
                    controller: controller.descController,
                    minLines: 1,
                    maxLines: 5,
                    textInputAction: TextInputAction.newline,
                      enabled: false, //Not clickable and not editable
                      readOnly: true

                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Address",
                      prefixIcon: Icon(Icons.maps_home_work),
                    ),
                    keyboardType: TextInputType.multiline,
                    controller: controller.addressController,
                      enabled: false, //Not clickable and not editable
                      readOnly: true
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Categorie",
                      prefixIcon: Icon(Icons.category),
                    ),
                    keyboardType: TextInputType.multiline,
                    controller: controller.cateController,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextField(
                      decoration: InputDecoration(

                        border: OutlineInputBorder(

                          borderRadius: BorderRadius.circular(5),
                        ),
                        labelText: "Ajouter une commentaire",
                        prefixIcon: Icon(Icons.comment_bank),
                      ),
                      keyboardType: TextInputType.multiline,
                      controller: commentController,
                      minLines: 1,
                      maxLines: 5,
                      textInputAction: TextInputAction.newline,
                  ),
                  SizedBox(height: 20,),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: context.width),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        backgroundColor:
                        MaterialStateProperty.all(Colors.blue),
                        padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                      ),
                      child: Text(
                        "Commenter",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      onPressed: () {
                       controller.addCommentOfComplaint(commentController.text);
                      },
                    ),
                  ),
                  SizedBox(height: 40,),
                  Column(
                    children: controller.commentsList.value.map((item) {
                      return
                        GestureDetector(
                          onTap: () {
                            print("tets");
                          },
                          child: Container(
                              margin: EdgeInsets.all(10),
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
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.indigo
                                        )),
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                                      child: Row(
                                        children: [
                                          Center(
                                            child: Text(item.user.nom,
                                                style:GoogleFonts.poppins(fontSize: 18, color: Colors.white ,fontWeight: FontWeight.bold)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 40,
                                    left: 10,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                                      child: Row(
                                        children: [
                                          Center(
                                            child: Text(item.comment,
                                                style:GoogleFonts.poppins(fontSize: 18, color: Colors.white ,fontWeight: FontWeight.bold)),
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
                  SizedBox(height: 20,),


    ],
              ),
            ),

          ),
        ),
      )

      );

  }
}
