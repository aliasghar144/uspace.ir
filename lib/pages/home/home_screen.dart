import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/app/utils/format_amount.dart';
import 'package:uspace_ir/controllers/home_controller.dart';
import 'package:uspace_ir/pages/reservation/reservation_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  PageController firstPageController = PageController();
  PageController reserveSectionPageController = PageController();
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: SizedBox(
        width: Get.width,
        child: Column(
          children: [
            carouselSlider(context),
            const SizedBox(
              height: 20,
            ),
            category(),
            const SizedBox(
              height: 10,
            ),
            reserveSection(),
            const SizedBox(
              height: 10,
            ),
            specialResidences(),
            const SizedBox(
              height: 20,
            ),
            bestCities(),
            const SizedBox(
              height: 20,
            ),
            seasonalOffers(),
            const SizedBox(
              height: 30,
            ),
            uSpace(),
          ],
        ),
      ),
    );
  }

  Widget carouselSlider(context) {
    return Column(children: [
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 170,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: PageView.builder(
            scrollDirection:
                axisDirectionToAxis(flipAxisDirection(AxisDirection.right)),
            allowImplicitScrolling: true,
            physics: const BouncingScrollPhysics(),
            itemCount: 3,
            controller: firstPageController,
            itemBuilder: (context, index) {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 220,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: CachedNetworkImage(
                        imageUrl: "https://www.uspace.ir/public/img/slider/main_slider/majara-ecolodge.jpg",
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => const Icon(Icons.broken_image_outlined),
                      ),
                    ),
                  ),
                  Positioned(
                      right: 25,
                      bottom: 15,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SvgPicture.asset(
                              'assets/icons/location_small_pin_ic.svg',
                              color: Colors.white,
                              width: 18),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "اقامتگاه های بوم گردی",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ))
                ],
              );
            },
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Directionality(
        textDirection: TextDirection.rtl,
        child: SmoothPageIndicator(
          onDotClicked: (index) => firstPageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 225),
            curve: Curves.easeInOut,
          ),
          controller: firstPageController,
          count: 3,
          effect: const JumpingDotEffect(
              dotHeight: 6,
              dotWidth: 6,
              dotColor: Color(0xffD9D9D9),
              activeDotColor: AppColors.mainColor),
        ),
      ),
    ]);
  }

  Widget category() {
    return Column(children: [
      SizedBox(
        height: 100,
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                physics: const BouncingScrollPhysics(),
                itemCount: homeController.categoryname.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 85,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 60,
                            height: 60,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: CachedNetworkImage(
                                  imageUrl: homeController.categoryname[index]['img'],
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) => const Icon(Icons.broken_image_outlined),
                                ))),
                        const SizedBox(height: 4),
                        Expanded(
                          child: Text(
                            homeController.categoryname[index]['name'],
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  );
                })),
      ),
    ]);
  }

  Widget specialResidences(){
    return Column(
      children:[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  "مشاهده همه",
                  style: Theme.of(Get.context!)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: AppColors.secondTextColor),
                ),
              ),
              const Spacer(),
              Text(
                "اقامتگاه های خاص",
                style: Theme.of(Get.context!).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(Get.context!).size.width,
          height: 220,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ListView.separated(
              scrollDirection:
              axisDirectionToAxis(flipAxisDirection(AxisDirection.right)),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              physics: const BouncingScrollPhysics(),
              itemCount: homeController.cities.length,
              separatorBuilder: (context, index) {
                return const SizedBox(width: 15);
              },
              itemBuilder: (context, index) {
                return                         CachedNetworkImage(
                  imageUrl: 'https://shiranhotel.uspace.ir/spaces/shiranhotel/images/main/shiranhotel_uspace_1638685959.jpg',
                  fit: BoxFit.cover,
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      clipBehavior: Clip.none,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              offset: const Offset(
                                1.0,
                                2.0,
                              ),
                              blurRadius: 10.0,
                              spreadRadius: 0.0,
                            ), //BoxShadow
                            const BoxShadow(
                              color: Colors.white,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0,
                            ),
                          ],
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),borderRadius: BorderRadius.circular(22)),
                      width: MediaQuery.of(context).size.width/2.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text('ویلایی و کنار دریا',maxLines: 1,style: Theme.of(context).textTheme.bodySmall!.copyWith(color:Colors.white),),
                          ),
                        ],
                      ),
                    );
                  },
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.broken_image_outlined),
                );

              },
            ),
          ),
        ),
      ]
    );
  }

  Widget reserveSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  "مشاهده همه",
                  style: Theme.of(Get.context!)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: AppColors.secondTextColor),
                ),
              ),
              const Spacer(),
              Text(
                "رزرو اقامتگاه بوم گردی،هتل سنتی و کلبه",
                style: Theme.of(Get.context!).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 0,
        ),
        SizedBox(
          width: MediaQuery.of(Get.context!).size.width,
          height: 250,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: PageView.builder(
              scrollDirection:
                  axisDirectionToAxis(flipAxisDirection(AxisDirection.right)),
              allowImplicitScrolling: true,
              physics: const BouncingScrollPhysics(),
              itemCount: 3,
              controller: reserveSectionPageController,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    Get.to(ReservationScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          imageUrl: 'https://shiranhotel.uspace.ir/spaces/shiranhotel/images/main/shiranhotel_uspace_1638685959.jpg',
                          fit: BoxFit.cover,
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              clipBehavior: Clip.none,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      offset: const Offset(
                                        1.0,
                                        2.0,
                                      ),
                                      blurRadius: 10.0,
                                      spreadRadius: 0.0,
                                    ), //BoxShadow
                                    const BoxShadow(
                                      color: Colors.white,
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      spreadRadius: 0.0,
                                    ),
                                  ],
                                image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                ),borderRadius: BorderRadius.circular(22)),
                              width: MediaQuery.of(context).size.width,
                              height: 180,
                              child: Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Positioned(
                                    left: -10,
                                    top: Get.width * 0.20,
                                    child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              const BoxShadow(
                                                  color: Colors.black12,
                                                  spreadRadius: 1.2,
                                                  blurRadius: 2.75,
                                                  offset: Offset(1.5, 0)),
                                              BoxShadow(
                                                  color: AppColors.mainColor.withOpacity(0.1),
                                                  spreadRadius: 1.2,
                                                  blurRadius: 2.75,
                                                  offset: const Offset(1.5, 0))
                                            ],
                                            shape: BoxShape.circle),
                                        child: Center(
                                            child: IconButton(
                                              splashRadius: 18,
                                              onPressed: () {
                                                if (index != 3) {
                                                  reserveSectionPageController.nextPage(
                                                      duration: const Duration(milliseconds: 300),
                                                      curve: Curves.easeInOut);
                                                }
                                              },
                                              icon: const Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                color: AppColors.mainColor,
                                                size: 18,
                                              ),
                                              padding: EdgeInsets.zero,
                                              alignment: Alignment.center,
                                            ))),
                                  ),
                                  Positioned(
                                    right: -10,
                                    top: Get.width * 0.20,
                                    child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              const BoxShadow(
                                                  color: Colors.black12,
                                                  spreadRadius: 1.2,
                                                  blurRadius: 2.75,
                                                  offset: Offset(1.5, 0)),
                                              BoxShadow(
                                                  color: AppColors.mainColor.withOpacity(0.1),
                                                  spreadRadius: 1.2,
                                                  blurRadius: 2.75,
                                                  offset: const Offset(1.5, 0))
                                            ],
                                            shape: BoxShape.circle),
                                        child: IconButton(
                                            splashRadius: 18,
                                            onPressed: () {
                                              if (index != 0) {
                                                reserveSectionPageController.previousPage(
                                                    duration: const Duration(milliseconds: 300),
                                                    curve: Curves.easeInOut);
                                              }
                                            },
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.zero,
                                            icon: const Icon(
                                              Icons.arrow_back_ios_rounded,
                                              color: AppColors.mainColor,
                                              size: 18,
                                            ))),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(topLeft: Radius.elliptical(45 ,50),topRight: Radius.elliptical(45 ,50) )
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                                      child: Text('2،000،000 تومان / یک شب',maxLines: 1,style: Theme.of(context).textTheme.labelMedium!.copyWith(color:AppColors.mainColor),),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.broken_image_outlined),
                        ),
                        const SizedBox(height: 20,),
                        Text('هتل سنتی سهروردی - اصفهان',style:Theme.of(context).textTheme.displayMedium),
                        const SizedBox(height: 8,),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset('assets/icons/location_small_pin_ic.svg',color: Colors.black,
                                width: 18,),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'استان اصفهان، شهر اصفهان ، خیابان میرداماد، انتهای کوچه یازدهم',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.black),
                            ),
                          ],
                        )                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget bestCities() {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            TextButton(
              onPressed: () {},
              child: Text(
                "مشاهده همه",
                style: Theme.of(Get.context!)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: AppColors.secondTextColor),
              ),
            ),
            const Spacer(),
            Text(
              "بهترین شهر های بوم گردی",
              style: Theme.of(Get.context!).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      SizedBox(
        width: MediaQuery.of(Get.context!).size.width,
        height: 145,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView.separated(
            scrollDirection:
                axisDirectionToAxis(flipAxisDirection(AxisDirection.right)),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            physics: const BouncingScrollPhysics(),
            itemCount: homeController.cities.length,
            separatorBuilder: (context, index) {
              return const SizedBox(width: 15);
            },
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      SizedBox(
                          height: 110,
                          width: 115,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://www.uspace.ir/public/img/ecolodge/city/shiraz-city.jpg",
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.broken_image_outlined),
                              ))),
                      Positioned(
                          right: 10,
                          child: Container(
                            width: 23,
                            height: 27,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              ),
                              color: AppColors.mainColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 3.5),
                              child:
                                  SvgPicture.asset('assets/icons/medal_ic.svg'),
                            ),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Expanded(
                      child: Text(homeController.cities[index],
                          maxLines: 2,
                          style: Theme.of(Get.context!).textTheme.labelMedium))
                ],
              );
            },
          ),
        ),
      ),
    ]);
  }

  Widget seasonalOffers() {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            TextButton(
              onPressed: () {},
              child: Text(
                "مشاهده همه",
                style: Theme.of(Get.context!)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: AppColors.secondTextColor),
              ),
            ),
            const Spacer(),
            Text(
              "پیشنهاد های فصلی",
              style: Theme.of(Get.context!).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      SizedBox(
        height: 180,
        width: MediaQuery.of(Get.context!).size.width,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView.separated(
            scrollDirection:
                axisDirectionToAxis(flipAxisDirection(AxisDirection.right)),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            physics: const BouncingScrollPhysics(),
            itemCount: homeController.cities.length,
            separatorBuilder: (context, index) {
              return const SizedBox(width: 18);
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: SizedBox(
                  width: 180,
                  child: Card(
                    margin: EdgeInsets.zero,
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 5,
                    shadowColor: Colors.black26,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 180,
                          height: 92,
                          child: ClipRRect(
                              child: CachedNetworkImage(
                            imageUrl:
                                "https://haftrang.uspace.ir/spaces/haftrang/images/main/_uspace_1573276873.jpg",
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.broken_image_outlined),
                          )),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('اقامتگاه بوم گردی بام بر',
                                    style: Theme.of(Get.context!)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(fontSize: 12)),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    SvgPicture.asset(
                                      'assets/icons/location_small_pin_ic.svg',
                                      color: AppColors.disabledIcon,
                                      width: 13,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "استان فارس، شیراز",
                                      style: Theme.of(Get.context!)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                              fontSize: 10,
                                              color: AppColors.disabledText),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    SvgPicture.asset(
                                      'assets/icons/price_ic.svg',
                                      color: AppColors.disabledIcon,
                                      width: 13,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "قیمت:",
                                      style: Theme.of(Get.context!)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                              fontSize: 10,
                                              color: AppColors.disabledText),
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      formatAmount(500000),
                                      style: Theme.of(Get.context!)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                              fontSize: 10,
                                              color: AppColors.mainColor),
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      'تومان',
                                      style: Theme.of(Get.context!)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                              fontSize: 10,
                                              color: AppColors.mainColor),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '8.9',
                                      style: Theme.of(Get.context!)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                              fontSize: 10,
                                              color: AppColors.disabledText),
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    SvgPicture.asset(
                                        'assets/icons/star_ic.svg'),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    ]);
  }

  Widget uSpace() {
    return Column(children: [
      Text('یواسپیس', style: Theme.of(Get.context!).textTheme.bodySmall),
      const SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          progress(
              footer: 'روستا های تحت پوشش',
              centerText: '+755',
              startColor: const Color(0xff63b9ff),
              endColor:const Color(0xff3451FF),
              percent: Random.secure().nextDouble()*(0.8)),
          progress(
              footer: 'شهر های تحت پوشش',
              centerText: '+450',
              startColor: Color(0xffFFD551),
              endColor: Color(0xffFF4B34),
              percent: Random.secure().nextDouble()*(0.8)),
          progress(
              footer: 'اقامتگاه های فعال',
              centerText: '+1976',
              startColor: Color(0xff6AC873),
              endColor: Color(0xffF9841A),
              percent: Random.secure().nextDouble()*(0.8)),
          progress(
              centerText: '+148400',
              footer: 'تعداد کل سفارشات',
              startColor: Color(0xffE42C64),
              endColor: Color(0xff614AD3),
              percent: Random.secure().nextDouble()*(0.8))
        ],
      )
    ]);
  }

  Widget loading(){
    return const Padding(padding: EdgeInsets.symmetric(vertical: 30),child: CircularProgressIndicator(color: AppColors.mainColor,),);
  }

  progress({
    required String footer,
    required String centerText,
    required Color startColor,
    required Color endColor,
    required double percent,
  }) {
    return Column(
      children: [
        CircularPercentIndicator(
          center: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: const Color(0xff9e9e9e).withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 30,
                  offset: const Offset(0, 0), // changes position of shadow
                ),
              ]),
              child: Text(
                centerText,
                style: Theme.of(Get.context!)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: const Color(0xff737373)),
              )),
          radius: 40,
          reverse: true,
          circularStrokeCap: CircularStrokeCap.round,
          footer: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child:
                Text(footer, style: Theme.of(Get.context!).textTheme.labelSmall),
          ),
          percent: percent,
          lineWidth: 3,
          backgroundColor: const Color(0xffcbccc466).withOpacity(0.1),
          startAngle: 180,
          linearGradient: LinearGradient(
              colors: [endColor, startColor]),
        ),
      ],
    );
  }
}
