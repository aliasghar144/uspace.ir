import 'package:get/get.dart';
import 'package:uspace_ir/app/routes/constance_routes.dart';
import 'package:uspace_ir/base_screen.dart';
import 'package:uspace_ir/views/reservation/reservation_screen.dart';
import 'package:uspace_ir/views/reservation/reserve_room_screen.dart';

class Pages{

  final pages = [
    GetPage(name: Routes.home, page:() =>  BasePage(),/*middlewares: [AuthMiddleware()]*/),
    GetPage(name: Routes.reservation, page:() =>  ReservationScreen(),),
    GetPage(name: Routes.reserveRoom, page:() =>  RoomReservationScreen(),),
  ];

}