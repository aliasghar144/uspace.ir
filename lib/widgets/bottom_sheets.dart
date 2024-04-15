import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/controllers/history_controller.dart';

class BottomSheets{

  // LoginController loginController = Get.find<LoginController>();
  HistoryController historyController = Get.find<HistoryController>();
  PageController pageController = PageController();
  RxString pinCode = ''.obs;
  RxBool isSnackBarActive = false.obs;

  // Future loginBottomSheet(){
  //   return Get.bottomSheet(
  //       backgroundColor: Colors.white,
  //       elevation: 0,
  //       shape: const RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(23),
  //               topRight: Radius.circular(23))),
  //       SizedBox(
  //         width: double.infinity,height: Get.height/2.25,
  //         child: PageView.builder(
  //           itemBuilder: (context, index) {
  //           if(index == 0 ){
  //             return login();
  //           }else{
  //             return phoneAuth();
  //           }
  //           },
  //           controller: pageController,
  //           physics: const NeverScrollableScrollPhysics(),
  //         ),
  //       )
  //   ).whenComplete(() {
  //     loginController.activeButton.value = false;
  //   },);
  // }

  // login(){
  //   Get.bottomSheet(
  //       backgroundColor: Colors.white,
  //       elevation: 0,
  //       shape: const RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(23),
  //               topRight: Radius.circular(23))),
  //       SizedBox(
  //         width: double.infinity,height: Get.height/2.25,
  //         child: PageView.builder(
  //           itemBuilder: (context, index) {
  //             return Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 const Spacer(flex: 1,),
  //                 Text('ورود / ثبت نام',style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(fontSize: 24,color: AppColors.mainColor),),
  //                 const SizedBox(height: 10,),
  //                 Text('شماره همراه خود را وارد کنید.',textDirection: TextDirection.rtl,style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(fontSize:16,color:const Color(0xff666666)),),
  //                 const Spacer(),
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
  //                   child: Directionality(
  //                     textDirection: TextDirection.rtl,
  //                     child: TextField(
  //                       onChanged: (value) {
  //                         if(value.length >= 11){
  //                           loginController.activeButton.value = true;
  //                         }else{
  //                           loginController.activeButton.value = false;
  //                         }
  //                       },
  //                       maxLength: 11,
  //                       controller: loginController.phoneNumberController,
  //                       keyboardType: TextInputType.number,
  //                       textDirection: TextDirection.ltr,
  //                       style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(fontSize: 16,color:AppColors.grayColor),
  //                       decoration: InputDecoration(
  //                           counterText: '',
  //                           label: const Text('شماره تلفن',textDirection: TextDirection.rtl,),
  //                           prefixIcon: Padding(
  //                             padding: const EdgeInsets.only(right: 10.0),
  //                             child: SvgPicture.asset('assets/icons/calling_ic_.svg',fit: BoxFit.scaleDown,),
  //                           ),
  //                           focusedBorder: OutlineInputBorder(
  //                               borderRadius: BorderRadius.circular(40),
  //                               borderSide: const BorderSide(color: AppColors.mainColor,width: 0.5)
  //                           ),
  //                           enabledBorder: OutlineInputBorder(
  //                               borderRadius: BorderRadius.circular(40),
  //                               borderSide: const BorderSide(color: AppColors.grayColor,width: 0.5)
  //                           )
  //                           ,
  //                           border:OutlineInputBorder(
  //                               borderRadius: BorderRadius.circular(40),
  //                               borderSide: const BorderSide(color: AppColors.grayColor,width: 0.5)
  //                           )
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 25,),
  //                 Obx(() => Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
  //                   child: Container(
  //                       clipBehavior: Clip.hardEdge,
  //                       width: Get.width,
  //                       decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(40),
  //                           gradient: LinearGradient(
  //                               begin: Alignment.topCenter,
  //                               end: Alignment.bottomCenter,
  //                               colors: [
  //                                 !loginController.activeButton.value ? const Color(0xffDCDCDC) : AppColors.mainColor,
  //                                 !loginController.activeButton.value ? const Color(0xffBFBFBF) : AppColors.mainColor,
  //                               ])
  //                       ),
  //                       child: ElevatedButton(
  //                           onPressed: (){
  //                             if(loginController.activeButton.value){
  //                               pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  //                               loginController.activeButton.value = false;
  //                             }
  //                           },
  //                           style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,elevation: 0,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
  //                           child: Padding(
  //                             padding: const EdgeInsets.symmetric(vertical: 10),
  //                             child: Text('ثبت نام',style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(fontSize: 24,color: Colors.white),),
  //                           ))),
  //                 )),
  //                 const SizedBox(height: 5,),
  //                 Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       RichText(
  //                           textDirection: TextDirection.rtl,
  //                           text: TextSpan(
  //                               text: 'ورود و عضویت در ',
  //                               style: Theme.of(Get.context!)
  //                                   .textTheme
  //                                   .labelSmall!
  //                                   .copyWith(color: AppColors.grayColor),
  //                               children: [
  //                                 TextSpan(
  //                                   text: 'یواِسپیس ',
  //                                   style: Theme.of(Get.context!)
  //                                       .textTheme
  //                                       .bodySmall!
  //                                       .copyWith(
  //                                     fontSize:10,
  //                                     color: AppColors.mainColor,
  //                                   ),
  //                                   recognizer: TapGestureRecognizer()
  //                                     ..onTap = () {
  //                                       print('read form');
  //                                       // Single tapped.
  //                                     },
  //                                 ),
  //                                 TextSpan(
  //                                     text:
  //                                     'به منزله قبول ',
  //                                     style: Theme.of(Get.context!)
  //                                         .textTheme
  //                                         .labelSmall!
  //                                         .copyWith(color: AppColors.grayColor)),
  //                                 TextSpan(
  //                                     text:
  //                                     'قوانین و مقررات ',
  //                                     style: Theme.of(Get.context!)
  //                                         .textTheme
  //                                         .bodySmall!
  //                                         .copyWith(
  //                                         fontSize: 10
  //                                     )),
  //                                 TextSpan(
  //                                     text:
  //                                     'است.',
  //                                     style: Theme.of(Get.context!)
  //                                         .textTheme
  //                                         .labelSmall!
  //                                         .copyWith(color: AppColors.grayColor)),
  //                               ])),
  //                     ]),
  //                 const Spacer(flex: 1),
  //               ],
  //             );
  //
  //           },
  //           controller: pageController,
  //           physics: const NeverScrollableScrollPhysics(),
  //         ),
  //       )
  //   );
  // }

  orderCode(){
    Get.bottomSheet(
        backgroundColor: Colors.white,
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23))),
        SizedBox(
          width: double.infinity,height: Get.height/4,
          child: PageView.builder(
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 25,),
                  Text('لطفا کد رهگیری سفارش خود را وارد کنید',textDirection: TextDirection.rtl,style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(fontSize:16,color:const Color(0xff666666)),),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                        controller: historyController.orderCodeTextEditController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        textDirection: TextDirection.rtl,
                        style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(fontSize: 16),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                            counterText: '',
                            label: const Text('کد رهگیری',textDirection: TextDirection.rtl,),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide: const BorderSide(color: AppColors.mainColor,width: 0.5)
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide: const BorderSide(color: AppColors.grayColor,width: 0.5)
                            )
                            ,
                            border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide: const BorderSide(color: AppColors.grayColor,width: 0.5)
                            )
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                        clipBehavior: Clip.hardEdge,
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                          color: AppColors.mainColor,
                        ),
                        child: ElevatedButton(
                            onPressed: (){
                              if(historyController.orderCodeTextEditController.text.isNotEmpty){
                                historyController.fetchOrderHistory(historyController.orderCodeTextEditController.text);
                                Get.back();
                                historyController.orderCodeTextEditController.clear();
                              }
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,elevation: 0,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text('جست و جو',style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(fontSize: 24,color: Colors.white),),
                            ))),
                  ),
                  const SizedBox(height: 25,),
                ],
              );
            },
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
          ),
        )
    );
  }

  // phoneAuth(){
  //   return Column(
  //     children: [
  //       const Spacer(flex:3),
  //       Text('کد تایید',style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(fontSize: 24,color: AppColors.mainColor),),
  //       const SizedBox(height: 10,),
  //       Directionality(
  //         textDirection: TextDirection.rtl,
  //         child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text('کد تایید شش رقمی به شماره ',style:Theme.of(Get.context!).textTheme.labelLarge!.copyWith(color:AppColors.grayColor)),
  //               Text(loginController.hideNumber(pageController.offset == 0.0 ? '' : loginController.phoneNumberController.text),textDirection: TextDirection.ltr,style:Theme.of(Get.context!).textTheme.labelLarge!.copyWith(color:AppColors.grayColor)),
  //               Text(' ارسال شد.',style:Theme.of(Get.context!).textTheme.labelLarge!.copyWith(color:AppColors.grayColor)),
  //             ]),
  //       ),
  //       const Spacer(),
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 25.0),
  //         child: PinCodeTextField(
  //
  //           appContext: Get.context!,
  //           length: 6,
  //           animationType: AnimationType.scale,
  //           keyboardType: TextInputType.number,
  //           pinTheme: PinTheme(
  //               shape: PinCodeFieldShape.box,
  //               borderRadius: BorderRadius.circular(30),
  //               fieldHeight: Get.width/6,
  //               borderWidth: 1,
  //               selectedFillColor: AppColors.mainColor,
  //               activeColor: AppColors.mainColor,inactiveColor: AppColors.mainColor
  //           ),
  //           onChanged: (value) {
  //             pinCode.value = value;
  //             if(value.length == 6){
  //               loginController.activeButton.value = true;
  //             }else{
  //               loginController.activeButton.value = false;
  //             }
  //           },
  //         ),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 25.0),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.end,
  //           children: [
  //             InkWell(
  //               onTap: (){},
  //               borderRadius: BorderRadius.circular(5),
  //               child: Padding(
  //                 padding: const EdgeInsets.all(3.0),
  //                 child: Text("ویرایش شماره",style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color:AppColors.grayColor)),
  //               ),
  //             ),const Expanded(child: SizedBox()),
  //             Text("تا دریافت مجدد کد",style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color:AppColors.grayColor),),
  //             const SizedBox(width: 2,),
  //             TweenAnimationBuilder<Duration>(
  //                 tween: Tween(begin: const Duration(seconds: 120), end: Duration.zero),
  //                 duration: const Duration(seconds: 120),
  //                 builder: (BuildContext context, Duration value, Widget? child) {
  //                   // final minutes = value.inMinutes;
  //                   final seconds = value.inSeconds % 60;
  //                   final minute = value.inMinutes % 60;
  //                   return Padding(
  //                       padding: const EdgeInsets.symmetric(vertical: 5),
  //                       child: Text('$minute:$seconds',
  //                           textAlign: TextAlign.center,
  //                           style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color:AppColors.mainColor)));
  //                 }
  //             ),
  //             const SizedBox(width: 2,),
  //             const Icon(Icons.access_time_rounded,color:AppColors.grayColor,size: 20,),
  //           ],
  //         ),
  //       ),
  //       const SizedBox(height: 25,),
  //       Obx(() => Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 25.0),
  //         child: Container(
  //             clipBehavior: Clip.hardEdge,
  //             width: Get.width,
  //             decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(40),
  //                 gradient: LinearGradient(
  //                     begin: Alignment.topCenter,
  //                     end: Alignment.bottomCenter,
  //                     colors: [
  //                       !loginController.activeButton.value ? const Color(0xffDCDCDC) : AppColors.mainColor,
  //                       !loginController.activeButton.value ? const Color(0xffBFBFBF) : AppColors.mainColor,
  //                     ])
  //             ),
  //             child: ElevatedButton(
  //                 onPressed: (){
  //                   if(loginController.activeButton.value && !pinCode.value.contains('.')){
  //                     loginController.isUserLogin.value = true;
  //                     Get.close(1);
  //                   }else{
  //                     if(!isSnackBarActive.value){
  //                       final snackBar = SnackBar(
  //                         content: Container(
  //                           padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
  //                           decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(25),
  //                             boxShadow: [
  //                               BoxShadow(
  //                                 color: Colors.grey.withOpacity(0.5),
  //                                 offset: const Offset(
  //                                   0.0,
  //                                   3.0,
  //                                 ),
  //                                 blurRadius: 6.0,
  //                                 spreadRadius: 0.0,
  //                               ), //BoxShadow
  //                               const BoxShadow(
  //                                 color: Colors.white,
  //                                 offset: Offset(0.0, 0.0),
  //                                 blurRadius: 0.0,
  //                                 spreadRadius: 0.0,
  //                               ),
  //                             ],
  //                           ),child: Row(
  //                           mainAxisSize: MainAxisSize.min,
  //                           children: [
  //                             const Icon(Icons.cancel_outlined,color: AppColors.redColor,size: 20,),
  //                             const SizedBox(width: 7,),
  //                             Text('کد تایید نامتعبر!',style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(color: AppColors.redColor),textDirection: TextDirection.rtl,),
  //                           ],
  //                         ),
  //                         ),
  //                         margin: EdgeInsets.only(right: Get.width/3.5,left: Get.width/3.5,bottom: Get.width/5),
  //                         backgroundColor: Colors.transparent,
  //                         dismissDirection: DismissDirection.none,
  //                         elevation: 0,
  //                         behavior: SnackBarBehavior.floating,
  //                       );
  //                       ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar).closed.then((SnackBarClosedReason reason) {
  //                         isSnackBarActive.value = false;
  //                       });
  //                       isSnackBarActive.value = true;
  //                     }
  //                   }
  //                 },
  //                 style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,elevation: 0,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
  //                 child: Padding(
  //                   padding: const EdgeInsets.symmetric(vertical: 10),
  //                   child: Text('تایید',style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(fontSize: 24,color: Colors.white),),
  //                 ))),
  //       )),
  //       const Spacer(flex: 4),
  //     ],
  //   );
  // }

}