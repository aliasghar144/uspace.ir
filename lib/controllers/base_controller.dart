import 'package:get/get.dart';
import 'package:uspace_ir/app/utils/debouncer.dart';

class BaseController extends GetxController{

  final Debouncer debouncer = Debouncer(milliseconds: 500);

  var pageIndex = 3.obs;

}