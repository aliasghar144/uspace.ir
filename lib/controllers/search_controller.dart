import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uspace_ir/constance/constance.dart';
import 'package:uspace_ir/models/all_places_model.dart';
import 'package:uspace_ir/models/ecolodge_model.dart';
import 'package:uspace_ir/models/live_search_landing_model.dart';
import 'package:uspace_ir/models/live_search_places_model.dart';
import 'package:http/http.dart' as http;

class SearchController extends GetxController {


  @override
  void onInit() {
    searchScrollController.addListener(() {
        if (searchScrollController.position.pixels == searchScrollController.position.maxScrollExtent && !loading.value) {
          loadMoreData();
        }
    },);
    super.onInit();
  }

  TextEditingController searchTextFieldController = TextEditingController();

  ScrollController searchScrollController = ScrollController();


  RxBool loading = false.obs;
  RxBool firstOpen = true.obs;
  RxBool specialPlacesFlag = false.obs;
  RxBool needSearchAgain = false.obs;
  RxBool searchError = false.obs;
  RxBool loadMore = false.obs;

  late Uri url;


  RxString nextLink = ''.obs;
  RxString specialPlace = ''.obs;


  Rx<double> rangeStart = 0.0.obs;
  Rx<double> rangeEnd = 100.0.obs;


  RxString categoryFilter =  ''.obs;
  RxString categoryIdFilter =  ''.obs;
  RxString cityFilter = ''.obs;
  RxString cityUrlFilter = ''.obs;

  Rxn<AllPlacesModel> cityList  = Rxn<AllPlacesModel>();

  List<EcolodgeModel> liveSearchEcolodgesResult = <EcolodgeModel>[].obs;
  List<SearchPlacesModel> searchPlacesResult = <SearchPlacesModel>[].obs;
  List<EcolodgeModel> searchEcolodgesResult = <EcolodgeModel>[].obs;
  List<SearchLandingPagesModel> liveSearchLandingPagesResult = <SearchLandingPagesModel>[].obs;

  final List categoryList = [
    {'name': 'همه', 'id': ''},
    {'name': 'اقامتگاه بوم گردی', 'id': 'ecolodges'},
    {'name': 'کلبه های بومی', 'id': 'cottages'},
    {'name': 'بوتیک هتل و هتل سنتی', 'id': 'hotels'},
    {'name': 'آب درمانی', 'id': 'hydrotherapy'}
  ];

  final List commentList = [
    {'name': 'بسیار عالی'},
    {'name': 'خوب'},
    {'name': 'متوسط'},
    {'name': 'ضعیف'},
    {'name': 'بسیار ضعیف'}
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
        'sortby': sortByToCode(),
        'page': 1,
        'num': 12,
        'minPrice': (rangeStart.value * 500000).toInt(),
        'maxPrice': (rangeEnd.value * 500000).toInt(),
        'cat': categoryIdFilter.value,
      }.map((key, value) => MapEntry(key, value.toString()));
      firstOpen.value = false;
      searchError.value = false;
      loading.value = true;
      if(specialPlacesFlag.value){
        url = Uri.parse('$mainUrl/landing/${specialPlace.value}/all-ecolodges').replace(queryParameters: body);
      }
      else if(cityFilter.value != ''){
        url = Uri.parse('$mainUrl/place/$cityUrlFilter/all-ecolodges').replace(queryParameters: body);
      }else{
        url = Uri.parse('$mainUrl/all_ecolodges').replace(queryParameters: body);
      }
      print(url);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        searchEcolodgesResult.clear();
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
      print('nextlink $nextLink');
      if( nextLink.value != 'null'){
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
    liveSearchLandingPagesResult.clear();
  }

  sortByToCode() {
    switch (sortByValue.value) {
      case 'پرفروش ترین':
        return 55;
      case 'بیشترین تخفیف':
        return 56;
      case 'پربازدیدترین':
        return 50;
      case 'محبوب ترین':
        return 51;
      case 'جدید ترین':
        return 52;
      case 'ارزان ترین':
        return 53;
      case 'گران ترین':
        return 54;
    }
  }

}
