import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/pages/auth/LoginController.dart';

import 'Register_Page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final controller = Get.put(LoginController());

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
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, bottom: 40, right: 20, top: 10),
                    child: Text(
                      "Login",
                      style: GoogleFonts.poppins(
                          fontSize: 44,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Image.asset(
                    "assets/images/garbage.png",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Bienvenue à Ajiw",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                    ),
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
                    controller: controller.emailController,
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
                      prefixIcon: const Icon(Icons.password),
                    ),
                    keyboardType: TextInputType.text,
                    controller: controller.pdController,
                    obscureText: true,
                    validator: (value) {
                      return controller.validatePassword(value!);
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: Get.width),
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
                        "Se connecter",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        controller.checkLogin();
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
                        "Créer un Account",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFB1EA37),
                        ),
                      ),
                      onPressed: () {
                        Get.to(const RegisterPage());
                      },
                    ),
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
