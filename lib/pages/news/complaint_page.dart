import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'complaint_controller.dart';

class ComplaintPage extends GetView<ComplaintController> {
  @override
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
              key: controller.profileFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Text(
                    "Ajouter une déclaration",
                    style: GoogleFonts.poppins(fontSize: 28 ,color: Colors.black,fontWeight: FontWeight.bold),
                  ),

                  Image.asset(
                    "assets/images/ajouter.png",
                    height: 300,
                  ),

                  SizedBox(
                    height: 3,
                  ),

                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Description",
                      prefixIcon: Icon(Icons.perm_contact_cal_rounded),
                    ),
                    keyboardType: TextInputType.multiline,
                    controller: controller.lastnameController,
                    minLines: 1,
                    maxLines: 5,
                    textInputAction: TextInputAction.newline,

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
                      prefixIcon: Icon(Icons.perm_contact_cal_rounded),
                    ),
                    keyboardType: TextInputType.text,
                    obscureText: true,
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
                      labelText: "CIN",
                      prefixIcon: Icon(Icons.perm_identity),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    controller: controller.immController,

                  ),

                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "numéro de téléphone",
                      prefixIcon: Icon(Icons.phone),
                    ),

                    keyboardType: TextInputType.text,
                    obscureText: true,
                    controller: controller.phoneController,

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
                        "update",
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
                        MaterialStateProperty.all(Colors.redAccent),
                        padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                      ),
                      child: Text(
                        "Logout",
                        style: TextStyle(fontSize: 14, color: Color(0xFFB1EA37)),
                      ),
                      onPressed: () {
                        controller.logout();
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
