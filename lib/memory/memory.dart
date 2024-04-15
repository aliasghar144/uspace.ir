import 'package:hive/hive.dart';
import 'package:uspace_ir/constance/constance.dart';
class Memory{

  final box =  Hive.box(userBox);

  saveOrderCode(String orderCode){
    box.put(userOrderCode, orderCode);
  }

  readOrderCode(){
    return box.get(userOrderCode);
  }

  saveFavList(List<String> list){
    box.put(favList,list);
  }

  readFavList(){
    return box.get(favList);
  }

}