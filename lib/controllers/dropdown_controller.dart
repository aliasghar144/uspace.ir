import 'package:get/get.dart';

class DropDownController extends GetxController{

  final dropDownValue = ''.obs;

  final List<String> dropDownItems = [
    'هال برد',
    'فول برد',
  ];

  void setSelected(String value){
    dropDownValue.value = value;
  }

}