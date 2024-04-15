import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/controllers/order_details_controller.dart';

class CancelingScreen extends StatelessWidget {
  CancelingScreen({Key? key}) : super(key: key);

  final OrderDetailsController mainController = Get.find<OrderDetailsController>();


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        return FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Form(
        key: mainController.formKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25))),
            leading: Padding(
              padding: const EdgeInsets.only(left: 20, top: 15.0),
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                splashRadius: 20,
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.grey,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 15.0),
                child: IconButton(
                  splashRadius: 20,
                  icon: SvgPicture.asset('assets/icons/bell_ic.svg'),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('فرم کنسلی اقامتگاه',style: Theme.of(Get.context!).textTheme.displayLarge!.copyWith(
                      color: Colors.black,
                    ),)
                  ],
                ),
                const SizedBox(height: 5,),
                Text('لطفا مشخصات مورد نیاز را در قسمت زیر وارد کنید.',style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(
                  color: Colors.black,
                  fontSize: 14.sp,
                ),textDirection: TextDirection.rtl,),
                const SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 0.1)
                    // color: Colors.grey.withOpacity(0.15),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('شماره کارت',style: Theme.of(Get.context!).textTheme.displaySmall,),
                      const SizedBox(height: 10,),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          textDirection: TextDirection.rtl,
                          controller: mainController.cardNum,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.right,
                          style: Theme.of(Get.context!).textTheme.bodyLarge,
                          validator: (value) {
                            if (mainController.shebaNum.text.isEmpty && value!.isEmpty) {
                              return 'لطفا شماره کارت و یا شماره شبا را وارد کنید';
                            }

                            if(value!.isEmpty){
                              return 'لطفا شماره کارت را وارد کنید';
                            }

                            if(value.length != 19){
                              return 'طول شماره کارت صحیح نمیباشد';
                            }

                            return null;
                          },
                          maxLength: 19,
                          onTap: () {
                            if (mainController.cardNum.selection ==
                                TextSelection.fromPosition(TextPosition(
                                    offset:
                                    mainController.cardNum.text.length -
                                        1))) {
                              mainController.cardNum.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset:mainController.cardNum.text.length));
                            }
                          },
                          decoration: InputDecoration(
                            hintTextDirection: TextDirection.rtl,

                            counterText: '',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:const BorderSide(width: 0.3,color: AppColors.grayColor) ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:const BorderSide(width: 0.3,) ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:const BorderSide(width: 0.3,) ),
                            hintText: 'شماره کارت به نام شخص رزرو کننده(1000تومان هزینه جابجایی)',
                            hintStyle: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color: AppColors.grayColor.withOpacity(0.5)),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15,),

                      Text('نام بانک',style: Theme.of(Get.context!).textTheme.displaySmall,),
                      const SizedBox(height: 10,),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          textDirection: TextDirection.rtl,
                          controller: mainController.bankName,
                          textAlign: TextAlign.right,
                          textInputAction: TextInputAction.next,
                          style: Theme.of(Get.context!).textTheme.bodyLarge,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'لطفا نام بانک را وارد کنید';
                            }
                            return null;
                          },
                          onTap: () {
                            if (mainController.bankName.selection ==
                                TextSelection.fromPosition(TextPosition(
                                    offset:
                                    mainController.bankName.text.length -
                                        1))) {
                              mainController.bankName.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset:mainController.bankName.text.length));
                            }
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:const BorderSide(width: 0.3,color: AppColors.grayColor) ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:const BorderSide(width: 0.3,) ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:const BorderSide(width: 0.3,) ),
                            hintText: 'نام بانک',
                            hintStyle: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color: AppColors.grayColor.withOpacity(0.5)),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15,),

                      Text('شماره شبا',style: Theme.of(Get.context!).textTheme.displaySmall,),
                      const SizedBox(height: 10,),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          textDirection: TextDirection.rtl,
                          controller: mainController.shebaNum,
                          textAlign: TextAlign.right,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          style: Theme.of(Get.context!).textTheme.bodyLarge,
                          maxLength: 24,
                          validator: (value) {
                            if (mainController.cardNum.text.isEmpty && value!.isEmpty) {
                              return 'لطفا شماره شبا و یا شماره کارت را وارد کنید';
                            }
                            if(value!.isEmpty && mainController.cardNum.text.length == 19){
                              return null;
                            }
                            if(value.length !=24){
                              return 'شماره شبا اشتباه است';
                            }
                              return null;
                          },
                          onTap: () {
                            if (mainController.shebaNum.selection ==
                                TextSelection.fromPosition(TextPosition(
                                    offset:
                                    mainController.shebaNum.text.length -
                                        1))) {
                              mainController.shebaNum.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset:mainController.shebaNum.text.length));
                            }
                          },
                          decoration: InputDecoration(
                            counterText: '',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:const BorderSide(width: 0.3,color: AppColors.grayColor) ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:const BorderSide(width: 0.3,) ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:const BorderSide(width: 0.3,) ),
                            hintText: 'شماره شبا(بدون هزینه جابجایی)',
                            hintStyle: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color: AppColors.grayColor.withOpacity(0.5)),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15,),

                      Text('دلیل لغو سفارش',style: Theme.of(Get.context!).textTheme.displaySmall,),
                      const SizedBox(height: 10,),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          textDirection: TextDirection.rtl,
                          controller: mainController.cancelReason,
                          textAlign: TextAlign.right,
                          textInputAction: TextInputAction.done,
                          style: Theme.of(Get.context!).textTheme.bodyLarge,
                          validator: (value) {
                            if (mainController.cancelReason.text.isEmpty && value!.isEmpty) {
                              return 'لطفا دلیل لغو سفارش را وارد کنید';
                            }
                            return null;
                          },
                          minLines: 3,
                          maxLines: 5,
                          onTap: () {
                            if (mainController.cancelReason.selection ==
                                TextSelection.fromPosition(TextPosition(
                                    offset:
                                    mainController.cancelReason.text.length -
                                        1))) {
                              mainController.cancelReason.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset:mainController.cancelReason.text.length));
                            }
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:const BorderSide(width: 0.3,color: AppColors.grayColor) ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:const BorderSide(width: 0.3,) ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:const BorderSide(width: 0.3,) ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15,),

                    ],
                  ),
                ),
                const SizedBox(height: 20,),

              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      if(mainController.formKey.currentState!.validate()){
                        print('object');
                        mainController.operation('کنسلی');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: const BorderSide(color: Color(0xffd9534f),width: 0.6)

                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'لغو سفارش',
                            style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(fontSize: 18.sp, color: const Color(0xffd9534f).withOpacity(0.9)),
                          ),
                          const SizedBox(width: 5,),
                          const Icon(Icons.remove_shopping_cart_outlined,color: Color(0xffd9534f),size: 18,),
                        ],
                      ),
                    )),
                Obx(() => mainController.cancelingNeedCode.value ? Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ElevatedButton(
                      onPressed: () {
                        Get.bottomSheet(BottomSheet(onClosing: () {

                        }, builder: (context) {
                          return Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(12),topLeft: Radius.circular(12))
                            ),
                            child:
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 30,),
                                Text('لطفا کد رهگیری را وارد کنید',style: Theme.of(Get.context!).textTheme.displayLarge!.copyWith(
                                  color: Colors.black,
                                  fontSize: 20.sp,
                                )),
                                const SizedBox(height: 30,),
                                SizedBox(
                                  width: Get.width/1.5,
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextFormField(
                                      textDirection: TextDirection.rtl,
                                      controller: mainController.verifyCode,
                                      textInputAction: TextInputAction.done,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.right,
                                      style: Theme.of(Get.context!).textTheme.bodyLarge,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'لطفا کد رهگیری را وارد کنید';
                                        }
                                        return null;
                                      },

                                      maxLength: 19,
                                      onTap: () {
                                        if (mainController.cardNum.selection ==
                                            TextSelection.fromPosition(TextPosition(
                                                offset:
                                                mainController.cardNum.text.length -
                                                    1))) {
                                          mainController.cardNum.selection =
                                              TextSelection.fromPosition(TextPosition(
                                                  offset:mainController.cardNum.text.length));
                                        }
                                      },
                                      decoration: InputDecoration(
                                        hintTextDirection: TextDirection.rtl,
                                        labelText: 'کد رهگیری',
                                        counterText: '',
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide:const BorderSide(width: 0.4,color: AppColors.grayColor) ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide:const BorderSide(width: 0.4,) ),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide:const BorderSide(width: 0.4,) ),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30,),
                                ElevatedButton(
                                    onPressed: () {
                                      mainController.verifyCancelRsvReq();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.mainColor,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'تایید کد رهگیری',
                                            style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(fontSize: 18.sp, color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    )),
                                const SizedBox(height: 30,),
                              ],
                            ),
                          );
                        },));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'تایید کد رهگیری',
                              style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(fontSize: 18.sp, color: Colors.white),
                            ),
                          ],
                        ),
                      )),
                ): const SizedBox())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
