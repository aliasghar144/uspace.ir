import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/base_screen.dart';
import 'package:uspace_ir/controllers/login_controller.dart';

class PhoneAuthenticationScreen extends StatelessWidget {
  PhoneAuthenticationScreen({Key? key}) : super(key: key);

  RxBool activeButton = false.obs;
  RxBool isSnackBarActive = false.obs;

  RxString pinCode = ''.obs;


  LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        return FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: SizedBox(
              width: Get.width,
              height: Get.height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                          top: 43,
                          child: SvgPicture.asset('assets/images/login_shape.svg',width: Get.width,color: AppColors.mainColor.withOpacity(0.25),)),
                      Positioned(
                          top: 20,
                          child: SvgPicture.asset('assets/images/login_shape.svg',width: Get.width,color: AppColors.mainColor.withOpacity(0.45))),
                      SvgPicture.asset('assets/images/login_shape.svg',width: Get.width,),
                      SizedBox(
                        width: Get.width/2.2,
                        child: Hero(
                          tag:'logo',
                          child: CachedNetworkImage(
                            imageUrl:
                            "https://www.uspace.ir/public/img/bluesky/logo9.png",
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.broken_image_outlined),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(flex:3),
                  Text('کد تایید',style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(fontSize: 24,color: AppColors.mainColor),),
                  const SizedBox(height: 10,),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('کد تایید شش رقمی به شماره ',style:Theme.of(Get.context!).textTheme.labelLarge!.copyWith(color:AppColors.grayColor)),
                          Text(loginController.hideNumber(loginController.phoneNumberController.text),textDirection: TextDirection.ltr,style:Theme.of(Get.context!).textTheme.labelLarge!.copyWith(color:AppColors.grayColor)),
                          Text(' ارسال شد.',style:Theme.of(Get.context!).textTheme.labelLarge!.copyWith(color:AppColors.grayColor)),
                        ]),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: PinCodeTextField(

                      appContext: Get.context!,
                      length: 6,
                      animationType: AnimationType.scale,
                      keyboardType: TextInputType.number,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(30),
                        fieldHeight: Get.width/6,
                        borderWidth: 1,
                        selectedFillColor: AppColors.mainColor,
                        activeColor: AppColors.mainColor,inactiveColor: AppColors.mainColor
                      ),
                      onChanged: (value) {
                        pinCode.value = value;
                        if(value.length == 6){
                          activeButton.value = true;
                        }else{
                          activeButton.value = false;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: (){
                            Get.back();
                          },
                          borderRadius: BorderRadius.circular(5),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text("ویرایش شماره",style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color:AppColors.grayColor)),
                          ),
                        ),const Expanded(child: SizedBox()),
                        Text("تا دریافت مجدد کد",style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color:AppColors.grayColor),),
                        const SizedBox(width: 2,),
                        TweenAnimationBuilder<Duration>(
                            tween: Tween(begin: const Duration(seconds: 120), end: Duration.zero),
                            duration: const Duration(seconds: 120),
                            builder: (BuildContext context, Duration value, Widget? child) {
                              // final minutes = value.inMinutes;
                              final seconds = value.inSeconds % 60;
                              final minute = value.inMinutes % 60;
                              return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: Text('$minute:$seconds',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color:AppColors.mainColor)));
                            }
                        ),
                        const SizedBox(width: 2,),
                        const Icon(Icons.access_time_rounded,color:AppColors.grayColor,size: 20,),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25,),
                  Obx(() => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                        clipBehavior: Clip.hardEdge,
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  !activeButton.value ? const Color(0xffDCDCDC) : AppColors.mainColor,
                                  !activeButton.value ? const Color(0xffBFBFBF) : AppColors.mainColor,
                                ])
                        ),
                        child: ElevatedButton(
                            onPressed: (){
                              if(activeButton.value && !pinCode.value.contains('.')){
                                Get.to(BasePage());
                                loginController.phoneNumberController.clear();
                              }else{
                                if(!isSnackBarActive.value){
                                  final snackBar = SnackBar(
                                    content: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            offset: const Offset(
                                              0.0,
                                              3.0,
                                            ),
                                            blurRadius: 6.0,
                                            spreadRadius: 0.0,
                                          ), //BoxShadow
                                          const BoxShadow(
                                            color: Colors.white,
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 0.0,
                                            spreadRadius: 0.0,
                                          ),
                                        ],
                                      ),child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.cancel_outlined,color: AppColors.redColor,size: 20,),
                                        const SizedBox(width: 7,),
                                        Text('کد تایید نامتعبر!',style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(color: AppColors.redColor),textDirection: TextDirection.rtl,),
                                      ],
                                    ),
                                    ),
                                    margin: EdgeInsets.only(right: Get.width/3.5,left: Get.width/3.5,bottom: Get.width/5),
                                    backgroundColor: Colors.transparent,
                                    dismissDirection: DismissDirection.none,
                                    elevation: 0,
                                    behavior: SnackBarBehavior.floating,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar).closed.then((SnackBarClosedReason reason) {
                                    isSnackBarActive.value = false;
                                  });
                                  isSnackBarActive.value = true;
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,elevation: 0,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text('تایید',style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(fontSize: 24,color: Colors.white),),
                            ))),
                  )),
                  const Spacer(flex: 5),
                  // Container(
                  //   padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(25),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.grey.withOpacity(0.5),
                  //         offset: const Offset(
                  //           0.0,
                  //           3.0,
                  //         ),
                  //         blurRadius: 6.0,
                  //         spreadRadius: 0.0,
                  //       ), //BoxShadow
                  //       const BoxShadow(
                  //         color: Colors.white,
                  //         offset: Offset(0.0, 0.0),
                  //         blurRadius: 0.0,
                  //         spreadRadius: 0.0,
                  //       ),
                  //     ],
                  //   ),child: Row(
                  //   mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       const Icon(Icons.cancel_outlined,color: AppColors.redColor,size: 20,),
                  //       const SizedBox(width: 7,),
                  //       Text('کد تایید نامتعبر!',style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(color: AppColors.redColor),textDirection: TextDirection.rtl,),
                  //     ],
                  //   ),
                  // ),
                  // const Spacer(flex: 2,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
