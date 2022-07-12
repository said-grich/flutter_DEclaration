import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/pages/auth/Login_page.dart';
import 'package:untitled/pages/auth/RegisterController.dart';

class Register_Page extends GetView<RegisterController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 60, left: 16, right: 16),
          width: context.width,
          height: context.height,
          child: SingleChildScrollView(
            child: Form(
              key: controller.RegisterFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                 Text(
                      "Créer un Compte",
                      style: GoogleFonts.poppins(fontSize: 35 ,color: Colors.black,fontWeight: FontWeight.bold),
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    "assets/images/garbage.png",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Bienvenue à Ajiw",
                    style: TextStyle(fontSize: 20, color: Colors.black87),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "nom",
                      prefixIcon: Icon(Icons.perm_identity),
                    ),
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    controller: controller.lastnameController,

                    validator: (value) {
                      return controller.validName(value!);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "prénom",
                      prefixIcon: Icon(Icons.perm_identity),
                    ),
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    controller: controller.firstnameController,

                    validator: (value) {
                      return controller.validName(value!);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  )
              ,
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    controller: controller.emailController,
                    onSaved: (value) {
                      controller.email = value!;
                    },
                    validator: (value) {
                      return controller.validateEmail(value!);
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    controller: controller.passwordController,
                    onSaved: (value) {
                      controller.password = value!;
                    },
                    validator: (value) {
                      return controller.validatePassword(value!);
                    },
                  ),

                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "telephone",
                      prefixIcon: Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    controller: controller.phoneController,


                  ),
                  SizedBox(
                    height: 16,
                  ),


                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "CIN",
                      prefixIcon: Icon(Icons.perm_identity),
                    ),
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    controller: controller.immController,


                  ),

                  SizedBox(
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
                        MaterialStateProperty.all(Color(0xFFB1EA37)),
                        padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                      ),
                      child: Text(
                        "Crée un Account",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      onPressed: () {
                        controller.checkLogin();
                      },
                    ),
                  ),
                  SizedBox(
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
                        padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                      ),
                      child: Text(
                        "Se connecter",
                        style: TextStyle(fontSize: 14, color: Color(0xFFB1EA37)),
                      ),
                      onPressed: () {
                        Get.to(Login_page());

                      },
                    ),
                  ),
                  SizedBox(
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