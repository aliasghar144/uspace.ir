import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:sizer/sizer.dart';
import 'package:uspace_ir/app/routes/constance_routes.dart';

class IntroScreen extends StatelessWidget{
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: Get.width,
            height: Get.height,
            child: CachedNetworkImage(
              imageUrl:
              "https://www.uspace.ir/public/img/landing_page/desert/images/desert-thumb-vertical.jpg",
              fit: BoxFit.cover,
              errorWidget: (context, url, error) =>
              const Icon(Icons.broken_image_outlined),
            ),
          ),
          Positioned(
            top: Get.height/5,
            right: 0,left: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Get.width/6),
              width: Get.width/1.5,
              child: Hero(
                tag:'hero',
                child: CachedNetworkImage(
                  imageUrl:
                  "https://www.uspace.ir/public/img/bluesky/logo9.png",
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.broken_image_outlined),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: Get.width/4,
            right: 0,left: 0,
            child: Container(
              width: Get.width,
              height: Get.width/1.7,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25)
              ),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  SvgPicture.asset('assets/images/intro_shape.svg',fit: BoxFit.cover,color: AppColors.grayColor,),
                  Padding(
                    padding: EdgeInsets.only(top: Get.width*0.06,left: 15,right: 15.0,bottom: Get.width*0.15),
                    child: Text('یواسپیس، پلتفــرم جـامع اطلاع رسـانی و رزرو آنلاین اقـامتگـاه بـوم گـردی و طبیعت گـردی، هتـل‌ سنتی، بوتیـک هتـل، کلبه بومی، مجموعه آب درمـــانی، سیــاه چـادر و خـانـه بــومی در کشــور می بـاشــد. ',style: Theme.of(context).textTheme.titleMedium!.copyWith(color:Colors.white,fontSize: 12.sp),textAlign: TextAlign.center,textDirection: TextDirection.rtl,overflow: TextOverflow.fade,softWrap: true,),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: Get.width/7.6,
            right: 0,left: 0,
            child: Container(
              width: Get.width/4.5,
              height: Get.width/4.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,border: Border.all(color: AppColors.mainColor,width: 1.5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: ElevatedButton(
                  onPressed:(){
                    Get.toNamed(Routes.home);
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
      ),
    );
  }
}
