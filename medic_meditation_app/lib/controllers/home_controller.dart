import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomeController extends GetxController {
  var num=0.obs;
  void increment(){
    num=num+1;
  }
}