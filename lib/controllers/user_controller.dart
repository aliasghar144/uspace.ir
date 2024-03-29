import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:uspace_ir/constance/constance.dart' as con ;
import 'package:uspace_ir/controllers/history_controller.dart';
class UserController extends GetxController{

  @override
  void onInit() async {
    var box = await Hive.openBox(con.userBox);
    print(box.get(con.userCart));
    if(box.get(con.userCart) != null){
      lastReserveCode.value = (box.get(con.userCart));
      HistoryController historyController = Get.find<HistoryController>();
      historyController.getOrderHistory(lastReserveCode.value);
    }
    super.onInit();
  }

  final RxString lastReserveCode = ''.obs;


}