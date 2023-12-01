import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterReservationController extends GetxController{
  //#region ================ Booker Details ========================

  final RxBool isTextFieldSelected = false.obs;
  final RxBool isAcceptTerms = false.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController homeNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  var cancellationConditionValue = 'شرایط کنسلی'.obs;
  var babyRoleDropDownValue = 'قوانین خردسالان'.obs;

  var cancellationConditionItems = [
    'شرایط کنسلی',
    'دلیل 1',
    'دلیل 2',
    'دلیل 3',
  ];

  var babyRoleDropDownItems = [
    'قوانین خردسالان',
    '2قوانین خردسالان',
    'قوانین خردسالان3',
    'قوانین خردسالان4',
  ];



  //#endregion ================ Booker Details ========================


}