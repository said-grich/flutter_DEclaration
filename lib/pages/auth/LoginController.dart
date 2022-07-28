import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../Constant.dart';
import '../../Model/UserModel.dart';
import 'package:http/http.dart' as http;

import '../dashboard/dashboard_page.dart';


class LoginController extends GetxController{


  UserModel? user_model;
  var isDataLoading = false.obs;
  final seesion = GetStorage();
   var isLogin=false;
   late TextEditingController emailController, pdController,passwordController;
  var email = '';
  var password = '';
  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    pdController = TextEditingController();
    passwordController = TextEditingController();

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    pdController.dispose();
    super.dispose();
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide valid Email";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 6) {
      return "Password must be of 6 characters";
    }
    return null;
  }

  Future<void> checkLogin() async {
      await this.login();
  }

  Future<void> login() async {
    try{
      isDataLoading(true);
     var res= await http.post(

          Uri.parse(Constant().baseUrl+'auth/login'),
          headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
          'email': this.emailController.text,
           'password': this.pdController.text
          }));
     print("=============>"+this.passwordController.text);
      if (res.statusCode == 200) {
        print(res.body==-2);
        if(res.body==-1){
          Get.snackbar("Error", "user not found",backgroundColor: Colors.red,colorText: Colors.white);

        }
        else if(res.body=="-2"){
          Get.snackbar("Error", "mot de pass",backgroundColor: Colors.red,colorText: Colors.white);


        }
        else{
          var user =UserModel.fromJson(jsonDecode(res.body));
          this.userToLocalStoreg(user);
          Get.snackbar("Succes", "utilisateur  se conecter avec succes",backgroundColor: Colors.green,colorText: Colors.white);
          Get.to(() => DashboardPage());
        }

      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.

        Get.snackbar("ERRor", "SERVER ERRor",backgroundColor: Colors.red,colorText: Colors.white);

      }
    }
    catch(e){
      print(e);
    }
    finally{
      isDataLoading(false);
    }
  }


  Future<bool> userToLocalStoreg(UserModel user) async {
    await seesion.write("isLogin", true);
    await seesion.write("email", user.email);
    await seesion.write("userID", user.id);
    await seesion.write("name", user.nom);
    await seesion.write("firstname", user.prenom);
    await seesion.write("cin", user.cin);
    await seesion.write("phone", user.telephone);
    return true;
  }


}