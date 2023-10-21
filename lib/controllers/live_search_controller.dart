import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:uspace_ir/constance/constance.dart';
import 'package:uspace_ir/models/live_search_ecolodges_model.dart';
import 'package:uspace_ir/models/live_search_landing_model.dart';
import 'package:uspace_ir/models/live_search_places_model.dart';

class LiveSearchController extends GetxController{

  TextEditingController liveTextFieldController = TextEditingController();

  RxBool loading = false.obs;
  RxBool firstOpen = true.obs;

  List<LiveSearchEcolodgesModel> liveSearchEcolodgesResult = <LiveSearchEcolodgesModel>[].obs;
  List<LiveSearchPlacesModel> liveSearchPlacesResult = <LiveSearchPlacesModel>[].obs;
  List<LiveSearchLandingPagesModel> liveSearchLandingPagesResult = <LiveSearchLandingPagesModel>[].obs;

  liveSearch(String q)async{
    try{
      firstOpen.value = false;
      loading.value = true;
      var url = Uri.parse('$mainUrl/live-search').replace(queryParameters: {
        'q':q
      });
      var response = await http.get(url);
      if(response.statusCode == 200){

        liveSearchEcolodgesResult.clear();
        liveSearchPlacesResult.clear();
        liveSearchLandingPagesResult.clear();

        final ecolodges = jsonDecode(response.body)['ecolodges'];
        final place = jsonDecode(response.body)['places'];
        final landing  = jsonDecode(response.body)['landing_pages'];

        liveSearchEcolodgesResult.addAll(liveSearchEcolodgesModelFromJson(jsonEncode(ecolodges)));
        liveSearchLandingPagesResult.addAll(liveSearchLandingPagesModelFromJson(jsonEncode(landing)));
        liveSearchPlacesResult.addAll(liveSearchPlacesModelFromJson(jsonEncode(place)));

      }
      loading.value = false;
    }
    on SocketException {
      loading.value = false;
    }
    catch(e){
      loading.value = false;
      print(e);
    }
  }
}