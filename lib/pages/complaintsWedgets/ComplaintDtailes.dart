import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Constant.dart';
import 'ComplaintDtailesController.dart';



class ComplaintDetails extends StatefulWidget {
  const ComplaintDetails({Key? key}) : super(key: key);

  @override
  State<ComplaintDetails> createState() => _ComplaintDetailsState();
}

class _ComplaintDetailsState extends State<ComplaintDetails> {
  final controller = Get.put(ComplaintDetailesController());
  final constant =new Constant();
  @override
  Widget build(BuildContext context) {
    print("=================>     "+controller.acctuelComplaint.value.adresse);
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
    return Scaffold(
      appBar: AppBar(title:Text(
        this.controller.acctuelComplaint.value.title,
        style: GoogleFonts.poppins(fontSize: 18 ,color: Colors.black,fontWeight: FontWeight.bold),
      ),elevation: 0,centerTitle: true,automaticallyImplyLeading: false,backgroundColor: Colors.white,),
      body:Container(
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
                    height: 10,
                  ),


                  SizedBox(
                    height: 16,
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
                        MaterialStateProperty.all(Color(0xFFB1EA37)),
                        padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                      ),
                      child: Text(
                        "Mise a joure",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      onPressed: () {
                        print("update");
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16,
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
                        MaterialStateProperty.all(Colors.red),
                        padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                      ),
                      child: Text(
                        "supprimer",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      onPressed: () {
                        this.controller.openDialog();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),

                ],
              ),
            ),
          ),
        ),
      );

  }
}
