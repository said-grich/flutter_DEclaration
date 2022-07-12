import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../Model/UserModel.dart';
import 'package:http/http.dart' as http;

import '../dashboard/dashboard_page.dart';


class LoginController extends GetxController{

   GlobalKey<FormState> loginFormKey = GlobalObjectKey<FormState>(1);
  UserModel? user_model;
  var isDataLoading = false.obs;
  final seesion = GetStorage();
   var isLogin=false;
   late TextEditingController emailController, passwordController;
  var email = '';
  var password = '';
  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
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
    final isValid = loginFormKey.currentState!.validate();
    if (isValid) {
      await this.login();

    }else{
      print("test");
    }
  }

  Future<void> login() async {
    try{
      isDataLoading(true);
     var res= await http.post(
          Uri.parse('http://192.168.43.77:8090/auth/login'),
          headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
          'email': this.emailController.text,
           'password': this.passwordController.text
          }));
      if (res.statusCode == 200) {

        if(res.body==-1){
          print("user not found");
        }else{
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
    await seesion.write("cin", user.telephone);
    return true;
  }


}