import 'package:get/get.dart';

class DropDownController extends GetxController{

  final dropDownValue = ''.obs;

  final List<String> dropDownItems = [
    'به مدت:1 شب ',
    'به مدت:2 شب ',
    'به مدت:3 شب ',
    'به مدت:4 شب ',
    'به مدت:5 شب ',
  ];

  void setSelected(String value){
    dropDownValue.value = value;
  }

}