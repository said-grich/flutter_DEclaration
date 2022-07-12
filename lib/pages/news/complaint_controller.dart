import 'package:get/get.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled/pages/auth/Login_page.dart';

import '../../Model/UserModel.dart';
import 'package:http/http.dart' as http;

import '../dashboard/dashboard_page.dart';

class ComplaintController extends GetxController {
  GlobalKey<FormState> profileFormKey = GlobalObjectKey<FormState>(3);
  late TextEditingController emailController, passwordController,firstnameController,lastnameController,phoneController,immController;
  final seesion = GetStorage();

  @override
  void onInit() async{
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    firstnameController = TextEditingController();
    lastnameController = TextEditingController();
    phoneController = TextEditingController();
    immController = TextEditingController();
    await this.readFromLocalStorege();

  }
  Future<void> readFromLocalStorege() async {
    var islogin= seesion.read("isLogin");
    this.emailController.text= seesion.read("email");
    this.lastnameController.text=seesion.read("name");
    this.firstnameController.text=seesion.read("firstname");
    this.immController.text=seesion.read("cin");
    this.phoneController.text=seesion.read("phone");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Fournir un e-mail valide";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 6) {
      return "Le mot de passe doit comporter 6 caractères";
    }
    return null;
  }
  String? valid_phone(String value) {
    var matcher =RegExp(r'^(?:(?:(?:\+|00)212[\s]?(?:[\s]?\(0\)[\s]?)?)|0){1}(?:5[\s.-]?[2-3]|6[\s.-]?[13-9]){1}[0-9]{1}(?:[\s.-]?\d{2}){3}$').hasMatch(value);

    if (value.length < 10) {
      return "numéro de téléphone invalide";
    }
    if(matcher==false){
      return "numéro de téléphone invalide";
    }
    return null;
  }
  String? validName(String value) {
    if (value.length < 2) {
      return "entrez un nom valide";
    }
    var matcher =RegExp(r"/^[a-z ,.'-]+\$/i").hasMatch(value);
    if(matcher==false){
      return "entrez un nom valide";
    }


    return null;
  }

  void checkLogin() {
    final isValid = profileFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    profileFormKey.currentState!.save();
  }

  Future<void> logout() async {
    await seesion.erase();
    Future.delayed(Duration.zero, () {
      Get.to(Login_page());
    });
    seesion.write("isLogin", false);
  }


}
