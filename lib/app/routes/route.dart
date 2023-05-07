import 'package:get/get.dart';
import 'package:uspace_ir/app/routes/constance_routes.dart';
import 'package:uspace_ir/base_screen.dart';

class Pages{

  final pages = [
    GetPage(name: Routes.home, page:() =>  BasePage(),/*middlewares: [AuthMiddleware()]*/),
  ];

}