import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{

  TextEditingController phoneNumberController = TextEditingController();

  hideNumber(){
   return phoneNumberController.text.replaceRange(4, 7, '***');
  }

}