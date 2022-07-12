import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../Model/UserModel.dart';
import '../dashboard/dashboard_page.dart';


class RegisterController extends GetxController{

   GlobalKey<FormState> RegisterFormKey = GlobalObjectKey<FormState>(2);

  late TextEditingController emailController, passwordController,firstnameController,lastnameController,phoneController,immController;
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
    emailController = TextEditingController();
    passwordController = TextEditingController();
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
    emailController.dispose();
    passwordController.dispose();
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

   Future<void> checkLogin() async{
    // final isValid = RegisterFormKey.currentState!.validate();
    // if (!isValid) {
     await singup();
    // }
    // RegisterFormKey.currentState!.save();
  }
   Future<void> singup() async {
     try{
       isDataLoading(true);
       var res= await http.post(
           Uri.parse('http://192.168.43.77:8090/auth/singup'),
           headers: <String, String>{
             'Content-Type': 'application/json; charset=UTF-8',
           },
           body: jsonEncode(<String, String>{
             'email': this.emailController.text,
             'password': this.passwordController.text,
             'nom':this.lastnameController.text,
             'prenom':this.firstnameController.text,
             'telephone':this.phoneController.text,
             'cin':this.immController.text,
           }));
       print(res.statusCode);
       if (res.statusCode == 200) {
         if(res.body== "-1"){
           print("user All ready ");
         }
         else{
           var user =UserModel.fromJson(jsonDecode(res.body));
           this.userToLocalStoreg(user);
           Get.to(() => DashboardPage());
         }

       } else {
         // If the server did not return a 200 OK response,
         // then throw an exception.
         throw Exception('Failed to load album');
       }
     }
     catch(e){
       print(e);
     }finally{
       isDataLoading(false);
     }
   }


   Future<bool> userToLocalStoreg(UserModel user) async {
     await seesion.write("isLogin", true);
     await seesion.write("email", user.email);
     await seesion.write("name", user.nom);
     await seesion.write("firstname", user.prenom);
     await seesion.write("cin", user.cin);
     await seesion.write("phone", user.telephone);
     return true;
   }


}