import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:uni_links/uni_links.dart';
import 'package:uspace_ir/constance/constance.dart';
import 'package:uspace_ir/models/GeneralInfoModel.dart';
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

    Future<void> initUniLinks() async {
      // Platform messages may fail, so we use a try/catch PlatformException.
      try {
        final initialLink = await getInitialLink();
        // Parse the link and warn the user, if it is not correct,
        // but keep in mind it could be `null`.
        print(initialLink);
      } catch (e){
        print(e);
        // Handle exception by warning the user their action did not succeed
        // return?
      }
    }
    initUniLinks();

    fetchMainData();

    super.onInit();
  }


  Map<String, String> requestHeaders = {
    'Accept': 'application/json',
  };

  RxBool retry = false.obs;

  RxList categories = [].obs;

  late final  mainGalleryList = Rxn<MainGalleryModel>();

  final newestEcolodge = Rxn<EcolodgeModel>();
  final sessionSuggest = Rxn<EcolodgeModel>();
  final bestSellersEcolodge = Rxn<EcolodgeModel>();
  final bestOfferEcolodge = Rxn<EcolodgeModel>();
  final generalInfo = Rxn<GeneralInfoModel>();


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
      newestEcolodge.value = null;
      var url = Uri.parse('$mainUrl/newest_ecolodge');
      var response = await http.get(url,headers: requestHeaders);
      if(response.statusCode == 200){
        newestEcolodge.value = (ecolodgeModelFromJson(response.body));
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
      sessionSuggest.value = null;
      var url = Uri.parse('$mainUrl/seasonal_suggest_ecolodge');
      var response = await http.get(url,headers: requestHeaders);
      if(response.statusCode == 200){
        sessionSuggest.value = (ecolodgeModelFromJson(response.body));
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
      bestSellersEcolodge.value = null;
      var url = Uri.parse('$mainUrl/best_sellers_ecolodge');
      var response = await http.get(url,headers: requestHeaders);
      if(response.statusCode == 200){
        bestSellersEcolodge.value = (ecolodgeModelFromJson(response.body));
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
      bestOfferEcolodge.value = null;
      var url = Uri.parse('$mainUrl/best_offer_ecolodge');
      var response = await http.get(url,headers: requestHeaders);
      if(response.statusCode == 200){
        bestOfferEcolodge.value = (ecolodgeModelFromJson(response.body));
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

  fetchGeneralInfo()async{
    try{
      loading.value = true;
      var url = Uri.parse('$mainUrl/general-info');
      var response = await http.get(url,headers: requestHeaders);
      if(response.statusCode == 200){
        generalInfo.value = generalInfoModelFromJson(response.body);
        print(generalInfo.value);
        loading.value = false;
      }
    }catch (e){
      print('ERR=====best Place=======> $e');
      loading.value = false;

    }
  }

  retryConnection(){
    retry.value = false;
    onInit();
  }

  fetchMainData() {
    fetchMainGallery();
    fetchCategories();
    fetchNewestEcolodge();
    fetchSpecialPlaces();
    fetchBestPlaces();
    fetchSessionSuggest();
    fetchBestSellersEcolodge();
    fetchBestOfferEcolodge();
    fetchGeneralInfo();
  }


}
