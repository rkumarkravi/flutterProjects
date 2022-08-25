import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final searchTextEditController = TextEditingController();

  RxString controllerText = ''.obs;
  RxString debounceSearchText = ''.obs;
  @override
  void onInit() {
    searchTextEditController.addListener(() {
      controllerText.value = searchTextEditController.text;
    });

    debounce(controllerText, (String data) async {
      if (data != "") {
        // debugPrint("debouce string : $data");
        debounceSearchText.value = data;
        refresh();
      }
    }, time: const Duration(seconds: 1));
    super.onInit();
  }
}
