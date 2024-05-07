import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uspace_ir/constance/constance.dart';
import 'package:uspace_ir/controllers/base_controller.dart';
import 'package:uspace_ir/models/all_places_model.dart';
import 'package:uspace_ir/models/live_search_landing_model.dart';
import 'package:uspace_ir/models/live_search_places_model.dart';
import 'package:http/http.dart' as http;
import 'package:uspace_ir/models/search_model.dart';

class SearchController extends GetxController {

  BaseController baseController = Get.find();

  @override
  void onInit() {
    searchScrollController.addListener(() {
        if (searchScrollController.position.pixels == searchScrollController.position.maxScrollExtent && !loading.value && baseController.pageIndex.value == 2) {
          loadMoreData();
        }
    },);
    super.onInit();
  }

  TextEditingController searchTextFieldController = TextEditingController();

  ScrollController searchScrollController = ScrollController();


  RxBool loading = false.obs;
  RxBool wait4req = false.obs;
  RxBool firstOpen = true.obs;
  RxBool needSearchAgain = false.obs;
  RxBool searchError = false.obs;
  RxBool loadMore = false.obs;

  late Uri url;


  RxString nextLink = ''.obs;


  Rx<double> rangeStart = 0.0.obs;
  Rx<double> rangeEnd = 100.0.obs;


  RxString categoryTitle =  ''.obs;
  RxString categoryId =  ''.obs;
  RxString cityTitle = ''.obs;
  RxString cityUrl = ''.obs;
  RxString specialPlaceTitle = ''.obs;
  RxString specialPlaceUrl = ''.obs;

  Rxn<AllPlacesModel> cityList  = Rxn<AllPlacesModel>();

  List<SearchModel> liveSearchEcolodgesResult = <SearchModel>[].obs;
  List<SearchPlacesModel> searchPlacesResult = <SearchPlacesModel>[].obs;
  List<SearchModel> searchEcolodgesResult = <SearchModel>[].obs;
  List<SearchLandingPagesModel> liveSearchLandingPagesResult = <SearchLandingPagesModel>[].obs;

  final List categoryList = [
    {'name': 'همه', 'id': ''},
    {'name': 'اقامتگاه بوم گردی', 'id': 'ecolodges'},
    {'name': 'کلبه های بومی', 'id': 'cottages'},
    {'name': 'بوتیک هتل و هتل سنتی', 'id': 'hotels'},
    {'name': 'آب درمانی', 'id': 'hydrotherapy'}
  ];


  final sortByValue = 'پرفروش ترین'.obs;

  var sortByItems = [
    'پرفروش ترین',
    'بیشترین تخفیف',
    'پربازدیدترین',
    'محبوب ترین',
    'جدید ترین',
    'ارزان ترین',
    'گران ترین',
  ];

  // City List
  fetchAllPlaces() async {
    try {
      if(cityList.value == null){
        loading.value = true;
        url = Uri.parse('$mainUrl/all_places');
        var response = await http.get(url);
        if (response.statusCode == 200) {
          cityList.value = (allPlacesModelFromJson(response.body));
        }
        loading.value = false;
      }
    } on SocketException {
      loading.value = false;
      print(SocketException);
    } catch (e) {
      loading.value = false;
      print(e);
    }
  }

  searchWithFilter(String q) async {
    try {
      Map<String, dynamic> body = <String, dynamic>{
        'q': q,
        'sortBy': sortByToCode(),
        'page': 1,
        'num': 12,
        'minPrice': (rangeStart.value * 500000).toInt(),
        'maxPrice': (rangeEnd.value * 500000).toInt(),
        'cat': categoryId.value,
      }.map((key, value) => MapEntry(key, value.toString()));
      firstOpen.value = false;
      searchError.value = false;
      loading.value = true;
      if(specialPlaceTitle.value!=''){
        url = Uri.parse('$mainUrl/landing/${specialPlaceUrl.value}/all-ecolodges').replace(queryParameters: body);
      }
      else if(cityTitle.value != ''){
        url = Uri.parse('$mainUrl/place/$cityUrl/all-ecolodges').replace(queryParameters: body);
      }else{
        url = Uri.parse('$mainUrl/all_ecolodges').replace(queryParameters: body);
      }
      print(url);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        clearResultList();
        final data = jsonDecode(response.body)['data'];
        final link = jsonDecode(response.body)['links'];
        searchEcolodgesResult.addAll(ecolodgeModelFromJson(jsonEncode(data)));
        nextLink.value = link['next'].toString();
      }else{
        searchError.value = true;
      }
      loading.value = false;
    } on SocketException {
      searchError.value = true;
      loading.value = false;
      print(SocketException);
    } catch (e) {
      searchError.value = true;
      loading.value = false;
      print(e);
    }
  }

  searchWithLink(String link) async {
    try {
      loading.value = true;
      url = Uri.parse(link);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        searchEcolodgesResult.addAll(ecolodgeModelFromJson(jsonEncode(data)));
      }
      loading.value = false;
    } on SocketException {
      loading.value = false;
      print(SocketException);
    } catch (e) {
      loading.value = false;
      print(e);
    }
  }

  liveSearch(String q) async {
    try {
      firstOpen.value = false;
      loading.value = true;
      url = Uri.parse('$mainUrl/live-search').replace(queryParameters: {'q': q});
      var response = await http.get(url);
      if (response.statusCode == 200) {
        clearResultList();

        final ecolodges = jsonDecode(response.body)['ecolodges'];
        final place = jsonDecode(response.body)['places'];
        final landing = jsonDecode(response.body)['landing_pages'];

        liveSearchEcolodgesResult.addAll(ecolodgeModelFromJson(jsonEncode(ecolodges)));
        liveSearchLandingPagesResult.addAll(liveSearchLandingPagesModelFromJson(jsonEncode(landing)));
        searchPlacesResult.addAll(liveSearchPlacesModelFromJson(jsonEncode(place)));
      }
      loading.value = false;
    } on SocketException {
      loading.value = false;
      print(SocketException);
    } catch (e) {
      loading.value = false;
      print(e);
    }
  }

  void loadMoreData() async{
    try{
      print(' here we go nextLink $nextLink');
      if(nextLink.value != 'null'){
        url = Uri.parse(nextLink.value);
        var response = await http.get(url);
        if(response.statusCode == 200){
          loadMore.value = true;
          final data = jsonDecode(response.body)['data'];
          final link = jsonDecode(response.body)['links'];
            searchEcolodgesResult.addAll(ecolodgeModelFromJson(jsonEncode(data)));
            nextLink.value = link['next'].toString();
        }
      }
      loadMore.value = false;
    }catch(e){
      loadMore.value = false;
      rethrow ;
    }
  }

  void clearResultList() {
    liveSearchEcolodgesResult.clear();
    searchPlacesResult.clear();
    searchEcolodgesResult.clear();
    liveSearchLandingPagesResult.clear();
  }

  sortByToCode() {
    switch (sortByValue.value) {
      case 'پرفروش ترین':
        return 'bestSell';
      case 'بیشترین تخفیف':
        return 'bestOffer';
      case 'پربازدیدترین':
        return 'mostVisited';
      case 'محبوب ترین':
        return 'popular';
      case 'جدید ترین':
        return 'newest';
      case 'ارزان ترین':
        return 'cheapest';
      case 'گران ترین':
        return 'expensive';
    }
  }

  void resetFilter() {
    rangeStart.value = 0;
    rangeEnd.value = 100;
    categoryTitle.value =  '';
    categoryId.value =  '';
    cityTitle.value = '';
    cityUrl.value = '';
    specialPlaceTitle.value = '';
    specialPlaceUrl.value = '';
  }

}
