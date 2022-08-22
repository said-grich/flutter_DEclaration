import 'dart:convert';

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

class ComplaintDetailesController extends GetxController {
  Rx<int> compaintID = 0.obs;
  Rx<bool> isloading = true.obs;
  Rx<ComplaintModel> acctuelComplaint = ComplaintModel(
          title: '', dateDecl: '', content: '', id: 0, adresse: '', categ: '')
      .obs;
  final GlobalKey<FormState> _declartionDetails =
      const GlobalObjectKey<FormState>(33);
  final dashcontroller = Get.put(DashboardController());
  final listcontroller = Get.put(ListDeclarationController());
  late TextEditingController descController,
      addressController,
      cateController,
      titreConroller,
      dateConroller;
  GlobalKey<FormState> get declaration => _declartionDetails;
  RxList<CommentModel> commentsList =
      List<CommentModel>.empty(growable: true).obs;
  var comment = ''.obs;
  final session = GetStorage();

  @override
  void onInit() {
    super.onInit();
    descController = TextEditingController();
    addressController = TextEditingController();
    cateController = TextEditingController();
    titreConroller = TextEditingController();
    dateConroller = TextEditingController();
  }

  Future<void> getCommentOfComplaint(int id) async {
    commentsList.clear();
    var res = await http.get(Uri.parse("${Constant().baseUrl}comment/$id"));
    if (res.statusCode == 200) {
      List jsonList = json.decode(res.body);
      if (jsonList.isNotEmpty) {
        jsonList.forEach(
          (element) => commentsList.add(
            CommentModel.fromJson(element),
          ),
        );
      }
    }
  }

  Future<void> addCommentOfComplaint(String text) async {
    late String email;
    if (session.read("email") != null) {
      email = session.read("email");

      var res = await http.get(Uri.parse(
          "${Constant().baseUrl}comment/newComment/${compaintID.value}/$email/$text"));

      if (res.statusCode == 200) {
        CommentModel comment = CommentModel();
        comment.comment = text;
        comment.user.prenom = session.read("FirstName");
        commentsList.add(comment);
        update();
      }
    }
  }

  Future<void> getComplaintDetails(int id) async {
    compaintID.value = id;
    isloading.value = true;
    try {
      var res = await http.get(Uri.parse(
          "${Constant().baseUrl}declaration/byid/${compaintID.value}"));
      if (res.statusCode == 200) {
        acctuelComplaint.value = ComplaintModel.fromJson(json.decode(res.body));
        var res2 = await http.get(Uri.parse(
            "${Constant().baseUrl}declaration/etat/${acctuelComplaint.value.id}"));
        if (res2.statusCode == 200) {
          List jsonResponse2 = json.decode(res2.body);
          List<EtatDeclarationModel> etats = [];
          jsonResponse2.forEach(
            (element) => etats.add(
              EtatDeclarationModel.fromJson(
                element,
              ),
            ),
          );

          etats.sort((b, a) {
            DateTime? a1 = a.dateEtat, b1 = b.dateEtat;
            return a1!.compareTo(b1!);
          });
          acctuelComplaint.value.listEtat = etats;
          await getCommentOfComplaint(id);
          Get.to(const ComplaintDetails());
        } else {}
      } else {
        Get.snackbar("Error", "Error Fetch");
      }
    } finally {
      isloading.value = false;
    }
  }

  Future<void> getComplaintDetails1(int id) async {
    compaintID.value = id;
    isloading.value = true;
    try {
      var res = await http.get(Uri.parse(
          "${Constant().baseUrl}declaration/byid/${compaintID.value}"));
      if (res.statusCode == 200) {
        acctuelComplaint.value = ComplaintModel.fromJson(json.decode(res.body));
        var res2 = await http.get(Uri.parse(
            "${Constant().baseUrl}declaration/etat/${acctuelComplaint.value.id}"));
        if (res2.statusCode == 200) {
          List jsonResponse2 = json.decode(res2.body);
          List etats = [];
          jsonResponse2.forEach(
            (element) => etats.add(
              EtatDeclarationModel.fromJson(element),
            ),
          );
          etats.sort(
            (b, a) {
              DateTime? a1 = a.dateEtat, b1 = b.dateEtat;
              return a1!.compareTo(b1!);
            },
          );
          acctuelComplaint.value.listEtat = etats;
          await getCommentOfComplaint(id);
          Get.to(const AllComplaintDetails());
        } else {
        }
      } else {
        Get.snackbar("Error", "Error Fetch");
      }
    } finally {
      isloading.value = false;
    }
  }

  Future<void> delete() async {
    var res = await http.delete(Uri.parse(
        "${Constant().baseUrl}declaration/delete/${acctuelComplaint.value.id}"));
    if (res.statusCode == 200) {
      if (res.body == "1") {
        Get.snackbar("Supprimé avec succès", "check",
            colorText: Colors.white, backgroundColor: Colors.green);
        await listcontroller.getAllDeclaration();
        dashcontroller.tabIndex.value = 0;
        Get.to(() => DashboardPage());
      } else {
        Get.snackbar("Error", "Erreur lors du processus de suppression",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } else {
      Get.snackbar("Error", "Server Error",
          backgroundColor: Colors.red, colorText: Colors.white);
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
