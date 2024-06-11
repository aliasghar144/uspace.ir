import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/constance/constance.dart';
import 'package:http/http.dart'as http;
import 'package:dio/dio.dart' as diopack;
import 'package:uspace_ir/models/order_model.dart';
import 'package:uspace_ir/pages/feedback/feedback_screen.dart';
import 'package:uspace_ir/pages/history/tickect_screen.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class OrderDetailsController extends GetxController{
  String orderCode;

  OrderDetailsController(this.orderCode);

  @override
  void onInit() {
    fetchOrderDetails(orderCode);
    super.onInit();
  }

  RxBool loading = false.obs;
  RxBool isAcceptTerms = false.obs;

  RxBool cancelingNeedCode = false.obs;


  //#region  =============== feedBack =========================

  final RxBool feedbackLoading = false.obs;

  final RxBool needFeedback = true.obs;

  final List<File> selectedImages = <File>[].obs;
  final picker = ImagePicker();

  RxInt alltotal = 1.obs;
  RxInt received = 0.obs;

  RxBool feedbackRulesShow = false.obs;

  RxBool anonymousUser = false.obs;

  TextEditingController feedbackTxtEditCtr = TextEditingController();

  RxInt option1 = 0.obs;
  RxInt option2 = 0.obs;
  RxInt option3 = 0.obs;
  RxInt option4 = 0.obs;
  RxInt option5 = 0.obs;

  List<int> feedbackPoint = [
    1,2,3,4,5,6,7,8,9,10
  ];


  sendFeedBack() async {
    feedbackLoading.value = true;
    final dio = diopack.Dio();
    late diopack.FormData formData;
    if(selectedImages.isEmpty){
      formData = diopack.FormData.fromMap({
        'tracking_code':orderCode,
        'option1':option5.value.toString(),
        'option2':option1.value.toString(),
        'option3':option2.value.toString(),
        'option4':option3.value.toString(),
        'option5':option4.value.toString(),
        'comment':feedbackTxtEditCtr.text,
        'anonymous_user':anonymousUser.value ? 1 : 0,
      });
    }else{
      formData = diopack.FormData.fromMap({
        'tracking_code':orderCode,
        'option1':option5.value.toString(),
        'option2':option1.value.toString(),
        'option3':option2.value.toString(),
        'option4':option3.value.toString(),
        'option5':option4.value.toString(),
        'comment':feedbackTxtEditCtr.text,
        'anonymous_user':anonymousUser.value ? 1 : 0,
        'files' : [
          for (var image in selectedImages)
            {
              await diopack.MultipartFile.fromFile(image.path,
                  filename: '${DateTime.now()}.${image.path.split('.').last}')
            }.toList()
        ]
    });
    }
    
    await dio.post('$mainUrl/customer/comments/new-comment',onSendProgress: (count,total){
      alltotal.value = total;
      received.value = count;
    },data: formData,).then((data){
      if(data.statusCode == 200){
        if(data.data['message'] == 200 || data.data['message'] == 'ok'){
          feedbackLoading.value = false;
          needFeedback.value = false;
          print('data from feedback is ${jsonDecode(data.data)}');
          Get.showSnackbar(
              GetSnackBar(
                backgroundColor: AppColors.mainColor,
                duration: const Duration(seconds: 3),
                messageText: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(data.data['details'],style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color:Colors.white),textAlign: TextAlign.start)),
              ));
        }else{
          Get.showSnackbar(
              GetSnackBar(
                backgroundColor: AppColors.redColor,
                duration: const Duration(seconds: 3),
                messageText: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(data.data['details'],style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color:Colors.white),textAlign: TextAlign.start)),
              ));
          feedbackLoading.value = false;
        }
      }
    });
    
  }

  feedBackCheck()async {

  }

  //#endregion  =============== feedBack =========================



  final order = Rxn<OrderDetailsModel>();

  final formKey = GlobalKey<FormState>();

  TextEditingController bankName = TextEditingController();
  TextEditingController shebaNum = TextEditingController();
  TextEditingController verifyCode = TextEditingController();
  TextEditingController cancelReason = TextEditingController();

  var cardNum = MaskedTextController(
    mask: '0000-0000-0000-0000',

  );


  void fetchOrderDetails(String orderCode) async {
    try{
      loading.value = true;
      Uri url = Uri.parse('$mainUrl/customer/reserves/$orderCode');
      var response = await http.get(url);
      if(response.statusCode == 200){
        // print(orderDetailsModelFromJson(response.body));
        order.value = orderDetailsModelFromJson(response.body);
        setCancelingNeedCode();
        loading.value = false;
      }

    }catch(e){
      print(e);
    }
  }

  void operation({required String  name, String? operation}) {
    switch(name){
      case 'پرداخت آنلاین':
        pay();
        break;
      case 'در انتظار تایید':
        cancelRsv();
        break;
      case 'انصراف از سفارش':
        cancelRsv(operation: operation);
        break;
      case 'عدم پرداخت':
        unpaid();
        break;
      case 'پرداخت و قطعی شده':
          ticketScreen();
      break;
      case 'فرم نظرسنجی':
        feedbackScreen();
        break;
      case 'کنسلی':
        cancelRsvReq();
        break;
      default:
        null;
    }
  }

  void pay() async {
    if(order.value!.data.pay.length>1){
      Get.bottomSheet(
          backgroundColor: Colors.white,
          elevation: 0,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23))),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20,),
              Text('انتخاب درگاه پرداخت',style: Theme.of(Get.context!).textTheme.displayMedium,),
              const SizedBox(height: 20,),
              Wrap(
                runSpacing: 10,spacing: 10,
                children: order.value!.data.pay.map((e) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: ()async{
                        final Uri url0 = Uri.parse(e.payLink);
                        if (!await launchUrl(url0,mode: LaunchMode.externalApplication,)) {
                          throw Exception('Could not launch $url0');
                        }
                      },
                      child: Container(
                        width: Get.width/5,
                        height: Get.width/5,
                        decoration:BoxDecoration(
                            border: Border.all(color: AppColors.mainColor,width: 0.4),
                            borderRadius:BorderRadius.circular(12)
                        ),
                        padding: const EdgeInsets.all(10),
                        child: CachedNetworkImage(
                          imageUrl:
                          e.logo,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) {
                            return Container(
                              clipBehavior: Clip.none,
                              width: Get.width / 3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.asset(
                                'assets/images/image_not_available.png',
                                fit: BoxFit.scaleDown,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Text(e.name,style: Theme.of(Get.context!).textTheme.bodyMedium)
                  ],
                )).toList(),
              ),
              const SizedBox(height: 30,),
            ],
          )
      );
    }else{
      final Uri url = Uri.parse(order.value!.data.pay[0].payLink);
      if (!await launchUrl(url,    mode: LaunchMode.externalNonBrowserApplication,
      ).then((value){
        print('value ========== $value');
        return true;
      })){
    }else{
    throw Exception('Could not launch $url');
    }
    }
  }

  void cancelRsv({String? operation}) async {
    try{
      late String uri;
      if(operation == null){
        uri = '$mainUrl/customer/reserves/$orderCode/customer-cancel-rsv';
      }else{
        uri = operation;
      }
      Uri url = Uri.parse(uri);

      var response = await http.post(url);

      if(response.statusCode == 200){
        // print(response.body);
        fetchOrderDetails(orderCode);
      }else{
        // print(jsonDecode(response.body));
      }
    }catch(e){
      print(e);
      rethrow;
    }
  }

  void cancelRsvReq() async {
    try{
      loading.value = true;
      Map<String,dynamic> body = {
        'sheba': shebaNum.text,
        'hesab':int.parse(cardNum.text.replaceAll('-', '')),
        'bank':bankName.text,
        'cancel_reason':cancelReason.text,
        'canceling_rules': true,
      };

      Uri url = Uri.parse('$mainUrl/customer/reserves/$orderCode/cancel-rsv-req');
      var response = await http.post(url,body: jsonEncode(body),headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      });
      if(response.statusCode == 200){

        var data = jsonDecode(response.body);
        loading.value = false;
        cancelingNeedCode.value = true;
        Get.showSnackbar(
            GetSnackBar(
              backgroundColor: AppColors.mainColor,
              duration: const Duration(seconds: 3),
              messageText: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(data['details'],style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color:Colors.white),textAlign: TextAlign.start)),
            ));
      }else{
        var data = jsonDecode(response.body);
        print('send has problem $data');
        Get.back();
        Get.showSnackbar(
            GetSnackBar(
              backgroundColor: AppColors.mainColor,
              duration: const Duration(seconds: 3),
              messageText: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(data['details'],style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color:Colors.white),textAlign: TextAlign.start)),
            ));
        loading.value = false;

      }
    }catch(e){
      Get.back();
      loading.value = false;
      print(e);
      rethrow;
    }
  }

  void verifyCancelRsvReq() async {
    try{
      loading.value = true;

      Map<String,dynamic> body = {
        'code': verifyCode.text,
      };

      Uri url = Uri.parse('$mainUrl/customer/reserves/$orderCode/verify-cancel-rsv-req');

      var response = await http.post(url,body: jsonEncode(body),headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      });

      var data = jsonDecode(response.body);
      // print(response.body);
      if(response.statusCode == 200){
        Get.back();
        Get.showSnackbar(
            GetSnackBar(
              backgroundColor: AppColors.mainColor,
              duration: const Duration(seconds: 3),
              messageText: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(data['details'],style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color:Colors.white),textAlign: TextAlign.start)),
            ));
        onInit();
        loading.value = false;
      }else{
        Get.showSnackbar(
            GetSnackBar(

              backgroundColor: AppColors.mainColor,
              duration: const Duration(seconds: 3),
              messageText: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(data['details'],style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color:Colors.white),textAlign: TextAlign.start)),
            ));
        loading.value = false;
      }

    }catch(e){
      Get.back();
      loading.value = false;
      rethrow;
    }

  }

  void unpaid() async{
    try{
      Uri url = Uri.parse('$mainUrl/customer/reserves/$orderCode/re-request-unpaid-rsv');
      var response = await http.post(url,headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      });
      if(response.statusCode == 200){
        fetchOrderDetails(orderCode);
        // print(jsonDecode(response.body));
      }else{
        // print(jsonDecode(response.body));
      }
    }catch(e){
      print(e);
      rethrow;
    }
  }

  void ticketScreen() {
    Get.to(TicketScreen(trackCode: orderCode,));
  }

  void feedbackScreen() {
    Get.to(FeedBackScreen());
  }

  void setCancelingNeedCode() {
    // print(order.value!.data.cancelInfo);
    if(order.value!.data.cancelInfo != null){
      cancelingNeedCode.value = true;
    }else{
      cancelingNeedCode.value = false;
    }
  }


}