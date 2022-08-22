import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../Constant.dart';
import '../../Model/UserModel.dart';
import 'package:http/http.dart' as http;

import '../complaintsWedgets/ComplaintListController.dart';
import '../dashboard/dashboard_controller.dart';
import '../dashboard/dashboard_page.dart';

class ComplaintController extends GetxController {
  ListDeclarationController listController = Get.find();
  final dashcontroller = Get.put(DashboardController());

  late TextEditingController descController,
      addressController,
      cateController,
      titreConroller;
  final session = GetStorage();
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;
  var userEmail = '';

  Future<void> getImage(ImageSource imageSource) async {
    final pickelFile = await ImagePicker().getImage(source: imageSource);
    if (pickelFile != null) {
      selectedImagePath.value = pickelFile.path;
      selectedImageSize.value =
          (File(selectedImagePath.value).lengthSync() / 1024 / 1024)
                  .toStringAsFixed(2) +
              " MB";
    } else {
      Get.snackbar("Error", "No image selected",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
    }
  }

  @override
  void onInit() async {
    super.onInit();
    descController = TextEditingController();
    addressController = TextEditingController();
    cateController = TextEditingController();
    titreConroller = TextEditingController();
    if (session.read("email") != null) {
      userEmail = session.read("email");
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void valider() async {
    try {
      var request = http.MultipartRequest('POST',
          Uri.parse(Constant().baseUrl + "declaration/newDeclaration/"));
      request.files.add(await http.MultipartFile.fromPath(
          'file', selectedImagePath.value));
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar("Error", "Location permissions are denied",
              backgroundColor: Colors.redAccent, colorText: Colors.white);
        } else if (permission == LocationPermission.deniedForever) {
          Get.snackbar("Error", "Location permissions are permanently denied",
              backgroundColor: Colors.redAccent, colorText: Colors.white);
        } else {
          Get.snackbar("Error", "GPS Location service is granted",
              backgroundColor: Colors.redAccent, colorText: Colors.white);
        }
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print(position.longitude);
      print(position.latitude);

      String long = position.longitude.toString();
      String lat = position.latitude.toString();
      var data = '{"title":"' +
          titreConroller.text +
          '","content":"' +
          descController.text +
          '","longitude":' +
          long +
          ',"latitude":' +
          lat +
          ',"adresse":"' +
          addressController.text +
          '","categ":"' +
          cateController.text +
          '"}';
      print(data);
      request.fields['email'] = session.read("email");
      request.fields['declaration'] = data;
      var res = await request.send();
      if (res.statusCode == 200) {
        selectedImagePath.value = '';
        addressController.text = '';
        descController.text = '';
        titreConroller.text = '';
        cateController.text = '';
        listController.getAllDeclaration();
        dashcontroller.tabIndex.value = 0;
        Get.to(() => DashboardPage());
        Get.snackbar("Succes", "La déclaration est envoyée",
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar("Error", "Server Error",
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } catch (e) {
      print(e);
    }
  }
}
