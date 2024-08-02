import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uspace_ir/app/config/app_colors.dart';

class Errors{

  Widget imageError(){
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Text("image couldn't load !!!",style:TextStyle(fontWeight: FontWeight.w600,fontSize:15),textDirection: TextDirection.ltr,),
        SizedBox(height: 5),
        Icon(Icons.error,size:25,color:Colors.red),
      ],
    ));
  }

  SnackbarController connectLost({GestureTapCallback? onTap}){
    return Get.showSnackbar(
        GetSnackBar(
          backgroundColor: Colors.grey.shade200.withOpacity(0.8),
          isDismissible: false,
          padding: const EdgeInsets.only(right: 15,left: 25,bottom: 15,top: 10),
          messageText: Row(
            children: [
              InkWell(
                onTap: onTap,
                child: Row(
                  mainAxisSize:MainAxisSize.min,
                  children: [
                    Text('تلاش مجدد',style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(fontSize: 14),),
                    const SizedBox(width: 3,),
                    const Icon(Icons.refresh,size: 20,)
                  ],
                ),
              ),
              const Spacer(),
              Text('مشکل در برقراری ارتباط',style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(fontSize: 16),),
            ],
          ),
          onTap: (snack) {

          },
        ));
  }

  Future dialogErr({
    required GestureTapCallback onPress
}){
    return Get.defaultDialog(
      onWillPop: () async => false,

      barrierDismissible: false,
      titlePadding: const EdgeInsets.only(top: 15,bottom: 10),
      title: "مشکل در دریافت اطلاعات",
      titleStyle: const TextStyle(
        color:AppColors.mainColor,
        fontSize:18,fontWeight: FontWeight.w800,
      ),
      middleTextStyle: const TextStyle(fontSize: 16,fontWeight:FontWeight.w700),
      confirm: TextButton(onPressed: onPress, child: const Text('تلاش مجدد',style:TextStyle(fontSize:14,fontWeight:FontWeight.w700))),
    );
  }

}