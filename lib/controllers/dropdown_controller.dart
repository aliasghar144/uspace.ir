import 'package:get/get.dart';

class DropDownController extends GetxController{

  final dropDownValue = ''.obs;

  final List<String> dropDownItems = [
    '1 شب',
    '2 شب',
    '3 شب',
    '4 شب',
    ':5 شب',
  ];

  void setSelected(String value){
    dropDownValue.value = value;
  }

}