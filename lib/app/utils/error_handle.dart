import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    // return Get.dialog(
    //     Dialog(
    //       insetPadding: EdgeInsets.symmetric(horizontal: Get.width/3.5),
    //       shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(12)
    //       ),
    //       child: Container(
    //         decoration:const BoxDecoration(
    //           borderRadius:BorderRadius.all(Radius.circular(15)),
    //           color: Colors.white,
    //         ),
    //         child: Column(
    //           mainAxisSize:MainAxisSize.min,
    //           children: [
    //             const SizedBox(height: 10,),
    //             Text('خطا',style:Theme.of(Get.context!).textTheme.displayLarge!.copyWith(color:AppColors.redColor,fontSize: 20),textDirection: TextDirection.rtl,),
    //             const SizedBox(height: 15,),
    //             Text('مشکل در برقراری ارتباط',style:Theme.of(Get.context!).textTheme.bodyMedium),
    //             const SizedBox(height: 10,),
    //           ],
    //         ),
    //       ),
    //     ));
  }

}