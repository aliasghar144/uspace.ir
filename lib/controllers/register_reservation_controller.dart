import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uspace_ir/models/room_reservation_model.dart';
import 'package:uspace_ir/models/rooms_register_model.dart';

class RegisterReservationController extends GetxController{


  RxList<RoomsRegisterModel> roomRegisterList = <RoomsRegisterModel>[].obs;

  RxBool isTextFieldSelected = false.obs;

  //#region ================ Booker Details ========================

  final RxBool nameTextFieldSelected = false.obs;
  final RxBool isAcceptTerms = false.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController homeNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  var cancellationConditionValue = 'شرایط کنسلی'.obs;
  var babyRoleDropDownValue = 'قوانین خردسالان'.obs;

  var cancellationConditionItems = [
    'شرایط کنسلی',
    'دلیل 1',
    'دلیل 2',
    'دلیل 3',
  ];

  var babyRoleDropDownItems = [
    'قوانین خردسالان',
    '2قوانین خردسالان',
    'قوانین خردسالان3',
    'قوانین خردسالان4',
  ];

  void addRoom(List<Room> roomList) {
    for(Room room in roomList){
      roomRegisterList.add(RoomsRegisterModel(roomReservationModel: room));
    }
  }



//#endregion ================ Booker Details ========================

}