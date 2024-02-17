import 'package:uspace_ir/models/room_reservation_model.dart';
import 'package:get/get.dart';

class RoomsRegisterModel{
  Room roomReservationModel;
  RxBool isExpanded = false.obs;
  int additionalGuest = 0;

  RoomsRegisterModel({
    required this.roomReservationModel,
});

}