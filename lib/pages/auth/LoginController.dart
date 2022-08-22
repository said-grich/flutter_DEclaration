import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../Constant.dart';
import '../../Model/UserModel.dart';
import 'package:http/http.dart' as http;

import '../dashboard/dashboard_page.dart';

class LoginController extends GetxController {
  //
  late TextEditingController emailController, pdController, passwordController;

  String email = '', password = '';

  Rx<bool> isDataLoading = false.obs;

  bool isLogin = false;

  final GetStorage session = GetStorage();

  UserModel? userModel;

  String? validateEmail(String value) {
    bool isValidEmail = GetUtils.isEmail(value);

    if (!isValidEmail) {
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
    await login();
  }

  Future<void> login() async {
    try {
      isDataLoading(true);
      final res = await http.post(
        Uri.parse('${Constant().baseUrl}auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            'email': emailController.text.trim(),
            'password': pdController.text.trim()
          },
        ),
      );

      if (res.statusCode == 200) {
        if (res.body == "-1") {
          showSnackBar(title: "Error", message: "user not found");
        } else if (res.body == "-2") {
          showSnackBar(title: "Error", message: "mot de pass");
        } else {
          UserModel user = UserModel.fromJson(jsonDecode(res.body));
          userToLocalStoreg(user);
          showSnackBar(
            title: "ErSuccesror",
            message: "utilisateur  se conecter avec succes",
            backgroundColor: Colors.green,
          );

          Get.to(DashboardPage());
        }
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.

        showSnackBar(title: "Error", message: "Server error");
      }
    } catch (e) {
      print(e);
    } finally {
      isDataLoading(false);
    }
  }

  Future<bool> userToLocalStoreg(UserModel user) async {
    // or you just could save the whole user as UserModel
    await session.write("isLogin", true);
    await session.write("email", user.email);
    await session.write("userID", user.id);
    await session.write("name", user.nom);
    await session.write("FirstName", user.prenom);
    await session.write("cin", user.cin);
    await session.write("phone", user.telephone);
    return true;
  }

  showSnackBar({
    String? title,
    String? message,
    Color? backgroundColor = Colors.red,
    Color? colorText = Colors.white,
  }) {
    Get.snackbar(
      title ?? '',
      message ?? '',
      backgroundColor: backgroundColor,
      colorText: colorText,
    );
  }

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    pdController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onClose() {
    emailController.dispose();
    pdController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
