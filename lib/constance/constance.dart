import 'package:get/get.dart';

String mainUrl = 'https://api.uspace.ir/api/p_u_api/v1';

String userCart = 'userCart';
String userBox = 'userBox';

RxBool connectError = false.obs;

class Routes {

  static const intro = '/intro';

  static const login = '/login';

  static const home = '/home';
  static const search = '/search';

  static const reservation = '$home/reservation';
  static const reserveRoom = '$reservation/reserveRoom';

}