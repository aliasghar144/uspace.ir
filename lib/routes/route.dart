import 'package:get/get.dart';
import 'package:uspace_ir/base_screen.dart';
import 'package:uspace_ir/pages/auth/login/login_screen.dart';
import 'package:uspace_ir/pages/history/order_details_screen.dart';
import 'package:uspace_ir/pages/reservation/reservation_screen.dart';
import 'package:uspace_ir/pages/search/search_screen.dart';

class Routes {

  static const intro = '/intro';

  static const login = '/login';

  static const home = '/home';

  static const search = '/search';

  static const historyScreen = '$home/customer/reserves?tracking_code=';

  static const reservationScreen = '$home/reservation';

  static const orderDetailsScreen = '$home/customer/reserves';


  static const statusPayScreen = '$home/customer/reserves';

}

class Pages{

  final pages = [
    GetPage(name: Routes.home, page:() =>  BaseScreen(),/*middlewares: [AuthMiddleware()]*/
    ),

    // GetPage(name: Routes.reservation, page:() =>  ReservationScreen(),),
    // GetPage(name: Routes.reserveRoom, page:() =>  RoomReservationScreen(),),

    GetPage(name: '${Routes.reservationScreen}/:url', page:() =>  ReservationScreen(),),

    GetPage(name: '${Routes.orderDetailsScreen}/:orderCode', page:() =>  OrderDetailsScreen(),),

    // GetPage(name: '${Routes.statusPayScreen}/:orderCode/:payStatus', page:() =>  PayStatusScreen(),),

    GetPage(name: Routes.search, page:() =>  SearchScreen(),),
    GetPage(name: Routes.login, page:() =>  LoginScreen(),),
  ];

}