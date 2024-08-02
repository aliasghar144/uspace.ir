import 'package:get/get.dart';
import 'package:uspace_ir/memory/memory.dart';
import 'package:uspace_ir/models/room_reservation_model.dart';

class UserController extends GetxController{

  @override
  void onInit(){
    if(Memory().readFavList() != null){

      favList.addAll(Memory().readFavList());
    }
    // Memory().readLikeDisLike();
    super.onInit();
  }


  RxBool favLoading = false.obs;
  RxList<String> favList = <String>[].obs;

  addToFav(RoomReservationModel room){
    final String fav = roomReservationModelToJson(room);
    favList.add(fav);
    Memory().saveFavList(favList);
  }

  removeFav(RoomReservationModel room){
    favList.removeWhere((element) {
      final RoomReservationModel index = roomReservationModelFromJson(element);
      if(index.data.url == room.data.url){
        Memory().saveFavList(favList);
        return true;
      }else{
        return false;
      }
    });
  }

}