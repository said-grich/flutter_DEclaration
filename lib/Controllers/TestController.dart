import 'package:get/get.dart';

class TestContorller extends GetxController{

  int _x=0;
  int get x=>_x;
  void increment(){
    _x++;
    print(_x);
  }

}