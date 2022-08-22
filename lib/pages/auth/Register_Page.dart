import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/pages/auth/RegisterController.dart';

import 'Login_page.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 60, left: 16, right: 16),
          width: Get.width,
          height: Get.height,
          child: SingleChildScrollView(
            child: Form(
              key: GlobalKey<FormState>(),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Text(
                    "Créer un Compte",
                    style: GoogleFonts.poppins(
                        fontSize: 35,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    "assets/images/garbage.png",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Bienvenue à Ajiw",
                    style: TextStyle(fontSize: 20, color: Colors.black87),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "nom",
                      prefixIcon: const Icon(Icons.perm_identity),
                    ),
                    keyboardType: TextInputType.text,
                    controller: controller.lastNameController,
                    validator: (value) {
                      return controller.validName(value ?? "");
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "prénom",
                      prefixIcon: const Icon(Icons.perm_identity),
                    ),
                    keyboardType: TextInputType.text,
                    controller: controller.firstNameController,
                    validator: (value) {
                      return controller.validName(value!);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Email",
                      prefixIcon: const Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.text,
                    controller: controller.mailController,
                    validator: (value) {
                      return controller.validateEmail(value!);
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "mot de pass",
                      prefixIcon: const Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.text,
                    controller: controller.password2Controller,
                    obscureText: true,
                    validator: (value) {
                      return controller.validatePassword(value!);
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "telephone",
                      prefixIcon: const Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.text,
                    controller: controller.phoneController,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "CIN",
                      prefixIcon: const Icon(Icons.perm_identity),
                    ),
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    controller: controller.immController,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: context.width),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFFB1EA37)),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(14)),
                      ),
                      child: const Text(
                        "Crée un Account",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      onPressed: () {
                        controller.checksignUp();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: context.width),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(14)),
                      ),
                      child: const Text(
                        "Se connecter",
                        style:
                            TextStyle(fontSize: 14, color: Color(0xFFB1EA37)),
                      ),
                      onPressed: () {
                        Get.to(LoginPage());
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 46,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
