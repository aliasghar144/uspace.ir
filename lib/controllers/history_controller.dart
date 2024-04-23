import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/constance/constance.dart';
import 'package:uspace_ir/controllers/user_controller.dart';
import 'package:uspace_ir/memory/memory.dart';
import 'package:uspace_ir/models/history_list_model.dart';

class HistoryController extends GetxController{


  @override
  void onInit() {
    if(Memory().readOrderCode() != null){
      fetchOrderHistory(Memory().readOrderCode());
    }
    super.onInit();
  }

  UserController userController = Get.find<UserController>();

  final formKey = GlobalKey<FormState>();

  TextEditingController orderCodeTextEditController = TextEditingController();

  RxBool loading = false.obs;

  RxList<HistoryListModel> orderHistory = <HistoryListModel>[].obs;

  fetchOrderHistory(String orderCode) async {
    try{
      loading.value = true;
      orderHistory.clear();
      print(Memory().readOrderCode());
      Uri url = Uri.parse('$mainUrl/customer/reserves/?tracking_code=$orderCode');
      var response = await http.get(url);
      if(response.statusCode == 200){
        final data = jsonDecode(response.body)['data'];
        orderHistory.addAll(historyListModelFromJson(jsonEncode(data)));
        orderHistory.sort((a, b) {
          if(a.miladiCheckIn.difference(b.miladiCheckIn) < const Duration(days: 1)){
            return -1;
          }else{
            return 1;
          }
        });
        Memory().saveOrderCode(orderCode);
        loading.value = false;
        return true;
      }else{
        Get.showSnackbar(
            GetSnackBar(
              backgroundColor: AppColors.redColor,
              duration: const Duration(seconds: 3),
              messageText: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text('کد رهگیری اشتباه است',style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color:Colors.white),textAlign: TextAlign.start)),
            ));
        loading.value = false;
        return false;
      }
    }catch(e){
      rethrow;
    }
  }

}