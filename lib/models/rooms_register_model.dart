import 'package:flutter/material.dart';
import 'package:uspace_ir/models/room_reservation_model.dart';
import 'package:get/get.dart';

class RoomsRegisterModel{
  Room roomReservationModel;
  RxBool isExpanded = false.obs;
  RxInt additionalGuest = 0.obs;
  List<DropdownMenuItem<int>> additionalGuestList;

  RoomsRegisterModel({
    required this.roomReservationModel,
    required this.additionalGuestList,
});

}