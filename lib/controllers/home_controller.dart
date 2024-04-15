import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:uspace_ir/constance/constance.dart';
import 'package:uspace_ir/models/best_places_model.dart';
import 'package:uspace_ir/models/ecolodge_model.dart';
import 'package:uspace_ir/models/main_gallery_model.dart';
import 'package:uspace_ir/models/special_places_model.dart';
import 'package:uspace_ir/models/test.dart';

class HomeController extends GetxController {

  final RxBool loading = false.obs;

  RxInt currentPage = 0.obs;

  final PageController mainGalleryController = PageController();
  final PageController newestEcolodgeController = PageController();

  @override
  void onInit() {
    fetchMainGallery();
    fetchCategories();
    fetchNewestEcolodge();
    fetchSpecialPlaces();
    fetchBestPlaces();
    fetchSessionSuggest();
    fetchBestSellersEcolodge();
    fetchBestOfferEcolodge();
    super.onInit();
  }


  Map<String, String> requestHeaders = {
    'Accept': 'application/json',
  };

  RxBool retry = false.obs;

  RxList categories = [].obs;

  late final  mainGalleryList = Rxn<MainGalleryModel>();
  List<EcolodgeModel> sessionSuggestList = <EcolodgeModel>[].obs;
  List<EcolodgeModel> newestEcolodgeList = <EcolodgeModel>[].obs;
  List<EcolodgeModel> bestSellersEcolodgeList = <EcolodgeModel>[].obs;
  List<EcolodgeModel> bestOfferEcolodgeList = <EcolodgeModel>[].obs;
  List<BestPlacesModel> bestPlacesList = <BestPlacesModel>[].obs;
  List<SpecialPlacesModel> specialPlacesList = <SpecialPlacesModel>[].obs;

  final test  = Rxn<TestModel>();

  fetchTest()async{
    try{
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
      loading.value = true;
      var url = Uri.parse('$mainUrl/main_gallery');
      var response = await http.get(url);
      if(response.statusCode == 200){
        mainGalleryList.value = mainGalleryModelFromJson(response.body);
       loading.value = false;
      }
    } on SocketException {
      retry.value = true;
      loading.value = false;
    }
    catch(e){
      retry.value = true;
      loading.value = false;
      print('ERR===== mainGallery =======> $e');
    }
  }

  fetchCategories()async{
    try{
      loading.value = true;
      var url = Uri.parse('$mainUrl/categories');
      var response = await http.get(url);
      if(response.statusCode == 200){
        categories.value = jsonDecode(response.body);
        loading.value = false;
      }
    }catch(e){
      print('ERR=====category=======> $e');
      loading.value = false;
    }
  }

  fetchNewestEcolodge()async{
    try{
      loading.value = true;
      newestEcolodgeList.clear();
      var url = Uri.parse('$mainUrl/newest_ecolodge');
      var response = await http.get(url,headers: requestHeaders);
      if(response.statusCode == 200){
        final data = jsonDecode(response.body)['data'];
        newestEcolodgeList.addAll(ecolodgeModelFromJson(jsonEncode(data)));
        loading.value = false;
      }
    }catch(e){
      print('ERR=====newest ecolodge=======> $e');
      loading.value = false;

    }
  }

  fetchSessionSuggest()async{
    try{
      loading.value = true;
      sessionSuggestList.clear();
      var url = Uri.parse('$mainUrl/seasonal_suggest_ecolodge');
      var response = await http.get(url,headers: requestHeaders);
      if(response.statusCode == 200){
        final data = jsonDecode(response.body)['data'];
        sessionSuggestList.addAll(ecolodgeModelFromJson(jsonEncode(data)));
        loading.value = false;
      }
    }catch (e){
      loading.value = false;
      print('ERR=====session suggest =======> $e');

    }
  }

  fetchBestSellersEcolodge()async{
    try{
      loading.value = true;
      bestSellersEcolodgeList.clear();
      var url = Uri.parse('$mainUrl/best_sellers_ecolodge');
      var response = await http.get(url,headers: requestHeaders);
      if(response.statusCode == 200){
        final data = jsonDecode(response.body)['data'];
        bestSellersEcolodgeList.addAll(ecolodgeModelFromJson(jsonEncode(data)));
        loading.value = false;
      }
    }catch (e){
      print('ERR=====best seller=======> $e');
      loading.value = false;

    }
  }

  fetchBestOfferEcolodge()async{
    try{
      loading.value = true;
      bestOfferEcolodgeList.clear();
      var url = Uri.parse('$mainUrl/best_offer_ecolodge');
      var response = await http.get(url,headers: requestHeaders);
      if(response.statusCode == 200){
        final data = jsonDecode(response.body)['data'];
        bestOfferEcolodgeList.addAll(ecolodgeModelFromJson(jsonEncode(data)));
        loading.value = false;
      }
    }catch (e){
      loading.value = false;
      print('ERR=====bestOffer=======> $e');
    }
  }

  fetchBestPlaces()async{
    try{
      loading.value = true;
      bestPlacesList.clear();
      var url = Uri.parse('$mainUrl/best_places');
      var response = await http.get(url,headers: requestHeaders);
      if(response.statusCode == 200){
        final data = jsonDecode(response.body)['data'];
        bestPlacesList.addAll(bestPlacesModelFromJson(jsonEncode(data)));
        loading.value = false;
      }
    }catch (e){
      print('ERR=====best Place=======> $e');
      loading.value = false;

    }
  }

  fetchSpecialPlaces()async{
    try{
      loading.value = true;
      specialPlacesList.clear();
      var url = Uri.parse('$mainUrl/get_landings?number=12');
      var response = await http.get(url,headers: requestHeaders);
      if(response.statusCode == 200){
        final data = jsonDecode(response.body)['data'];
        specialPlacesList.addAll(specialPlacesModelFromJson(jsonEncode(data)));
        loading.value = false;
      }
    }catch (e){
      print('ERR=====special Place=======> $e');
      loading.value = false;
    }
  }

  retryConnection(){
    retry.value = false;
    onInit();
  }


}
