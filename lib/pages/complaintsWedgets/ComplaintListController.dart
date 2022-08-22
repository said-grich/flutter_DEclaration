import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Constant.dart';
import 'package:untitled/Model/EtatDeclarationModel.dart';
import 'dart:convert';

import 'package:untitled/pages/news/ComplaintModel.dart';

class ListDeclarationController extends GetxController {
  var x = "List Q des DEclaration";
  var declarationList = List<ComplaintModel>.empty().obs;
  var isDataLoading = true.obs;
  final session = GetStorage();
  var userID = 0;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  void onClose() {}

  @override
  Future<void> onReady() async {
    super.onReady();
    await getAllDeclaration();
  }

  Future<void> getAllDeclaration() async {
    print("Check");
    if (session.read("userID") != null) {
      this.userID = session.read("userID");
    }
    this.declarationList.clear();
    this.declarationList.value = [];
    this.isDataLoading.value = true;
    try {
      print(Constant().baseUrl);
      var res = await http.get(Uri.parse(Constant().baseUrl +
          "declaration/userdec/" +
          this.userID.toString()));
      if ((res.statusCode == 200)) {
        List jsonResponse = json.decode(res.body);

        jsonResponse.forEach((element) async {
          var tmp = ComplaintModel.fromJson(element);
          var res2 = await http.get(Uri.parse(
              Constant().baseUrl + "declaration/etat/" + tmp.id.toString()));
          if (res2.statusCode == 200) {
            List jsonResponse2 = json.decode(res2.body);
            var etats = [];
            jsonResponse2.forEach((element) {
              etats.add(EtatDeclarationModel.fromJson(element));
            });
            etats.sort((b, a) {
              var a1 = a.dateEtat;
              var b1 = b.dateEtat;
              return a1.compareTo(b1);
            });
            tmp.listEtat = etats;
          } else {
            print(res2.statusCode);
          }
          this.declarationList.value.add(tmp);
        });
        print(this.declarationList.value.length);
      } else {
        Get.snackbar("Error", "Eroor Fetch");
      }
    } finally {
      this.isDataLoading.value = false;
    }
  }
}
