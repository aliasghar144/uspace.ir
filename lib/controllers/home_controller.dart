import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  String mainUrl = 'https://api.uspace.ir/api/p_u_api/v1';

  @override
  void onInit() {
    // fetchMainGallery();
    // fetchCategories();
    // fetchSeasonalSuggest();
    super.onInit();
  }

  RxList mainGallery = [].obs;
  RxList categories = [].obs;
  RxList seasonalSuggestEcolodge = [].obs;

  List categoryname = [
    {
      'name': 'اقامتگاه بوم گردی',
      'img': "https://www.uspace.ir/public/img/ecolodge/categories/cat1.jpg"
    },
    {
      'name': 'بوتیک هتل و هتل ستنی',
      'img':
          'https://www.uspace.ir/public/img/ecolodge/categories/cat_hotel2.jpg'
    },
    {
      'name': 'کلبه های جنگلی',
      'img':
          'https://www.uspace.ir/public/img/ecolodge/categories/cottages-category.jpg'
    },
    {
      'name': 'اب درمانی',
      'img':
          'https://www.uspace.ir/public/img/ecolodge/categories/cat_abdarmani2.jpg'
    },
    {
      'name': 'اقامتگاه بوم گردی',
      'img': "https://www.uspace.ir/public/img/ecolodge/categories/cat1.jpg"
    },
    {
      'name': 'بوتیک هتل و هتل ستنی',
      'img':
      'https://www.uspace.ir/public/img/ecolodge/categories/cat_hotel2.jpg'
    },
  ];

  List cities = [
    'اصفهان',
    'هرمزگان',
    'خراسان شمالی',
    'کهکیلویه و بویر احمد',
    'فارس',
  ].obs;

  fetchMainGallery()async{
    try{
      var url = Uri.parse('$mainUrl/main_gallery');
      var response = await http.get(url);
      if(response.statusCode == 200){
       mainGallery.value = (jsonDecode(response.body))['data'];
      }
    }catch(e){
      print(e);
    }
  }

  fetchCategories()async{
    try{
      var url = Uri.parse('$mainUrl/categories');
      var response = await http.get(url);
      if(response.statusCode == 200){
        print(jsonDecode(response.body));
        categories.value = jsonDecode(response.body);
      }
    }catch(e){
      print(e);
    }
  }

  fetchSeasonalSuggest()async{
    try{
      var url = Uri.parse('$mainUrl/categories');
      var response = await http.get(url);
      if(response.statusCode == 200){
        print(jsonDecode(response.body));
        seasonalSuggestEcolodge.value = (jsonDecode(response.body))['data'];
      }
    }catch(e){
      print(e);
    }
  }
}
