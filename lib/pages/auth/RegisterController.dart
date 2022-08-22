import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../Constant.dart';
import '../../Model/UserModel.dart';
import '../dashboard/dashboard_page.dart';

class RegisterController extends GetxController {
  late TextEditingController mailController,
      password2Controller,
      firstNameController,
      lastNameController,
      phoneController,
      immController;

  @override
  void onInit() {
    super.onInit();
    mailController = TextEditingController();
    password2Controller = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneController = TextEditingController();
    immController = TextEditingController();
  }

  String email = '',
      password = '',
      firstName = '',
      lastname = '',
      phone = '',
      imm = '';

  Rx<bool> isDataLoading = false.obs;

  bool isLogin = false;
  RegExp phoneRegExp = RegExp(
      r'^(?:(?:(?:\+|00)212[\s]?(?:[\s]?\(0\)[\s]?)?)|0){1}(?:5[\s.-]?[2-3]|6[\s.-]?[13-9]){1}[0-9]{1}(?:[\s.-]?\d{2}){3}$');
  final session = GetStorage();

  String? validateEmail(String value) {
    bool isValidEmail = GetUtils.isEmail(value);
    if (!isValidEmail) {
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

  String? validPhone(String value) {
    bool isValidPhoneNumber = phoneRegExp.hasMatch(value);

    if (value.length < 10 || !isValidPhoneNumber) {
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

  Future<void> checksignUp() async {
    // final isValid = RegisterFormKey.currentState!.validate();
    // if (!isValid) {
    await signUp();
    // }
    // RegisterFormKey.currentState!.save();
  }

  Future<void> signUp() async {
    try {
      isDataLoading(true);

      final res = await http.post(
        Uri.parse('${Constant().baseUrl}auth/signUp'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, Object>{
            'email': mailController.text,
            'password': password2Controller.text,
            'nom': lastNameController.text,
            'prenom': firstNameController.text,
            'telephone': phoneController.text,
            'cin': immController.text,
            'role': 1,
          },
        ),
      );

      if (res.statusCode == 200) {
        if (res.body == "-1") {
          showSnackBar(
            title: "Error",
            message: "utilisateur existant",
          );
        } else {
          UserModel user = UserModel.fromJson(jsonDecode(res.body));

          showSnackBar(
            title: "Success",
            message: "se connecter avec succes",
            backgroundColor: Colors.green,
          );
          userToLocalStoreg(user);
          Get.to(DashboardPage());
        }
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        showSnackBar(title: "Error", message: "Server Error");
      }
    } catch (e) {
      showSnackBar(title: "Error", message: "$e");
    } finally {
      // dispose ?

      mailController.text = '';
      password2Controller.text = '';
      firstNameController.text = '';
      lastNameController.text = "";
      immController.text = '';
      phoneController.text = '';
      isDataLoading(false);
    }
  }

  Future<void> userToLocalStoreg(UserModel user) async {
    await session.write("isLogin", true);
    await session.write("email", user.email);
    await session.write("userID", user.id);
    await session.write("name", user.nom);
    await session.write("FirstName", user.prenom);
    await session.write("cin", user.cin);
    await session.write("phone", user.telephone);
  }


  @override
  void onClose() {
    mailController.dispose();
    password2Controller.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    immController.dispose();
    phoneController.dispose();
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
}
