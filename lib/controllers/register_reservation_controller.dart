import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/app/utils/error_handle.dart';
import 'package:uspace_ir/base_screen.dart';
import 'package:uspace_ir/constance/constance.dart';
import 'package:uspace_ir/controllers/history_controller.dart';
import 'package:uspace_ir/memory/memory.dart';
import 'package:uspace_ir/models/room_reservation_model.dart';
import 'package:uspace_ir/models/rooms_register_model.dart';

class RegisterReservationController extends GetxController{

  late String roomUrl;
  late Rx<DateTime> reserveDate;
  late int duration;
  late List<Room> room;
  RegisterReservationController({required this.roomUrl, required this.reserveDate, required this.duration, required this.room});

  @override
  void onInit() {
    addRoom(room);
    super.onInit();
  }

  final formKey = GlobalKey<FormState>();



  RxList<RoomsRegisterModel> roomRegisterList = <RoomsRegisterModel>[].obs;

  RxBool isTextFieldSelected = false.obs;
  RxBool cancelingRules = false.obs;
  RxBool loading = false.obs;


  void booking() async{
    try{
      loading.value = true;

      //loading
      showDialog(context: Get.context!, builder: (context) {
        return WillPopScope(child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Align(child: CircularProgressIndicator(color: AppColors.mainColor,),),
            ],
          ),
        ), onWillPop: () async => !loading.value,);
      },);


      List reserveItems = [];

      for(RoomsRegisterModel room in roomRegisterList){
      reserveItems.add({
        'sid':room.roomReservationModel.idRoom.toString(),
        'package_id':room.roomReservationModel.roomPackages[0].finance.priceInfo.idSalesPackage.toString(),
        'additional_guest': room.additionalGuest.value.toString()
      });}


      Map<String,dynamic> body = {
        'name': nameController.text,
        'mobile': phoneNumberController.text,
        'phone': homeNumberController.text,
        'emial': emailController.text,
        'url': roomUrl,
        'terms': isAcceptTerms.value.toString(),
        'check_in': '${reserveDate.value.year.toString()}-${reserveDate.value.month.toString()}-${reserveDate.value.day.toString()}',
        'duration': duration.toString(),
        'reserve_items': reserveItems
      };


      Uri url = Uri.parse('$mainUrl/booking');

      final http.Response response = await http.post(url,body: jsonEncode(body),headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      });


      if(response.statusCode == 200){
        var data = jsonDecode(response.body);

        if(data['message'] == 'ok'){
          loading.value = false;

          HistoryController historyController = Get.find<HistoryController>();

          historyController.fetchOrderHistory(data['data']['tracking_code']);

          // save order code on storage
          Memory().saveOrderCode((data['data']['tracking_code']));


          Get.offAll(BaseScreen());
          Get.showSnackbar(
              GetSnackBar(
                backgroundColor: AppColors.mainColor,
                duration: const Duration(seconds: 3),
                messageText: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(data['details'],style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color:Colors.white),textAlign: TextAlign.start)),
              ));
        }

        if(data['message'] == 'error'){
          loading.value = false;

          Get.offAll(BaseScreen());
          Get.showSnackbar(
              GetSnackBar(
                backgroundColor: AppColors.redColor,
                duration: const Duration(seconds: 3),
                messageText: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(data['details'],style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color:Colors.white),textAlign: TextAlign.start)),

              ));
        }
      }
    }
    on SocketException{
      Errors().connectLost(onTap: () {
        booking();
        Get.closeCurrentSnackbar();
      },);
    }
    catch(e){
      Get.offAll(BaseScreen());
      rethrow;
    }
  }


  RxBool reserveCheck(int idPackage) {
    for(RoomsRegisterModel room in roomRegisterList){
      if(room.roomReservationModel.roomPackages[0].finance.priceInfo.idSalesPackage == idPackage){
        return false.obs;
      }
    }
    return true.obs;
  }

  //#region ================ Booker Details ========================

  final RxBool nameTextFieldSelected = false.obs;
  final RxBool isAcceptTerms = false.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController homeNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  var cancellationConditionValue = 'شرایط کنسلی'.obs;
  var babyRoleDropDownValue = 'قوانین خردسالان'.obs;

  void addRoom(List<Room> roomList) {
    for(Room room in roomList){
      List<DropdownMenuItem<int>> list = [];
      list.add(DropdownMenuItem(
          value: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RichText(
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.rtl,
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'بدون نفر اضافی',
                      style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: AppColors.mainColor),
                    ),
                  ])),
            ],
          )));
      if(room.roomPackages[0].finance.priceInfo.additionalNumber!=0){
          for(int i = 1 ; i<=room.roomPackages[0].finance.priceInfo.additionalNumber ; i++){
            list.add(DropdownMenuItem(
                value: i,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                      overflow: TextOverflow.ellipsis,
                        textDirection: TextDirection.rtl,
                        text: TextSpan(children: [
                          TextSpan(
                            text: '$i ',
                            style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: AppColors.mainColor),
                          ),
                          TextSpan(
                            text: 'نفر',
                            style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: AppColors.mainColor),
                          ),
                        ])),
                  ],
                )));
          }
          roomRegisterList.add(RoomsRegisterModel(roomReservationModel: room,additionalGuestList: list));
      }else{
        roomRegisterList.add(RoomsRegisterModel(roomReservationModel: room,additionalGuestList: list));
      }
    }
  }

//#endregion ================ Booker Details ========================



}