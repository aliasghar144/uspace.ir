import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/constance/constance.dart';
import 'package:http/http.dart'as http;
import 'package:uspace_ir/models/order_model.dart';
import 'package:uspace_ir/pages/history/history_screen.dart';
import 'package:uspace_ir/pages/history/order_details_screen.dart';
import 'package:uspace_ir/pages/history/rules_of_canceling_screen.dart';
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
        print(orderDetailsModelFromJson(response.body));
        order.value = orderDetailsModelFromJson(response.body);
        loading.value = false;
      }

    }catch(e){
      print(e);
    }
  }

  void operation(String name) {
    switch(name){
      case 'پرداخت آنلاین':
        pay();
        break;
      case 'در انتظار تایید':
        cancelRsv();
        break;
      case 'انصراف از سفارش':
        unpaid();
        break;
      case 'عدم پرداخت':
        unpaid();
        break;
      case 'پرداخت و قطعی شده':
        ticketScreen();
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

  void cancelRsv() async {
    try{
      Uri url = Uri.parse('$mainUrl/customer/reserves/$orderCode/customer-cancel-rsv');
      var response = await http.post(url);
      if(response.statusCode == 200){
        onInit();
      }
    }catch(e){
      rethrow;
    }
  }

  void cancelRsvReq() async {
    try{
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

        cancelingNeedCode.value = true;

        Get.showSnackbar(
            GetSnackBar(
              backgroundColor: AppColors.mainColor,
              duration: const Duration(seconds: 3),
              messageText: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(data['details'],style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color:Colors.white),textAlign: TextAlign.start)),
            ));
      }
    }catch(e){
      rethrow;
    }
  }

  void verifyCancelRsvReq() async {
    try{

      Map<String,dynamic> body = {
        'code': verifyCode.text,
      };

      Uri url = Uri.parse('$mainUrl/customer/reserves/$orderCode/verify-cancel-rsv-req');

      var response = await http.post(url,body: jsonEncode(body),headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      });

      print(response.body);
      if(response.statusCode == 200){

        Get.off(HistoryScreen());
      }

    }catch(e){
      rethrow;
    }

  }

  void unpaid() async{
    try{
      Uri url = Uri.parse('$mainUrl/customer/reserves/$orderCode/re-request-unpaid-rsv');
      var response = await http.post(url);
      if(response.statusCode == 200){
        onInit();
      }
    }catch(e){
      rethrow;
    }
  }

  void ticketScreen() {
    Get.to(TicketScreen(trackCode: orderCode,));
  }


}