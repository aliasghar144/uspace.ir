// ignore_for_file: deprecated_member_use
import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/app/utils/check_currency.dart';
import 'package:uspace_ir/controllers/base_controller.dart';
import 'package:uspace_ir/controllers/home_controller.dart';
import 'package:uspace_ir/controllers/search_controller.dart';
import 'package:uspace_ir/pages/reservation/reservation_screen.dart';
import 'package:uspace_ir/widgets/card_ecolodge.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);


  final HomeController homeController = Get.find();
  final SearchController searchController = Get.find();
  final BaseController baseController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0,bottom: 25),
      child: SizedBox(
        width: Get.width,
        child: Column(
          children: [
            retry(),
            mainGallery(context),
            const SizedBox(
              height: 20,
            ),
            categories(),
            const SizedBox(
              height: 10,
            ),
            newestEcolodge(),
            const SizedBox(
              height: 5,
            ),
            specialPlaces(),
            const SizedBox(
              height: 40,
            ),
            bestPlaces(),
            const SizedBox(
              height: 20,
            ),
            seasonalSuggest(),
            const SizedBox(
              height: 20,
            ),
            bestSellersEcolodge(),
            const SizedBox(
              height: 20,
            ),
            bestOfferEcolodge(),
            const SizedBox(
              height: 30,
            ),
            uSpace(),
          ],
        ),
      ),
    );
  }

  Widget mainGallery(context) {
    return Obx(() => Column(children: [
          homeController.mainGallery.isEmpty
              ? Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.white),
                    width: MediaQuery.of(context).size.width,
                    height: 170,
                  ),
                )
              : SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 170,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: PageView.builder(
                      scrollDirection: axisDirectionToAxis(flipAxisDirection(AxisDirection.right)),
                      allowImplicitScrolling: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: homeController.mainGallery.length,
                      controller: homeController.mainGalleryController,
                      onPageChanged: (value) {
                        homeController.currentPage.value = value;
                      },
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
                                  imageUrl: homeController.mainGallery[index]['image'],
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) => const Icon(Icons.broken_image_outlined),
                                ),
                              ),
                            ),
                            homeController.mainGallery[index]['caption'] ==  '' ? const SizedBox() : Positioned(
                                right: 30,
                                bottom: 18,
                                child: ClipRRect(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 0.6, sigmaY: 0.6),
                                    child: Container(
                                      padding:const EdgeInsets.symmetric(horizontal: 8,vertical:5),
                                      decoration:BoxDecoration(
                                        borderRadius:BorderRadius.circular(12),
                                        color:Colors.black.withOpacity(0.45),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SvgPicture.asset('assets/icons/location_small_pin_ic.svg', width: 18,
                                              color: Colors.white,),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            homeController.mainGallery[index]['caption'],
                                            style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        );
                      },
                    ),
                  ),
                ),
          const SizedBox(
            height: 10,
          ),
          homeController.mainGallery.isEmpty
              ? const SizedBox(
                  height: 0,
                )
              : Directionality(
                  textDirection: TextDirection.rtl,
                  child: SmoothPageIndicator(
                    onDotClicked: (index) {
                      homeController.mainGalleryController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 225),
                        curve: Curves.easeInOut,
                      );
                      homeController.currentPage.value = index;
                    } ,
                    controller: homeController.mainGalleryController,
                    count: homeController.mainGallery.length,
                    effect: const JumpingDotEffect(dotHeight: 6, dotWidth: 6, dotColor: Color(0xffD9D9D9), activeDotColor: AppColors.mainColor),
                  ),
                ),
        ]));
  }

  Widget categories() {
    return Obx(() => Column(children: [
          if (homeController.categories.isEmpty) SizedBox(
                  height: 100,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      physics: const BouncingScrollPhysics(),
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 85,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  width: 45,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ) else SizedBox(
                  height: 100,
                  child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          physics: const BouncingScrollPhysics(),
                          itemCount: homeController.categories.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: 85,
                              child: InkWell(
                                onTap:(){
                                  searchController.categoryId.value = (homeController.categories[index]['url']).split('cat=').last;
                                  searchController.categoryTitle.value = (homeController.categories[index]['title']);
                                  searchController.searchWithFilter('');
                                  baseController.pageIndex.value = 2;

                                  //go to first of screen
                                  searchController.searchScrollController.animateTo(0, duration: const Duration(microseconds: 1), curve: Curves.linear);
                                },
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize:MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        width: 60,
                                        height: 60,
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(50),
                                            child: CachedNetworkImage(
                                              imageUrl: homeController.categories[index]['image'],
                                              fit: BoxFit.cover,
                                              errorWidget: (context, url, error) => const Icon(Icons.broken_image_outlined),
                                            ))),
                                    const SizedBox(height: 4),
                                    Expanded(
                                      child: Text(
                                        homeController.categories[index]['title'],
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 10.sp),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })),
                ),
        ]));
  }

  Widget newestEcolodge() {
    return Column(
      crossAxisAlignment:CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "رزرو اقامتگاه بوم گردی،هتل سنتی و کلبه",
            style: Theme.of(Get.context!).textTheme.bodyMedium,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: MediaQuery.of(Get.context!).size.width,
          height: 277,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Obx(() => PageView.builder(
                  scrollDirection: axisDirectionToAxis(flipAxisDirection(AxisDirection.right)),
                  allowImplicitScrolling: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: homeController.newestEcolodgeList.isEmpty ? 3 : homeController.newestEcolodgeList.length,
                  controller: homeController.newestEcolodgeController,
                  itemBuilder: (context, index) {
                    if (homeController.newestEcolodgeList.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.white),
                                width: MediaQuery.of(context).size.width,
                                height: 180,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                                width: MediaQuery.of(context).size.width / 3,
                                height: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                                      width: MediaQuery.of(context).size.width / 3,
                                      height: 12,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                print(homeController.newestEcolodgeList[index].url);
                                Get.to(const ReservationScreen(),arguments: {'url':homeController.newestEcolodgeList[index].url});
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: CachedNetworkImage(
                                imageUrl: homeController.newestEcolodgeList[index].image,
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
                                        ),
                                        borderRadius: BorderRadius.circular(22)),
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
                                              decoration: BoxDecoration(color: Colors.white, boxShadow: [const BoxShadow(color: Colors.black12, spreadRadius: 1.2, blurRadius: 2.75, offset: Offset(1.5, 0)), BoxShadow(color: AppColors.mainColor.withOpacity(0.1), spreadRadius: 1.2, blurRadius: 2.75, offset: const Offset(1.5, 0))], shape: BoxShape.circle),
                                              child: Center(
                                                  child: IconButton(
                                                splashRadius: 18,
                                                onPressed: () {
                                                  if (index != homeController.newestEcolodgeList.length) {
                                                    homeController.newestEcolodgeController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
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
                                              decoration: BoxDecoration(color: Colors.white, boxShadow: [const BoxShadow(color: Colors.black12, spreadRadius: 1.2, blurRadius: 2.75, offset: Offset(1.5, 0)), BoxShadow(color: AppColors.mainColor.withOpacity(0.1), spreadRadius: 1.2, blurRadius: 2.75, offset: const Offset(1.5, 0))], shape: BoxShape.circle),
                                              child: IconButton(
                                                  splashRadius: 18,
                                                  onPressed: () {
                                                    if (index != 0) {
                                                      homeController.newestEcolodgeController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
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
                                          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.elliptical(45, 50), topRight: Radius.elliptical(45, 50))),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                                            child: Text(
                                              homeController.newestEcolodgeList[index].minPrice == 0 ?'تماس با پشتیبانی':'${homeController.newestEcolodgeList[index].minPrice?.toString().beToman().seRagham() ?? '0'} ${checkCurrency(homeController.newestEcolodgeList[index].currency)}/ ${homeController.newestEcolodgeList[index].unitPrice}',
                                              maxLines: 1,
                                              style: Theme.of(context).textTheme.labelMedium!.copyWith(color: AppColors.mainColor),
                                            ),
                                          ),
                                        ),
                                        if (homeController.newestEcolodgeList[index].maxDiscountPercent != null && homeController.newestEcolodgeList[index].maxDiscountPercent! > 0)
                                          Positioned(
                                            right: Get.width * 0.10,
                                            top: 0,
                                            child: Container(
                                              height: 25,
                                              width: 40,
                                              decoration: const BoxDecoration(color: Color(0xffEA213B), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))),
                                              child: Center(child: Text('${homeController.newestEcolodgeList[index].maxDiscountPercent}%', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white))),
                                            ),
                                          )
                                        else
                                          const SizedBox(),
                                      ],
                                    ),
                                  );
                                },
                                errorWidget: (context, url, error) => const Icon(Icons.broken_image_outlined),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(homeController.newestEcolodgeList[index].title, style: Theme.of(context).textTheme.displayMedium),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/location_small_pin_ic.svg',
                                  color: Colors.black,
                                  width: 18,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Text(
                                    '${homeController.newestEcolodgeList[index].province}, ${homeController.newestEcolodgeList[index].city}, ${homeController.newestEcolodgeList[index].address}',
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.right,
                                    maxLines: 2,
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }
                  },
                )),
          ),
        ),
      ],
    );
  }

  Widget specialPlaces() {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            // TextButton(
            //   onPressed: () {},
            //   child: Text(
            //     "مشاهده همه",
            //     style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: AppColors.mainColor),
            //   ),
            // ),
            const Spacer(),
            Text(
              "اقامتگاه های خاص",
              style: Theme.of(Get.context!).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
      const SizedBox(height:20),
      SizedBox(
        width: MediaQuery.of(Get.context!).size.width,
        height: 220,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Obx(() => ListView.separated(
                scrollDirection: axisDirectionToAxis(flipAxisDirection(AxisDirection.right)),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                physics: const BouncingScrollPhysics(),
                itemCount: homeController.specialPlacesList.isEmpty ? 3 : homeController.specialPlacesList.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 15);
                },
                itemBuilder: (context, index) {
                  if (homeController.specialPlacesList.isEmpty) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        clipBehavior: Clip.none,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: Colors.white,
                        ),
                        width: MediaQuery.of(context).size.width / 2.4,
                      ),
                    );
                  } else {
                    return InkWell(
                      borderRadius: BorderRadius.circular(22),
                      onTap:(){
                        searchController.specialPlaceUrl.value = homeController.specialPlacesList[index].url;
                        searchController.specialPlaceTitle.value = homeController.specialPlacesList[index].title;
                        baseController.pageIndex.value = 2;
                        searchController.searchWithFilter('');
                        searchController.searchScrollController.animateTo(0.0, duration: const Duration(microseconds: 1), curve: Curves.linear);
                      },
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl: homeController.specialPlacesList[index].verticalImg,
                            fit: BoxFit.cover,
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                constraints: BoxConstraints(
                                  minWidth: MediaQuery.of(context).size.width / 2.0,
                                ),
                                clipBehavior: Clip.none,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: const [
                                        0.50,30
                                      ],
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(1),
                                      ]),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(22)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                                      child: Text(
                                        homeController.specialPlacesList[index].title,
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),
                                      ),)
                                  ],
                                ),
                              );
                            },
                            errorWidget: (context, url, error) => const Icon(Icons.broken_image_outlined),
                          ),
                          CachedNetworkImage(
                            imageUrl: homeController.specialPlacesList[index].verticalImg,
                            fit: BoxFit.cover,
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                constraints: BoxConstraints(
                                  minWidth: MediaQuery.of(context).size.width / 2.0,
                                ),
                                clipBehavior: Clip.none,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: const [
                                        0.80,0.98
                                      ],
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.9),
                                      ]),
                                    image: DecorationImage(
                                      opacity: 0,
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(22)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                                      child: Text(
                                        homeController.specialPlacesList[index].title,
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),
                                      ),)
                                  ],
                                ),
                              );
                            },
                            errorWidget: (context, url, error) => const Icon(Icons.broken_image_outlined),
                          ),
                        ],
                      ),
                    );
                  }
                },
              )),
        ),
      ),
    ]);
  }

  Widget bestPlaces() {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            // TextButton(
            //   onPressed: () {},
            //   child: Text(
            //     "مشاهده همه",
            //     style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: AppColors.mainColor),
            //   ),
            // ),
            const Spacer(),
            Text(
              "بهترین شهر های بوم گردی",
              style: Theme.of(Get.context!).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      SizedBox(
        width: MediaQuery.of(Get.context!).size.width,
        height: 145,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Obx(() => ListView.separated(
            scrollDirection: axisDirectionToAxis(flipAxisDirection(AxisDirection.right)),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            physics: const BouncingScrollPhysics(),
            itemCount: homeController.bestPlacesList.isEmpty ? 4 : homeController.bestPlacesList.length,
            separatorBuilder: (context, index) {
              return const SizedBox(width: 15);
            },
            itemBuilder: (context, index) {
              if (homeController.bestPlacesList.isEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                        width: 110,
                        height: 115,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                        width: 55,
                        height: 8,
                      ),
                    ),
                  ],
                );
              } else {
                return InkWell(
                  onTap:(){
                    searchController.cityTitle.value = homeController.bestPlacesList[index].title;
                    searchController.cityUrl.value = homeController.bestPlacesList[index].url;
                    searchController.searchWithFilter('');
                    baseController.pageIndex.value = 2;
                    searchController.searchScrollController.animateTo(0.0, duration: const Duration(microseconds: 1), curve: Curves.linear);
                  },
                  child: Column(
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
                                    imageUrl: homeController.bestPlacesList[index].image,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) => const Icon(Icons.broken_image_outlined),
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
                                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3.5),
                                  child: SvgPicture.asset('assets/icons/medal_ic.svg'),
                                ),
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Expanded(child: Text(homeController.bestPlacesList[index].title, maxLines: 2, style: Theme.of(Get.context!).textTheme.labelMedium))
                    ],
                  ),
                );
              }
            },
          )),
        ),
      )
    ]);
  }

  Widget seasonalSuggest() {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            // TextButton(
            //   onPressed: () {},
            //   child: Text(
            //     "مشاهده همه",
            //     style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: AppColors.mainColor),
            //   ),
            // ),
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
          child: Obx(() => ListView.separated(
              scrollDirection: axisDirectionToAxis(flipAxisDirection(AxisDirection.right)),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              physics: const BouncingScrollPhysics(),
              itemCount: homeController.sessionSuggestList.isEmpty ? 3 : homeController.sessionSuggestList.length,
              separatorBuilder: (context, index) {
                return const SizedBox(width: 18);
              },
              itemBuilder: (context, index) {
                if (homeController.sessionSuggestList.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: SizedBox(
                      width: 180,
                      child: Card(
                        margin: EdgeInsets.zero,
                        clipBehavior: Clip.hardEdge,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 5,
                        shadowColor: Colors.black26,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(width: 180, height: 90, color: Colors.white),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 40.0),
                                        child: Container(
                                          width: double.infinity,
                                          height: 12,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Row(
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
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          child: Container(
                                            width: 50,
                                            height: 8,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                                          ),
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
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          child: Container(
                                            width: 50,
                                            height: 8,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                                          ),
                                        )
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
                } else {
                  return CardEcolodge(ecolodge: homeController.sessionSuggestList[index],);
                }

              })),
        ),
      )
    ]);
  }

  Widget bestSellersEcolodge() {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            TextButton(
              onPressed: () {
                searchController.sortByValue.value = 'پرفروش ترین';
                searchController.searchWithFilter('');
                baseController.pageIndex.value =2;
                searchController.searchScrollController.animateTo(0, duration:const Duration(microseconds: 1), curve: Curves.linear);
              },
              child: Text(
                "مشاهده همه",
                style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: AppColors.mainColor),
              ),
            ),
            const Spacer(),
            Text(
              "پرفروش ترین اقامتگاه ها",
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
          child: Obx(() => ListView.separated(
              scrollDirection: axisDirectionToAxis(flipAxisDirection(AxisDirection.right)),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              physics: const BouncingScrollPhysics(),
              itemCount: homeController.bestSellersEcolodgeList.isEmpty ? 3 : homeController.bestSellersEcolodgeList.length,
              separatorBuilder: (context, index) {
                return const SizedBox(width: 18);
              },
              itemBuilder: (context, index) {
                if (homeController.bestSellersEcolodgeList.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: SizedBox(
                      width: 180,
                      child: Card(
                        margin: EdgeInsets.zero,
                        clipBehavior: Clip.hardEdge,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 5,
                        shadowColor: Colors.black26,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(width: 180, height: 90, color: Colors.white),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 40.0),
                                        child: Container(
                                          width: double.infinity,
                                          height: 12,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Row(
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
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          child: Container(
                                            width: 50,
                                            height: 8,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                                          ),
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
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          child: Container(
                                            width: 50,
                                            height: 8,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                                          ),
                                        )
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
                } else {
                  return CardEcolodge(ecolodge: homeController.bestSellersEcolodgeList[index]);
                }

              })),
        ),
      )
    ]);
  }

  Widget bestOfferEcolodge() {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            TextButton(
              onPressed: () {
                searchController.sortByValue.value = 'بیشترین تخفیف';
                searchController.searchWithFilter('');
                baseController.pageIndex.value =2;
                searchController.searchScrollController.animateTo(0, duration:const Duration(microseconds: 1), curve: Curves.linear);
              },
              child: Text(
                "مشاهده همه",
                style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: AppColors.mainColor),
              ),
            ),
            const Spacer(),
            Text(
              "بیشترین تخفیفات اقامتگاه ها",
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
          child: Obx(() => ListView.separated(
              scrollDirection: axisDirectionToAxis(flipAxisDirection(AxisDirection.right)),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              physics: const BouncingScrollPhysics(),
              itemCount: homeController.bestOfferEcolodgeList.isEmpty ? 3 : homeController.bestOfferEcolodgeList.length,
              separatorBuilder: (context, index) {
                return const SizedBox(width: 18);
              },
              itemBuilder: (context, index) {
                if (homeController.bestOfferEcolodgeList.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: SizedBox(
                      width: 180,
                      child: Card(
                        margin: EdgeInsets.zero,
                        clipBehavior: Clip.hardEdge,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 5,
                        shadowColor: Colors.black26,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(width: 180, height: 90, color: Colors.white),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 40.0),
                                        child: Container(
                                          width: double.infinity,
                                          height: 12,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Row(
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
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          child: Container(
                                            width: 50,
                                            height: 8,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                                          ),
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
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          child: Container(
                                            width: 50,
                                            height: 8,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                                          ),
                                        )
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
                } else {
                  return CardEcolodge(ecolodge: homeController.bestOfferEcolodgeList[index]);
                }
              })),
        ),
      )
    ]);
  }

  Widget uSpace() {
    return Column(children: [
      Text('یواسپیس', style: Theme.of(Get.context!).textTheme.bodySmall),
      const SizedBox(
        height: 20,
      ),
      Wrap(
        alignment: WrapAlignment.center,
        children: [
          progress(footer: 'روستا های تحت پوشش', centerText: '+755', startColor: const Color(0xff63b9ff), endColor: const Color(0xff3451FF), percent: Random.secure().nextDouble() * (0.8)),
          const SizedBox(width:5),
          progress(footer: 'شهر های تحت پوشش', centerText: '+450', startColor: const Color(0xffFFD551), endColor: const Color(0xffFF4B34), percent: Random.secure().nextDouble() * (0.8)),
          const SizedBox(width:5),
          progress(footer: 'اقامتگاه های فعال', centerText: '+1976', startColor: const Color(0xff6AC873), endColor: const Color(0xffF9841A), percent: Random.secure().nextDouble() * (0.8)),
          const SizedBox(width:5),
          progress(centerText: '+148400', footer: 'تعداد کل سفارشات', startColor: const Color(0xffE42C64), endColor: const Color(0xff614AD3), percent: Random.secure().nextDouble() * (0.8))
        ],
      ),

    ]);
  }

  Widget retry() {
    return Obx(
      () => homeController.retry.value
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      homeController.retryConnection();
                    },
                    icon: const Icon(Icons.refresh)),
                const Text('عدم اتصال به اینترنت'),
              ],
            )
          : const SizedBox(),
    );
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
                style: Theme.of(Get.context!).textTheme.displaySmall!.copyWith(color: const Color(0xff737373)),
              )),
          radius: 40,
          reverse: true,
          circularStrokeCap: CircularStrokeCap.round,
          footer: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(footer, style: Theme.of(Get.context!).textTheme.labelSmall),
          ),
          percent: percent,
          lineWidth: 3,
          backgroundColor: const Color(0xffcbccc466).withOpacity(0.1),
          startAngle: 180,
          linearGradient: LinearGradient(colors: [endColor, startColor]),
        ),
      ],
    );
  }
}
