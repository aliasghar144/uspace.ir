import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/routes/route.dart';

class IntroScreen extends StatelessWidget{
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox(
            width: Get.width,
            height: Get.height,
            child: CachedNetworkImage(
              imageUrl:
              "https://www.uspace.ir/public/img/landing_page/desert/images/desert-thumb-vertical.jpg",
              fit: BoxFit.cover,
              errorWidget: (context, url, error) =>
                  Container(width: Get.width,height: Get.height,decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/desert-thumb-vertical.jpg')
                      )
                  ),),
            ),
          ),
          Positioned(
            top: Get.height/5,
            right: 0,left: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Get.width/6),
              width: Get.width/1.5,
              child: Hero(
                tag:'logo',
                child: CachedNetworkImage(
                  imageUrl:
                  "https://www.uspace.ir/public/img/bluesky/logo9.png",
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) =>
                      SvgPicture.asset('assets/images/logo.svg'),
                ),
              ),
            ),
          ),
          Positioned(
              bottom: Get.width/7,
              right: 0,left: 0,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    children: [
                      Container(
                        margin:  EdgeInsets.symmetric(horizontal: 8.w),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: AppColors.grayColor.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(25)
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 7.h,top: 3.h,left: 15,right: 15),
                          child: Text('یواسپیس، پلتفــرم جـامع اطلاع رسـانی و رزرو آنلاین اقـامتگـاه بـوم گـردی و طبیعت گـردی، هتـل‌ سنتی، بوتیـک هتـل، کلبه بومی، مجموعه آب درمـــانی، سیــاه چـادر و خـانـه بــومی در کشــور می بـاشــد. ',style: Theme.of(context).textTheme.titleLarge!.copyWith(color:Colors.white,fontSize: Get.height > 600 ? 14.3.sp:12.sp),textAlign: TextAlign.center,textDirection: TextDirection.rtl,overflow: TextOverflow.fade,softWrap: true,),
                        ),
                      ),
                      SizedBox(height: 4.5.h,)
                    ],
                  ),
                  Positioned(
                    right: 0,left: 0,
                    bottom: 0,
                    child: Container(
                      height: 23.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,border: Border.all(color: AppColors.mainColor,width: 1.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: ElevatedButton(
                          onPressed:(){
                            Get.toNamed(Routes.login);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.mainColor,
                            shape: const CircleBorder(),
                            elevation: 0,
                          ),
                          child: Icon(Icons.arrow_forward,size: 23.sp,),
                        ),
                      ),
                    ),
                  )
                ],
              )
          ),
        ],
      ),
    );
  }
}
