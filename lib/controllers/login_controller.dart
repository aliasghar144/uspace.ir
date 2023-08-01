import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{


  TextEditingController phoneNumberController = TextEditingController();
  RxBool activeButton = false.obs;
  RxBool isUserLogin = false.obs;
  hideNumber(String phoneNum){
   return phoneNum.replaceRange(4, 7, '***');
  }

}