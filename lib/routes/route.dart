import 'package:get/get.dart';
import 'package:uspace_ir/base_screen.dart';
import 'package:uspace_ir/constance/constance.dart';
import 'package:uspace_ir/pages/auth/login/login_screen.dart';
import 'package:uspace_ir/pages/history/history_screen.dart';
import 'package:uspace_ir/pages/history/order_details_screen.dart';
import 'package:uspace_ir/pages/intro/intro_screen.dart';
import 'package:uspace_ir/pages/search/search_screen.dart';

class Routes {

  static const intro = '/intro';

  static const login = '/login';

  static const search = '/search';

  static const historyScreen = 'customer/reserves?tracking_code=';

  static const orderDetailsScreen = 'customer/reserves/:orderCode';

}

class Pages{

  final pages = [
    GetPage(name: Routes.historyScreen, page:() =>  HistoryScreen() /*middlewares: [AuthMiddleware()]*/),
    // GetPage(name: Routes.reservation, page:() =>  ReservationScreen(),),
    // GetPage(name: Routes.reserveRoom, page:() =>  RoomReservationScreen(),),
    GetPage(name: Routes.intro, page:() =>  IntroScreen(),),
    GetPage(name: Routes.orderDetailsScreen, page:() =>  OrderDetailsScreen(orderCode: orderCode),),
    GetPage(name: Routes.search, page:() =>  SearchScreen(),),
    GetPage(name: Routes.login, page:() =>  LoginScreen(),),
  ];

}