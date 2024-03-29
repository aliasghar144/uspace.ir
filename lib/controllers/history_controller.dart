import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/constance/constance.dart';
import 'package:uspace_ir/controllers/user_controller.dart';
import 'package:uspace_ir/models/order_model.dart';
class HistoryController extends GetxController{

  UserController userController = Get.find<UserController>();

  final formKey = GlobalKey<FormState>();

  TextEditingController orderCodeTextEditController = TextEditingController();

  RxBool loading = false.obs;

  RxList<OrderModel> orderHistory = <OrderModel>[].obs;

  getOrderHistory(String orderCode)async{
    try{
      loading.value = true;
      Uri url = Uri.parse('$mainUrl/customer/reserves/?tracking_code=$orderCode');
      var response = await http.get(url);
      if(response.statusCode == 200){
        orderHistory.add(orderModelFromJson(response.body));
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

  Future<bool> fetchOrder(String statusCode)async{
    try{
      loading.value = true;
      Uri url = Uri.parse('$mainUrl/customer/reserves/$statusCode');
      var response = await http.get(url);
      if(response.statusCode == 200){
        orderHistory.add(orderModelFromJson(response.body));
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