import 'package:get/get.dart';

class FilterController extends GetxController{
  final List categoryList = [
    {
      'value':false.obs,
      'name' : 'اقامتگاه بومگردی'
    },
    {
      'value':false.obs,
      'name' : 'بوتیک'
    },
    {
      'value':false.obs,
      'name' : 'کلبه های بومی'
    },
    {
      'value': false.obs,
      'name' : 'آب درمانی'
    }
  ];

  final List commentList = [
    {
      'value':false.obs,
      'name' : 'بسیار عالی'
    },
    {
      'value':false.obs,
      'name' : 'خوب'
    },
    {
      'value':false.obs,
      'name' : 'متوسط'
    },
    {
      'value': false.obs,
      'name' : 'ضعیف'
    },
    {
      'value': false.obs,
      'name' : 'بسیار ضعیف'
    }
  ];


  final List cityList = [
    {
      'value':false.obs,
      'name' : 'تهران'
    },
    {
      'value':false.obs,
      'name' : 'مشهد'
    },
    {
      'value':false.obs,
      'name' : 'شیراز'
    },
    {
      'value': false.obs,
      'name' : 'اصفهان'
    },
    {
      'value': false.obs,
      'name' : 'تبریز'
    }
  ];

}