import 'package:get/get.dart';
import 'package:uspace_ir/base_screen.dart';
import 'package:uspace_ir/constance/constance.dart';
import 'package:uspace_ir/pages/auth/login/login_screen.dart';
import 'package:uspace_ir/pages/intro/intro_screen.dart';
import 'package:uspace_ir/pages/reservation/reservation_screen.dart';
import 'package:uspace_ir/pages/reservation/reserve_room_screen.dart';
import 'package:uspace_ir/pages/search/search_screen.dart';
import 'package:uspace_ir/pages/test.dart';


class Pages{

  final pages = [
    GetPage(name: Routes.home, page:() =>  BasePage(),/*middlewares: [AuthMiddleware()]*/),
    GetPage(name: Routes.reservation, page:() =>  ReservationScreen(),),
    GetPage(name: Routes.reserveRoom, page:() =>  RoomReservationScreen(),),
    GetPage(name: Routes.intro, page:() =>  IntroScreen(),),
    GetPage(name: Routes.search, page:() =>  SearchScreen(),),
    GetPage(name: Routes.login, page:() =>  LoginScreen(),),
    GetPage(name: Routes.test, page:() =>  TestScreen(),),
  ];

}