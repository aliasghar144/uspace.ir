import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uspace_ir/constance/constance.dart';
import 'package:http/http.dart' as http;
import 'package:uspace_ir/models/room_reservation_model.dart';

import '../app/utils/string_to_icon.dart';

class ReservationController extends GetxController {
  String url;

  ReservationController(this.url);

  @override
  void onInit(){
    getMainInfo(roomUrl: url);
    super.onInit();
  }

  ScrollController screenScrollController = ScrollController();

  RxBool userImages = false.obs;
  RxBool loading = true.obs;
  RxBool loadingRoom = false.obs;

  final room = Rxn<RoomReservationModel>();

  getMainInfo({
    required String roomUrl,
  }) async {
    print(url);
    try {
      loading.value = true;
      var url = Uri.parse('$mainUrl/ecolodge/$roomUrl');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        room.value = roomReservationModelFromJson(response.body);
        loading.value = false;
        print(room.value!.data.url);
      }
    } on SocketException {
      loading.value = false;
      print('socket');
    } catch (e) {
      loading.value = false;
      print(e);
    }
  }

  choseEntryDate() async {
    try {
      loadingRoom.value = true;
      String uri = '$mainUrl/ecolodge/$url/rooms?';
      if(isDateSelected.value != false) {
        uri += 'start_date=${entryDate.value.year.toString()}-${dateEdit(entryDate.value.month)}-${dateEdit(entryDate.value.day)}&pick_date=1&duration=${durationValue.value.toString()}';
      }else{
        uri += 'duration=${durationValue.value.toString()}';
      }
      var localUrl = Uri.parse(uri.toString());
      print(uri.runtimeType);
      print(localUrl.path);
      var response = await http.get(localUrl);
      if(response.statusCode == 200){
        room.value!.data.rooms.clear();
        print(jsonDecode(response.body)['data']);
        room.value!.data.rooms = List<Room>.from(jsonDecode(response.body)['data'].map((x) => Room.fromJson(x)));
        loadingRoom.value = false;
      }
    } catch (e) {
      loadingRoom.value = false;
      print('ERR======>$e');
    }
  }


  iconMaker(String? icon){
    print('its empty name $icon');
    if(icon == null){}else{
      icon = icon[0].toUpperCase() + icon.substring(1).toLowerCase();
      if(icon.startsWith('Fa')){
        icon = icon.replaceAll('-', '');
        print('without - is $icon');
        icon = icon.substring(2);
        print('without fa is $icon');
        icon = icon[0].toLowerCase() + icon.substring(1);
        print('last func is $icon');
      }
      return stringToIcons[icon];
    }
  }

  Map<String,IconData> icons = {
    'fa-toilet': FontAwesomeIcons.toilet
  };

  // IconData icon = FontAwesomeIcons();

  String dateEdit(int date){
    if( date > 10){
      return date.toString();
    }else{
      return '0$date';
    }
  }

  //#region  =============== Rooms =========================

  ScrollController roomSugestionController = ScrollController();

  Rx<DateTime> entryDate = DateTime.now().obs;
  RxBool isDateSelected = false.obs;

  final RxInt durationValue = 1.obs;

  final List<int> durationDropDownItems = [
    1,
    2,
    3,
    5,
    6,
  ];

  void setSelectedDuration(int value) {
    durationValue.value = value;
  }

  //#endregion  =============== Rooms =========================

  //#region =============== Details =======================

  RxInt tabIndex = 0.obs;

  //#endregion =============== Details =======================

  //#region =============== Comments =======================

  final List<File> selectedImages = <File>[].obs;
  final picker = ImagePicker();

  RxBool isTextFieldSelected = false.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController commentController = TextEditingController();


  //#endregion =============== Comments =======================


  RxBool isFave = false.obs;

  RxInt selectedPackageIndex = 100.obs;
  RxInt selectedPackageId = 100.obs;

  final PageController pageController = PageController();
}
