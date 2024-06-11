import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uspace_ir/app/config/app_colors.dart';

class PayStatusScreen extends StatelessWidget {
  const PayStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // String? resCode = Get.parameters['orderCode'];
    // String? code = Get.parameters['payStatus'];
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Expanded(flex:1,child: SizedBox()),
            Container(
              padding: const EdgeInsets.all(10),
              width: Get.width/3,height: Get.width/3,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color:Colors.green
              ),
              child: const Expanded(child: FittedBox(
                  fit: BoxFit.fill,
                  child: Icon(Icons.done_rounded,color: Colors.white,))),
            ),
            // const SizedBox(height: 35,),
            Text('پرداخت شما با موفقیت انجام شد',style: Theme.of(Get.context!).textTheme.displayLarge!.copyWith(color: Colors.green.shade800),),
            // const Expanded(flex:2,child: SizedBox()),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0,right: 25,left: 25),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.redColor,
                      elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                    )
                  ),
                  onPressed: (){}, child: SizedBox(
                width: Get.width,
                height: 50,
                child: Align(
                    alignment: Alignment.center,
                    child: Text('بازگشت به صفحه سفارش',style: Theme.of(Get.context!).textTheme.displayLarge!.copyWith(fontSize: 20,color: Colors.white),)),
              )),
            )
          ],
        ),
      ),
    );
  }
}
