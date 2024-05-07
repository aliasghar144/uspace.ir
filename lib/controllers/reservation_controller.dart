import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/app/utils/error_handle.dart';
import 'package:uspace_ir/base_screen.dart';
import 'package:uspace_ir/constance/constance.dart';
import 'package:uspace_ir/controllers/user_controller.dart';
import 'package:uspace_ir/models/room_reservation_model.dart';
import 'package:uspace_ir/routes/route.dart';

class ReservationController extends GetxController {
  String url;

  ReservationController(this.url);

  @override
  void onInit(){
    getMainInfo(roomUrl: url);


    // listen to user scroll
    // mainScrollController.addListener(() {
    //   // if(mainScrollController.position.pixels >= mainScrollController.position.minScrollExtent+100){
    //   //   tabIndex.value = 1;
    //   // }
    //   if(mainScrollController.position.pixels >= mainScrollController.position.maxScrollExtent/2.5){
    //     tabIndex.value = 2;
    //   }else{
    //     tabIndex.value = 1;
    //   }
    //   // if(mainScrollController.position.pixels >= mainScrollController.position.maxScrollExtent-100){
    //   //   tabIndex.value = 3;
    //   // }
    // });


    super.onInit();
  }

  ScrollController screenScrollController = ScrollController();
  ScrollController mainScrollController = ScrollController();

  UserController userController = Get.find<UserController>();

  RxDouble markerSized = 28.0.obs;

  RxBool userImages = false.obs;
  RxBool cancelingRules = false.obs;
  RxBool loading = true.obs;
  RxBool loadingRoom = false.obs;

  final room = Rxn<RoomReservationModel>();

  getMainInfo({
    required String roomUrl,
  }) async {
    try {
      loading.value = true;
      var url = Uri.parse('$mainUrl/ecolodge/$roomUrl');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        room.value = roomReservationModelFromJson(response.body);
        loading.value = false;
        print(room.value!.data.url);
      }else{
      }
    } on SocketException {
      Errors().connectLost(onTap: () {
        getMainInfo(roomUrl: roomUrl);
        Get.closeCurrentSnackbar();
      },);
    } catch (e) {
      loading.value = false;
      Get.offAllNamed(Routes.home);
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
        uri += 'start_date=${DateTime.now().year.toString()}-${dateEdit(DateTime.now().month)}-${dateEdit(DateTime.now().day)}&pick_date=1&duration=${durationValue.value.toString()}';
      }
      var localUrl = Uri.parse(uri.toString());
      print(localUrl.path);
      print(localUrl.queryParameters);
      var response = await http.get(localUrl);
      if(response.statusCode == 200){
        room.value!.data.rooms.clear();
        print(jsonDecode(response.body)['data']);
        room.value!.data.rooms = List<Room>.from(jsonDecode(response.body)['data'].map((x) => Room.fromJson(x)));
        loadingRoom.value = false;
      }
    }
    on SocketException{
      Errors().connectLost(onTap: () {
        choseEntryDate();
        Get.closeCurrentSnackbar();
      },);
    }
    catch (e) {
      loadingRoom.value = false;
      print(e);
      Get.offAll(BaseScreen());
    }
  }

  String roomAvailabilityCheck(String availability){
    switch(availability){
      case 'available':
        return 'موجود';
      case 'inquiry':
        return 'نیازمند استعلام';
      case 'unavailable':
        return 'ناموجود';
      default: return '';
    }
  }

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

  //#region =============== Tabs =======================
  RxInt tabIndex = 1.obs;

  var key1 = GlobalKey();
  var key2 = GlobalKey();
  var key3 = GlobalKey();

  //#endregion =============== Tabs =======================

  //#region =============== Comments =======================

  final List<File> selectedImages = <File>[].obs;
  final picker = ImagePicker();

  RxBool isTextFieldSelected = false.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  sendReply()async{
    try{
      loadingRoom.value = true;
      Uri url = Uri.parse('https://api.uspace.ir/api/p_u_api/v1/comments/new-comment');
      Map<String,String> body = {
        'name':nameController.text,
        'comment':commentController.text,
        'email':emailController.text,
        'best_url':'test',
      };
      var response = await http.post(url,body: body,headers: {
        'Accept':'application/json'
      });
      if(response.statusCode == 200){
        Get.back();
        Get.showSnackbar(
            GetSnackBar(
              backgroundColor: AppColors.mainColor,
              duration: const Duration(seconds: 3),
              messageText: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(jsonDecode(response.body)['details'],style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color:Colors.white),textAlign: TextAlign.start)),

            ));
      }else{
    throw response.body;
    }}catch(e){
      Get.offAll(BaseScreen());
      throw 'ERR = $e';
    }
  }
  //#endregion =============== Comments =======================

  final PageController pageController = PageController();

}
