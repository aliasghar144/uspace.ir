import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/controllers/order_details_controller.dart';
import 'package:uspace_ir/pages/history/canceling_screen.dart';

class RulesOfCancelingScreen extends StatelessWidget {
  RulesOfCancelingScreen({Key? key}) : super(key: key);

  final OrderDetailsController orderDetailsCtr = Get.find<OrderDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 35,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('قوانین کنسلینگ',style: Theme.of(Get.context!).textTheme.displayLarge!.copyWith(
                      color: AppColors.redColor.withOpacity(0.8),
                    ),),
                    const SizedBox(width: 10,),
                    Icon(
                      FontAwesomeIcons.listCheck,
                      color: AppColors.redColor.withOpacity(0.8),
                    )
                  ],
                ),
                const SizedBox(height: 25,),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.redColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      const SizedBox(height: 15,),
                      Row(
                        children: [
                          Expanded(child: Text('تنها سفارشاتی که پرداخت و قطعی شده، قابل لغو می باشند.',style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(fontSize: 14.sp,color: const Color(0xff721c24)),textDirection: TextDirection.rtl,)),
                          const SizedBox(width: 10,),
                          Container(width: 13,height: 13,decoration: const BoxDecoration(
                              color: Color(0xff721c24),shape: BoxShape.circle
                          ),),
                        ],
                      ),
                      const SizedBox(height: 25,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: Text('شرایط کنسل رزروهای قطعی و میزان عودت وجه با توجه به نوع خدمت تقاضا شده متفاوت خواهد بود. علاوه بر این، کارمزد کنسلی برای یواسپیس حداقل، 10 درصد می باشد.',style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(fontSize: 14.sp,color: const Color(0xff721c24)),textDirection: TextDirection.rtl,)),
                          const SizedBox(width: 5,),
                          Container(width: 13,height: 13,decoration: const BoxDecoration(
                              color: Color(0xff721c24),shape: BoxShape.circle
                          ),),
                        ],
                      ),
                      const SizedBox(height: 25,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: Text('فرم لغو سفارش شما تا ساعت 12 شب روز قبل از شروع رزرو فعال است که با توجه به زمان لغو سفارش کارمزد کنسلی متفاوت خواهد بود.',style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(fontSize: 14.sp,color: const Color(0xff721c24)),textDirection: TextDirection.rtl,)),
                          const SizedBox(width: 5,),
                          Container(width: 13,height: 13,decoration: const BoxDecoration(
                              color: Color(0xff721c24),shape: BoxShape.circle
                          ),),
                        ],
                      ),
                      const SizedBox(height: 25,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: Text('مشتری عزیز توجه داشته باشید که شماره حساب اعلام شده باید به نام شخص رزرو کننده سفارش باشد.',style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(fontSize: 14.sp,color: const Color(0xff721c24)),textDirection: TextDirection.rtl,)),
                          const SizedBox(width: 5,),
                          Container(width: 13,height: 13,decoration: const BoxDecoration(
                              color: Color(0xff721c24),shape: BoxShape.circle
                          ),),
                        ],
                      ),
                      const SizedBox(height: 25,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: Text('پس از ثبت درخواست رزرو و تایید آن، مبلغ باز پرداختی به شما ظرف مدت 24 تا 72 ساعت کاری (پس از بازپرداخت هزینه توسط اقامتگاه) به حساب شما عودت داده خواهد شد.',style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(fontSize: 14.sp,color: const Color(0xff721c24)),textDirection: TextDirection.rtl,)),
                          const SizedBox(width: 5,),
                          Container(width: 13,height: 13,decoration: const BoxDecoration(
                              color: Color(0xff721c24),shape: BoxShape.circle
                          ),),
                        ],
                      ),
                      const SizedBox(height: 15,),
                    ],
                  ),
                ),
                const SizedBox(height: 25,),
                Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text('قوانین کنسلی را مطالعه و میپذیرم',style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(fontSize: 15.sp,color: Colors.black),),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      orderDetailsCtr.isAcceptTerms.toggle();
                    },
                    borderRadius: BorderRadius.circular(100),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
                      child: Obx(() => Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: orderDetailsCtr.isAcceptTerms.value ? AppColors.mainColor : AppColors.grayColor.withOpacity(0.7), boxShadow: [orderDetailsCtr.isAcceptTerms.value ? BoxShadow(color: AppColors.mainColor.withOpacity(0.1), spreadRadius: 6, blurRadius: 0.1) : BoxShadow(color: AppColors.mainColor.withOpacity(0.1), spreadRadius: 6, blurRadius: 0.1)]),
                      )),
                    ),
                  ),
                ])
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() =>             ElevatedButton(
                onPressed: !orderDetailsCtr.isAcceptTerms.value ? null : () {
                  orderDetailsCtr.isAcceptTerms.value = false;
                  Get.off(CancelingScreen(),transition: Transition.downToUp);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: !orderDetailsCtr.isAcceptTerms.value ? Colors.transparent : Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: !orderDetailsCtr.isAcceptTerms.value ? const BorderSide(width: 0.0,color: Colors.white) : const BorderSide(color: Color(0xffd9534f),width: 0.6)

                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'لغو سفارش',
                        style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(fontSize: 18.sp, color: !orderDetailsCtr.isAcceptTerms.value ? Colors.grey : const Color(0xffd9534f).withOpacity(0.9)),
                      ),
                      const SizedBox(width: 5,),
                      Icon(Icons.remove_shopping_cart_outlined,color: !orderDetailsCtr.isAcceptTerms.value ? Colors.grey : const Color(0xffd9534f),size: 18,),
                    ],
                  ),
                ))),
          ],
        ),
      ),
    );
  }
}
