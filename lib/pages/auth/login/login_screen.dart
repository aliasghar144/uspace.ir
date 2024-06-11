import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/controllers/login_controller.dart';
import 'package:uspace_ir/pages/auth/phone_authentication_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final LoginController loginController = Get.put(LoginController());

  final RxBool activeButton = false.obs;

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
                            errorWidget: (context, url, error) {
                              return Container(
                                clipBehavior: Clip.none,
                                width: Get.width / 2.2,
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
                    ],
                  ),
                  const Spacer(flex: 1,),
                  Text('ورود / ثبت نام',style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(fontSize: 24,color: AppColors.mainColor),),
                  const SizedBox(height: 10,),
                  Text('شماره همراه خود را وارد کنید.',textDirection: TextDirection.rtl,style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(fontSize:16,color:const Color(0xff666666)),),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                        onChanged: (value) {
                          if(value.length >= 11){
                            activeButton.value = true;
                          }else{
                            activeButton.value = false;
                          }
                        },
                        maxLength: 11,
                        controller: loginController.phoneNumberController,
                        keyboardType: TextInputType.number,
                        textDirection: TextDirection.ltr,
                        style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(fontSize: 16,color:AppColors.grayColor),
                        decoration: InputDecoration(
                          counterText: '',
                          label: const Text('شماره تلفن',textDirection: TextDirection.rtl,),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: SvgPicture.asset('assets/icons/calling_ic_.svg',fit: BoxFit.scaleDown,),
                          ),
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
                              if(activeButton.value){
                                loginController.activeButton.value=false;
                                Get.to(PhoneAuthenticationScreen());
                              }
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,elevation: 0,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text('ثبت نام',style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(fontSize: 22.sp,color: Colors.white),),
                            ))),
                  )),
                  const SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                            textDirection: TextDirection.rtl,
                            text: TextSpan(
                                text: 'ورود و عضویت در ',
                                style: Theme.of(Get.context!)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(color: AppColors.grayColor),
                                children: [
                                  TextSpan(
                                    text: 'یواِسپیس ',
                                    style: Theme.of(Get.context!)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                        color: AppColors.mainColor,
                                        ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // Single tapped.
                                      },
                                  ),
                                  TextSpan(
                                      text:
                                      'به منزله قبول ',
                                      style: Theme.of(Get.context!)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(color: AppColors.grayColor)),
                                  TextSpan(
                                      text:
                                      'قوانین و مقررات ',
                                      style: Theme.of(Get.context!)
                                          .textTheme
                                          .bodySmall),
                                  TextSpan(
                                      text:
                                      'است.',
                                      style: Theme.of(Get.context!)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(color: AppColors.grayColor)),
                                ])),
                      ]),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
