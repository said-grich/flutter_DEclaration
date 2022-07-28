import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled/pages/home/home_page.dart';

import '../../Constant.dart';
import '../complaintsWedgets/ComplaintListController.dart';
import '../dashboard/dashboard_page.dart';
import '../news/ComplaintModel.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Constant.dart';
import 'package:untitled/Model/EtatDeclarationModel.dart';
import 'dart:convert';

import 'AllDeclarationController.dart';

class HomeController extends GetxController {
  final seesion = GetStorage();
  final allDeclarationController = Get.put(AllDeclarationController());
  final listDeclarationController = Get.put(ListDeclarationController());
  RxList<ComplaintModel> carouselItemList = List<ComplaintModel>.empty(growable: true).obs;
    int i=0;
  var attend=0.obs;
  var enCours=0.obs;
  var traite=0.obs;
  RxBool isLoading = false.obs;
  var tabIndex = 0.obs;
  var isLogin=true;
  var isDataLoading= true.obs;
  var userID=0;
  var declarationList=List<ComplaintModel>.empty().obs;


  void onInit() {

    super.onInit();
    getAllDeclaration();

  }

  @override
  void onClose() {

  }

  @override
  Future<void> onReady() async {
    getVousDec();
      if(declarationList.value.isNotEmpty){
      declarationList.value.forEach((element) {
        if(element.listEtat![0].etat.libelle=="en attente"){
          this.attend.value+=1;
        }else if(element.listEtat![0].etat.libelle=="en attente"){
          this.enCours.value+=30;
        }
        else{
          this.traite.value+=40;
        }
      });
    }


  }
  Future<void> getAllDeclaration() async {
    this.carouselItemList.value.clear();
    this.isDataLoading.value=true;
    try {var res= await http.get( Uri.parse(Constant().baseUrl+"declaration/"));
    if((res.statusCode==200)){
      List jsonResponse = json.decode(res.body);
      jsonResponse.forEach((element) async {
        var tmp =ComplaintModel.fromJson(element);
        var res2= await http.get( Uri.parse(Constant().baseUrl+"declaration/etat/"+tmp.id.toString()));
        if(res2.statusCode==200){
          List jsonResponse2 = json.decode(res2.body);
          var etats=[];
          jsonResponse2.forEach((element) {etats.add(EtatDeclarationModel.fromJson(element)); });
          etats.sort((b,a) {
            var a1=a.dateEtat;
            var b1=b.dateEtat;
            return a1.compareTo(b1);
          });

          tmp.listEtat=etats;
          this.carouselItemList.value.add(tmp);
        }else{
          print(res2.statusCode);
        }
      });
    }else{
      Get.snackbar("Error", "Eroor Fetch");
    }
    }
    finally{
      this.isDataLoading.value=false;
    }
      Get.to(DashboardPage());

  }


  Future<void> getVousDec() async {

    if(seesion.read("userID")!=null){
      this.userID=seesion.read("userID");
    }
    this.declarationList.clear();
    try {
      var res= await http.get( Uri.parse(Constant().baseUrl+"declaration/userdec/"+this.userID.toString()));
      if((res.statusCode==200)){
        List jsonResponse = json.decode(res.body);
        jsonResponse.forEach((element) async {
          var tmp =ComplaintModel.fromJson(element);
          var res2= await http.get( Uri.parse(Constant().baseUrl+"declaration/etat/"+tmp.id.toString()));
          if(res2.statusCode==200){
            List jsonResponse2 = json.decode(res2.body);
            var etats=[];
            jsonResponse2.forEach((element) {etats.add(EtatDeclarationModel.fromJson(element)); });
            etats.sort((b,a) {
              var a1=a.dateEtat;
              var b1=b.dateEtat;
              return a1.compareTo(b1);
            });
            tmp.listEtat=etats;
          }else{
            print(res2.statusCode);
          }
          this.declarationList.value.add(tmp);
        });
      }else{
        Get.snackbar("Error", "Eroor Fetch");
      }
    }
    finally{
      isDataLoading.value = true;
        enCours.value = 0;
        attend.value = 0;
        traite.value = 0;
    if(declarationList.value.length!=0){
        declarationList.value.forEach((element) {
          if (element.listEtat![0].etat.libelle == "en attente") {
            attend.value += 1;
          } else
          if (element.listEtat![0].etat.libelle == "en cours de traitement") {
            enCours.value += 1;
          } else {
            traite.value += 1;
          }
        }


        );
      }
        print("----------------------------------------------------->" + attend.value.toString());
// Prints after 1 second.
      isDataLoading.value = false;

    }
  }


}
