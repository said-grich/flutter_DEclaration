import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/pages/dashboard/dashboard_controller.dart';

import '../../../Constant.dart';
import '../../../Model/CommentModel.dart';
import '../../../Model/EtatDeclarationModel.dart';
import '../../complaintsWedgets/ComplaintDtailes.dart';
import '../../complaintsWedgets/ComplaintListController.dart';
import '../../dashboard/dashboard_page.dart';
import '../../news/ComplaintModel.dart';


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

  var res = await http.get(Uri.parse(Constant().baseUrl+"declaration/byid/"+id.toString()));
  print(res.body);
  if(res.statusCode==200){
    List jsonList=json.decode(res.body);
    jsonList.forEach((element) {
      commentsList.value.add(CommentModel.fromJson(element));
    });
    print("---------33----------------33----------->"+commentsList.value.length.toString());
  }
}




  Future<void> getComplaintDetails(int id) async {
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

}