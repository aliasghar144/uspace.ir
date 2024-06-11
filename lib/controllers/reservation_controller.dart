import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/app/utils/error_handle.dart';
import 'package:uspace_ir/base_screen.dart';
import 'package:uspace_ir/constance/constance.dart';
import 'package:uspace_ir/controllers/user_controller.dart';
import 'package:uspace_ir/models/comment_model.dart';
import 'package:uspace_ir/models/room_reservation_model.dart';
import 'package:uspace_ir/routes/route.dart';

class ReservationController extends GetxController {
  String url;

  ReservationController(this.url);

  @override
  void onInit(){
    getMainInfo(roomUrl: url);
    //declare global key

    // pass it to the desired widget in a widget tree

    //call _getChildSize method, this should return the size of above SizedBox. Make sure to call this method after the first frame

    //   mainScrollController.addListener(() {
    //
    //   // if(mainScrollController.position.pixels >= mainScrollController.position.minScrollExtent+100){
    //   //   tabIndex.value = 1;
    //   // }
    //   // if(mainScrollController.position.pixels >= mainScrollController.position.maxScrollExtent/2.5){
    //   //   tabIndex.value = 2;
    //   // }
    //   // if(mainScrollController.position.pixels >= mainScrollController.position.maxScrollExtent-100){
    //   //   tabIndex.value = 3;
    //   // }
    // });

    super.onInit();
  }


  ScrollController screenScrollController = ScrollController();
  ScrollController mainScrollController = ScrollController();

  UserController userController = Get.find<UserController>();

  RxDouble markerSized = 28.0.obs;

  RxBool userImages = false.obs;
  RxBool cancelingRules = false.obs;
  RxBool loading = true.obs;
  RxBool loadingRoom = false.obs;

  final room = Rxn<RoomReservationModel>();

  getMainInfo({
    required String roomUrl,
  }) async {
    try {
      loading.value = true;
      var url = Uri.parse('$mainUrl/ecolodge/$roomUrl');
      var response = await http.get(url);
      loadMoreComment();
      if (response.statusCode == 200) {
        room.value = roomReservationModelFromJson(response.body);
        loading.value = false;
        // print(room.value!.data.url);
      }else{
      }
    } on SocketException {
      Errors().connectLost(onTap: () {
        getMainInfo(roomUrl: roomUrl);
        Get.closeCurrentSnackbar();
      },);
    } catch (e) {
      loading.value = false;
      Get.offAllNamed(Routes.home);
      print(e);
    }
  }

  choseEntryDate() async {
    try {
      loadingRoom.value = true;
      String uri = '$mainUrl/ecolodge/$url/rooms?';
      if(isDateSelected.value != false) {
        uri += 'start_date=${entryDate.value.year.toString()}-${dateEdit(entryDate.value.month)}-${dateEdit(entryDate.value.day)}&pick_date=1&duration=${durationValue.value.toString()}';
      }else{
        uri += 'start_date=${DateTime.now().year.toString()}-${dateEdit(DateTime.now().month)}-${dateEdit(DateTime.now().day)}&pick_date=1&duration=${durationValue.value.toString()}';
      }
      var localUrl = Uri.parse(uri.toString());
      // print(localUrl.path);
      // print(localUrl.queryParameters);
      var response = await http.get(localUrl);
      if(response.statusCode == 200){
        room.value!.data.rooms.clear();
        // print(jsonDecode(response.body)['data']);
        room.value!.data.rooms = List<Room>.from(jsonDecode(response.body)['data'].map((x) => Room.fromJson(x)));
        loadingRoom.value = false;
      }
    }
    on SocketException{
      Errors().connectLost(onTap: () {
        choseEntryDate();
        Get.closeCurrentSnackbar();
      },);
    }
    catch (e) {
      loadingRoom.value = false;
      print(e);
      Get.offAll(BaseScreen());
    }
  }

  String roomAvailabilityCheck(String availability){
    switch(availability){
      case 'available':
        return 'موجود';
      case 'inquiry':
        return 'نیازمند استعلام';
      case 'unavailable':
        return 'ناموجود';
      default: return '';
    }
  }

  String dateEdit(int date){
    if( date > 10){
      return date.toString();
    }else{
      return '0$date';
    }
  }


  //#region  =============== Rooms =========================

  ScrollController roomSugestionController = ScrollController();

  Rx<DateTime> entryDate = DateTime.now().obs;

  RxBool isDateSelected = false.obs;

  final RxInt durationValue = 1.obs;

  final List<int> durationDropDownItems = [
    1,
    2,
    3,
    5,
    6,
  ];

  void setSelectedDuration(int value) {
    durationValue.value = value;
  }

  //#endregion  =============== Rooms =========================

  //#region =============== Tabs =======================
  RxInt tabIndex = 1.obs;

  var key1 = GlobalKey();
  var key2 = GlobalKey();
  var key3 = GlobalKey();

  //#endregion =============== Tabs =======================

  //#region =============== Comments =======================

  final RxBool likeDislikeLoading = false.obs;

  final RxInt commentsPages = 1.obs;
  final RxBool loadMore = false.obs;
  final RxBool hasMoreComment = true.obs;

  final List<Comment> commentList = <Comment>[].obs;
  final List<String> likedComment = <String>[].obs;
  final List<String> dislikedComment = <String>[].obs;


  final List<File> selectedImages = <File>[].obs;
  final picker = ImagePicker();

  RxBool isTextFieldSelected = false.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  loadMoreComment() async {
    try {
      loadMore.value = true;
      var uri = Uri.parse('$mainUrl/ecolodge/$url/comments?page=${commentsPages.value.toString()}');
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        if(jsonDecode(response.body)['data'].isNotEmpty){
          commentList.addAll(List<Comment>.from(jsonDecode((response.body))['data'].map((x) => Comment.fromJson(x))));
        }else{
          commentsPages.value -= 1;
          hasMoreComment.value = false;
        }
        loadMore.value = false;
      }else{
      }
    } on SocketException {
      Errors().connectLost(onTap: () {
        getMainInfo(roomUrl: url);
        Get.closeCurrentSnackbar();
      },);
    } catch (e) {
      loadMore.value = false;
      Get.offAllNamed(Routes.home);
      print(e);
    }
  }

  sendReply()async{
    try{
      Uri url = Uri.parse('https://api.uspace.ir/api/p_u_api/v1/comments/new-comment');
      Map<String,String> body = {
        'name':nameController.text,
        'comment':commentController.text,
        'email':emailController.text,
        'best_url':'test',
      };
      var response = await http.post(url,body: body,headers: {
        'Accept':'application/json'
      });
      if(response.statusCode == 200){
        Get.back();
        Get.showSnackbar(
            GetSnackBar(
              backgroundColor: AppColors.mainColor,
              duration: const Duration(seconds: 3),
              messageText: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(jsonDecode(response.body)['details'],style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color:Colors.white),textAlign: TextAlign.start)),

            ));
      }else{
    throw response.body;
    }}catch(e){
      Get.offAll(BaseScreen());
      throw 'ERR = $e';
    }
  }

  likeLocal(String id){
    //
    ////    at the first need check likedComment
    //
    if(likedComment.contains(id)){

      //if exist in likedComment that mean we need to unlike comment
      likedComment.removeWhere((element) => element == id);
      int index = commentList.indexWhere((element) => element.id == id);
      // commentList[index].like.value = false;
      commentList[index].likes.value -= 1;

    }else{

      //
      ////   check if in dislikedList remove from that
      //

      if(dislikedComment.contains(id)){
        dislikedComment.removeWhere((element) => element == id);
        int index = commentList.indexWhere((element) => element.id == id);
        commentList[index].dislikes.value -= 1;
        // commentList[index].dislike.value = false;
      }

      //
      ////   after deleted from dislikeList  add comment to liked
      //

      likedComment.add(id);
      int index = commentList.indexWhere((element) => element.id == id);
      // commentList[index].like.value = true;
      commentList[index].likes.value += 1;

    }
  }

  dislikeLocal(String id){
    //
    ////    at the first need check likedComment
    //
    if(dislikedComment.contains(id)){

      print('check here');
      //if exist in likedComment that mean we need to unlike comment
      dislikedComment.removeWhere((element) => element == id);
      int index = commentList.indexWhere((element) => element.id == id);
      // commentList[index].dislike.value = false;
      commentList[index].dislikes.value -= 1;

    }else{

      //
      ////   check if in dislikedList remove from that
      //

      if(likedComment.contains(id)){
        likedComment.removeWhere((element) => element == id);
        int index = commentList.indexWhere((element) => element.id == id);
        commentList[index].likes.value -= 1;
        // commentList[index].like.value = false;
      }

      //
      ////   after deleted from dislikeList  add comment to liked
      //

      dislikedComment.add(id);
      int index = commentList.indexWhere((element) => element.id == id);
      // commentList[index].dislike.value = true;
      commentList[index].dislikes.value += 1;
    }
  }

  void likeApi({required String id,required String commentType,required int index}) async {
    try{
      likeDislikeLoading.value = true;

      Map<String,dynamic> body = {
        'type': 'like',
        'comment_type': commentType,
        'comment_id':id,
      };

      Uri url = Uri.parse('$mainUrl/comment/like-dislike');

      var response = await http.post(url,body: jsonEncode(body),headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      });

      if(response.statusCode == 200){
        print(response.body);
        if(response.body == 'vote save.') {
          commentList[index].likes.value += 1;
          likeDislikeLoading.value = false;

        }

      }else{
        print(response.body);
        likeDislikeLoading.value = false;
      }
    }catch(e){
      rethrow;
    }
  }


  void dislikeApi({required String id,required String commentType,required int index}) async {
    try{
      likeDislikeLoading.value = true;

      Map<String,dynamic> body = {
        'type': 'dislike',
        'comment_type': commentType,
        'comment_id':id,
      };

      Uri url = Uri.parse('$mainUrl/comment/like-dislike');

      var response = await http.post(url,body: jsonEncode(body),headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      });

      if(response.statusCode == 200){


        if(response.body == 'vote save.') {
          commentList[index].dislikes.value += 1;
          likeDislikeLoading.value = false;
        }


      }else{

        likeDislikeLoading.value = false;

      }
    }catch(e){
      rethrow;
    }
  }



  RxBool checkCommentId(String id) {
    for(String comment in dislikedComment){
      if(id == comment) {
        return true.obs;
      }
    }
    return false.obs;
  }

  //#endregion =============== Comments =======================

  final PageController pageController = PageController();

  favChecker(){
    for(String fav in userController.favList){
      RoomReservationModel room = roomReservationModelFromJson(fav);
      if(url == room.data.url){
        return true.obs;
      }
    }
    return false.obs;
  }




}
