import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:untitled/pages/profile/profileController.dart';

class AccountPage extends GetView<ProfileController> {
  final session = GetStorage();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var FirstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneController = TextEditingController();
  var immController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (session.read("email") != null) {
      this.readFromLocalStorege();
    }
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    readFromLocalStorege();
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 60, left: 16, right: 16),
          width: context.width,
          height: context.height,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Text(
                    "Profile",
                    style: GoogleFonts.poppins(
                        fontSize: 35,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
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
                      prefixIcon: Icon(Icons.perm_contact_cal_rounded),
                    ),
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    controller: this.lastNameController,
                    validator: (value) {
                      return controller.validatePassword(value!);
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
                      prefixIcon: Icon(Icons.perm_contact_cal_rounded),
                    ),
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    controller: this.FirstNameController,
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
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    controller: this.emailController,
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
                    controller: this.passwordController,
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
                    keyboardType: TextInputType.text,
                    controller: this.immController,
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
                    controller: this.phoneController,
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
                        print("ubdate");
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
                        style: TextStyle(fontSize: 14, color: Colors.white),
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

  Future<void> readFromLocalStorege() async {
    var islogin = session.read("isLogin");
    this.emailController.text = session.read("email");
    this.lastNameController.text = session.read("name");
    this.FirstNameController.text = session.read("FirstName");
    this.immController.text = session.read("cin");
    this.phoneController.text = session.read("phone");
  }
}
