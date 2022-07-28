import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/pages/dashboard/dashboard_controller.dart';

import '../../Constant.dart';
import '../../Model/CommentModel.dart';
import '../../Model/EtatDeclarationModel.dart';
import '../dashboard/dashboard_page.dart';
import '../home/widget/AllComplaintDtailes.dart';
import '../news/ComplaintModel.dart';
import 'ComplaintDtailes.dart';
import 'ComplaintListController.dart';

class ComplaintDetailesController extends GetxController{
var compaintID=0.obs;
var isloading=true.obs;
var acctuelComplaint=ComplaintModel(title: '', dateDecl: '', content: '', id: 0, adresse: '', categ: '').obs;
final GlobalKey<FormState> _declartionDetails = new GlobalObjectKey<FormState>(33);
final dashcontroller = Get.put(DashboardController());
final Listcontroller = Get.put(ListDeclarationController());
late TextEditingController descController,addressController,cateController,titreConroller,dateConroller;
GlobalKey<FormState> get declaration => _declartionDetails;
RxList<CommentModel> commentsList = List<CommentModel>.empty(growable: true).obs;
var comment=''.obs;
final seesion = GetStorage();



  @override
  void onInit() {
    super.onInit();
    descController = TextEditingController();
    addressController = TextEditingController();
    cateController = TextEditingController();
    titreConroller = TextEditingController();
    dateConroller = TextEditingController();
  }

  @override
  void onClose() {

  }

  @override
  void onReady() {
    super.onReady();


  }
Future<void> getCommentOfComplaint(int id) async {
  commentsList.clear();
  var res = await http.get(Uri.parse(Constant().baseUrl+"comment/"+id.toString()));
  print(res.body);
  if(res.statusCode==200){
    List jsonList=json.decode(res.body);
    if(jsonList.length!=0){
      jsonList.forEach((element) {
        commentsList.value.add(CommentModel.fromJson(element));
      });
    }
  }
}


Future<void> addCommentOfComplaint(String text) async {
    var email='';
  if(this.seesion.read("email")!=null){
   email =this.seesion.read("email");

  var res = await http.get(Uri.parse(Constant().baseUrl+"comment/newComment/"+this.compaintID.value.toString()+"/"+email+"/"+text));
  print(res.body);
  if(res.statusCode==200) {
    var comment =CommentModel();
    comment.comment=text;
    comment.user.prenom=this.seesion.read("firstname");
   this.commentsList.value.add(comment);
   update();
  }
  }
}




Future<void> getComplaintDetails(int id) async {this.compaintID.value=id;
  this.isloading.value = true;
  try {
    var res = await http.get(Uri.parse(Constant().baseUrl+"declaration/byid/"+this.compaintID.value.toString()));
    if (res.statusCode == 200) {
      this.acctuelComplaint.value = ComplaintModel.fromJson(json.decode(res.body));
      var res2 = await http.get(Uri.parse(
          Constant().baseUrl+"declaration/etat/" + this.acctuelComplaint.value.id.toString()));
      if (res2.statusCode == 200) {
        List jsonResponse2 = json.decode(res2.body);
        var etats = [];
        jsonResponse2.forEach((element) {
          etats.add(EtatDeclarationModel.fromJson(element));
        });
        etats.sort((b, a) {
          var a1 = a.dateEtat;
          var b1 = b.dateEtat;
          return a1.compareTo(b1);
        });
        this.acctuelComplaint.value.listEtat = etats;
        await getCommentOfComplaint(id);
        Get.to(()=>ComplaintDetails());
      } else {
        print(res2.statusCode);
      }
    } else {
      Get.snackbar("Error", "Eroor Fetch");
    }
  }
  finally {
    this.isloading.value = false;
  }
}

Future<void> getComplaintDetails1(int id) async {
  this.compaintID.value=id;
  this.isloading.value = true;
  try {
    var res = await http.get(Uri.parse(Constant().baseUrl+"declaration/byid/"+this.compaintID.value.toString()));
    if (res.statusCode == 200) {
      this.acctuelComplaint.value = ComplaintModel.fromJson(json.decode(res.body));
      var res2 = await http.get(Uri.parse(
          Constant().baseUrl+"declaration/etat/" + this.acctuelComplaint.value.id.toString()));
      if (res2.statusCode == 200) {
        List jsonResponse2 = json.decode(res2.body);
        var etats = [];
        jsonResponse2.forEach((element) {
          etats.add(EtatDeclarationModel.fromJson(element));
        });
        etats.sort((b, a) {
          var a1 = a.dateEtat;
          var b1 = b.dateEtat;
          return a1.compareTo(b1);
        });
        this.acctuelComplaint.value.listEtat = etats;
        await getCommentOfComplaint (id);
        Get.to(()=>AllComplaintDetails());
      } else {
        print(res2.statusCode);
      }
    } else {
      Get.snackbar("Error", "Eroor Fetch");
    }
  }
  finally {
    this.isloading.value = false;
  }
}


Future<void> delete() async {
   var   res= await http.delete(Uri.parse(Constant().baseUrl+"declaration/delete/"+this.acctuelComplaint.value.id.toString()));
    if(res.statusCode==200){

      print(res.body=="1");
      if(res.body== "1"){
        Get.snackbar("Supprimé avec succès", "check",colorText: Colors.white,backgroundColor: Colors.green);
        await Listcontroller.getAllDeclaration();
        dashcontroller.tabIndex.value=0;
        Get.to(()=>DashboardPage());
      }else{
        Get.snackbar("Error", "Erreur lors du processus de suppression",backgroundColor: Colors.red,colorText: Colors.white);

      }
      
    }else{
      Get.snackbar("Error", "Server Error",backgroundColor: Colors.red,colorText: Colors.white);
    }
}



void openDialog() {
  Get.dialog(

    AlertDialog(
      title: const Text('Dialog'),
      content: const Text('Êtes-vous sûr de vouloir supprimer l\'élément'),
      actions: [
        TextButton(
          child: const Text("supprimer"),
          onPressed: () async {
            await delete();
          },
        ),
        TextButton(
          child: const Text("annuler"),
          onPressed: () => Get.back(),
        ),
      ],
    ),
  );
}

}