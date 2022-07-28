import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../Constant.dart';
import '../../Model/UserModel.dart';
import '../dashboard/dashboard_page.dart';


class RegisterController extends GetxController{
  late TextEditingController mailController, password2Controller,firstnameController,lastnameController,phoneController,immController;
  var email = '';
  var password = '';
  var firstname = '';
  var lastname = '';
  var phone = '';
  var imm = '';
   var isDataLoading = false.obs;
   final seesion = GetStorage();
   var isLogin=false;
   @override
  void onInit() {
    super.onInit();
    mailController = TextEditingController();
    password2Controller = TextEditingController();
    firstnameController = TextEditingController();
    lastnameController = TextEditingController();
    phoneController = TextEditingController();
    immController = TextEditingController();

  }

  @override
  void onReady() {
    super.onReady();

  }

  @override
  void onClose() {
    mailController.dispose();
    password2Controller.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    immController.dispose();
    phoneController.dispose();
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



    return null;
  }

   Future<void> checkSingup() async{
    // final isValid = RegisterFormKey.currentState!.validate();
    // if (!isValid) {
     await singup();
    // }
    // RegisterFormKey.currentState!.save();
  }
   Future<void> singup() async {
     try{
       isDataLoading(true);
       print(this.immController.text);
       var res= await http.post(
           Uri.parse(Constant().baseUrl+'auth/singup'),
           headers: <String, String>{
             'Content-Type': 'application/json; charset=UTF-8',
           },
           body: jsonEncode(<String, Object>{
             'email': this.mailController.text,
             'password': this.password2Controller.text,
             'nom':this.lastnameController.text,
             'prenom':this.firstnameController.text,
             'telephone':this.phoneController.text,
             'cin':this.immController.text,
             'role':1,
           }));
       print(res.statusCode);
       if (res.statusCode == 200) {
         if(res.body== "-1"){
           Get.snackbar("Error", "utilisateur existant",backgroundColor: Colors.redAccent,colorText: Colors.white);

         }
         else{
           var user =UserModel.fromJson(jsonDecode(res.body));
           Get.snackbar("Succes", "se connecter avec succes",backgroundColor: Colors.green,colorText: Colors.white);

           this.userToLocalStoreg(user);
           Get.to(() => DashboardPage());
         }

       } else {
         // If the server did not return a 200 OK response,
         // then throw an exception.
         Get.snackbar("Error", "Server Error",backgroundColor: Colors.redAccent,colorText: Colors.white);
       }
     }
     catch(e){
       Get.snackbar("Error", e.toString(),backgroundColor: Colors.redAccent,colorText: Colors.white);

     }finally{
       mailController.text='';
       password2Controller.text='';
       firstnameController.text='';
       lastnameController.text="";
       immController.text="";
       phoneController.text='';
       isDataLoading(false);
     }
   }


   Future<void> userToLocalStoreg(UserModel user) async {
     await seesion.write("isLogin", true);
     await seesion.write("email", user.email);
     await seesion.write("userID", user.id);
     await seesion.write("name", user.nom);
     await seesion.write("firstname", user.prenom);
     await seesion.write("cin", user.cin);
     await seesion.write("phone", user.telephone);
     print(seesion.read("phone")+"--------------------------------------------------"+seesion.read("cin"));

   }


}