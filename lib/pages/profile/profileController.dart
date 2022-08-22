import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../auth/Login_page.dart';

class ProfileController extends GetxController {
  //
  final GetStorage session = GetStorage();
  late TextEditingController emailController,
      passwordController,
      firstNameController,
      lastNameController,
      phoneController,
      immController;
  RegExp phoneRegExp = RegExp(
          r'^(?:(?:(?:\+|00)212[\s]?(?:[\s]?\(0\)[\s]?)?)|0){1}(?:5[\s.-]?[2-3]|6[\s.-]?[13-9]){1}[0-9]{1}(?:[\s.-]?\d{2}){3}$'),
      nameRegExp = RegExp(r"/^[a-z ,.'-]+\$/i");

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
    bool isValidName = nameRegExp.hasMatch(value);
    if (value.length < 2 || !isValidName) {
      return "entrez un nom valide";
    }

    return null;
  }

// you should make it with stream

  Future<void> logout() async {
    // consider using :
    //await session.erase();
    await session.remove("email");
    await session.remove("phone");
    await session.remove("cin");
    await session.remove("FirstName");
    await session.remove("name");
    await session.remove("userID");
    await session.remove("isLogin");

    Get.to(LoginPage());
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
