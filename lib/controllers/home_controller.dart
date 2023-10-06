import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:uspace_ir/models/best_places_model.dart';
import 'package:uspace_ir/models/ecolodge_model.dart';
import 'package:uspace_ir/models/special_places_model.dart';
import 'package:uspace_ir/models/test.dart';

class HomeController extends GetxController {

  @override
  void onInit() {
    fetchMainGallery();
    fetchCategories();
    fetchNewestEcolodge();
    fetchBestSellersEcolodge();
    fetchSessionSuggest();
    fetchBestOfferEcolodge();
    fetchSpecialPlaces();
    fetchBestPlaces();
    super.onInit();
  }


  String mainUrl = 'https://api.uspace.ir/api/p_u_api/v1';
  Map<String, String> requestHeaders = {
    'Accept': 'application/json',
  };

  RxBool retry = false.obs;

  RxList mainGallery = [].obs;
  RxList categories = [].obs;
  List<EcolodgeModel> sessionSuggestList = <EcolodgeModel>[].obs;
  List<EcolodgeModel> newestEcolodgeList = <EcolodgeModel>[].obs;
  List<EcolodgeModel> bestSellersEcolodgeList = <EcolodgeModel>[].obs;
  List<EcolodgeModel> bestOfferEcolodgeList = <EcolodgeModel>[].obs;
  List<BestPlacesModel> bestPlacesList = <BestPlacesModel>[].obs;
  List<SpecialPlacesModel> specialPlacesList = <SpecialPlacesModel>[].obs;

  final test  = Rxn<TestModel>();

  fetchTest()async{
    try{
      print('try');
      var url = Uri.parse('$mainUrl/seasonal_suggest_ecolodge');
      var response = await http.get(url);
      if(response.statusCode == 200){
        test.value = testModelFromJson(response.body);
      }
      print(test.value?.links.next);
    }
    on SocketException {
      retry.value = true;
    }
    catch(e){
      print(e);
    }
  }

  fetchMainGallery()async{
    try{
      var url = Uri.parse('$mainUrl/main_gallery');
      var response = await http.get(url);
      if(response.statusCode == 200){
       mainGallery.value = (jsonDecode(response.body))['data'];
      }
    }
    on SocketException {
      retry.value = true;
    }
    catch(e){
      retry.value = true;
      print(e);
    }
  }

  fetchCategories()async{
    try{
      var url = Uri.parse('$mainUrl/categories');
      var response = await http.get(url);
      if(response.statusCode == 200){
        categories.value = jsonDecode(response.body);
      }
    }catch(e){
      print(e);
    }
  }

  fetchNewestEcolodge()async{
    try{
      var url = Uri.parse('$mainUrl/newest_ecolodge');
      var response = await http.get(url,headers: requestHeaders);
      if(response.statusCode == 200){
        final data = jsonDecode(response.body)['data'];
        newestEcolodgeList.addAll(ecolodgeModelFromJson(jsonEncode(data)));
      }
    }catch(e){
      print(e);
    }
  }

  fetchSessionSuggest()async{
    try{
      var url = Uri.parse('$mainUrl/seasonal_suggest_ecolodge');
      var response = await http.get(url,headers: requestHeaders);
      if(response.statusCode == 200){
        final data = jsonDecode(response.body)['data'];
        sessionSuggestList.addAll(ecolodgeModelFromJson(jsonEncode(data)));
      }
    }catch (e){
      print(e);
        }
  }

  fetchBestSellersEcolodge()async{
    try{
      var url = Uri.parse('$mainUrl/best_sellers_ecolodge');
      var response = await http.get(url,headers: requestHeaders);
      if(response.statusCode == 200){
        final data = jsonDecode(response.body)['data'];
        bestSellersEcolodgeList.addAll(ecolodgeModelFromJson(jsonEncode(data)));
      }
    }catch (e){
      print(e);
    }
  }

  fetchBestOfferEcolodge()async{
    try{
      var url = Uri.parse('$mainUrl/best_offer_ecolodge');
      var response = await http.get(url,headers: requestHeaders);
      if(response.statusCode == 200){
        final data = jsonDecode(response.body)['data'];
        bestOfferEcolodgeList.addAll(ecolodgeModelFromJson(jsonEncode(data)));
      }
    }catch (e){
      print(e);
    }
  }

  fetchBestPlaces()async{
    try{
      var url = Uri.parse('$mainUrl/best_places');
      var response = await http.get(url,headers: requestHeaders);
      if(response.statusCode == 200){
        final data = jsonDecode(response.body)['data'];
        bestPlacesList.addAll(bestPlacesModelFromJson(jsonEncode(data)));
      }
    }catch (e){
      print(e);
    }
  }

  fetchSpecialPlaces()async{
    try{
      var url = Uri.parse('$mainUrl/get_landings?number=12');
      var response = await http.get(url,headers: requestHeaders);
      if(response.statusCode == 200){
        final data = jsonDecode(response.body)['data'];
        specialPlacesList.addAll(specialPlacesModelFromJson(jsonEncode(data)));
      }
    }catch (e){
      print(e);
    }
  }

  retryConnection(){
    retry.value = false;
    onInit();
  }

}
