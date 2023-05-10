import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/app/utils/format_amount.dart';
import 'package:uspace_ir/controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  PageController firstPageController = PageController();
  PageController secondPageController = PageController();
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
              height: 20,
            ),
            reserveSection(),
            bestCities(),
            const SizedBox(
              height: 20,
            ),
            seasonalOffers(),
            const SizedBox(
              height: 100,
            ),
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
                        imageUrl: "http://via.placeholder.com/320x150&text=image",
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Icon(Icons.broken_image_outlined),
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
        height: 95,
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                physics: const BouncingScrollPhysics(),
                itemCount: 5,
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
                                  imageUrl: "http://via.placeholder.com/320x150&text=image",
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) => const Icon(Icons.broken_image_outlined),
                                ))),
                        const SizedBox(height: 4),
                        Expanded(
                          child: Text(
                            homeController.categoryname[index],
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
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.of(Get.context!).size.width,
          height: 195,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: PageView.builder(
              scrollDirection:
                  axisDirectionToAxis(flipAxisDirection(AxisDirection.right)),
              allowImplicitScrolling: true,
              physics: const BouncingScrollPhysics(),
              itemCount: 3,
              controller: secondPageController,
              itemBuilder: (context, index) {
                return Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Positioned(
                        bottom: Get.width * 0.05,
                        child: Container(
                      height: 15,
                      width: 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black45,
                              offset: Offset(
                                0.0,
                                0.0,
                              ),
                              blurRadius: 8.0,
                              spreadRadius: 0.0,
                            ), //BoxShadow
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 8.0,
                              spreadRadius: 0.0,
                            ),
                          ]),
                    )),
                    Positioned(
                      right: 7,
                      bottom: Get.width * 0.099,
                      left: 0,
                      top: 15,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width,
                        height: 175,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black45,
                                offset: Offset(
                                  6.0,
                                  5.0,
                                ),
                                blurRadius: 8.0,
                                spreadRadius: 0.0,
                              ), //BoxShadow
                              BoxShadow(
                                color: Colors.white,
                                offset: Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ),
                            ]),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        clipBehavior: Clip.none,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width,
                        height: 160,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: CachedNetworkImage(
                            imageUrl: "http://via.placeholder.com/320x150&text=image",
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => const Icon(Icons.broken_image_outlined),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: Get.width * 0.15,
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
                                    offset: Offset(-1.5, 0)),
                                BoxShadow(
                                    color: AppColors.mainColor.withOpacity(0.1),
                                    spreadRadius: 1.2,
                                    blurRadius: 2.75,
                                    offset: const Offset(-1.5, 0))
                              ],
                              shape: BoxShape.circle),
                          child: Center(
                              child: IconButton(
                            splashRadius: 18,
                            onPressed: () {
                              if(index!=2){
                                secondPageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
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
                      right: 10,
                      top: Get.width * 0.15,
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
                                if(index != 0){
                                  secondPageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
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
                    Positioned(
                        right: Get.width * 0.1,
                        bottom: Get.width * 0.215,
                        child: Text(
                          "هتل سنتی سهروردی",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(color: Colors.white),
                        )),
                    Positioned(
                        right: Get.width * 0.10,
                        bottom: Get.width * 0.155,
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
                              "استان اصفهان،شهر اصفهان،خیابان میرداماد،انتهای کوچه یازدهم",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        )),
                    Positioned(
                      bottom: Get.width * 0.04,
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child:Row(
                          children: [
                            const Spacer(),
                            Text('241',style:Theme.of(Get.context!).textTheme.labelLarge),
                            const SizedBox(width: 2,),
                            const Icon(Icons.favorite_outline_rounded,color:AppColors.mainColor,size: 17,),
                            const SizedBox(width: 10,),
                            Text('26',style:Theme.of(Get.context!).textTheme.labelLarge),
                            const SizedBox(width: 3,),
                            SvgPicture.asset('assets/icons/comment_count_ic.svg',color: AppColors.mainColor,),
                            const Spacer(),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget bestCities(){
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
                "بهترین شهر های بوم گردی",
                style: Theme.of(Get.context!).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height:10,),
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
                          child:ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: "http://via.placeholder.com/320x150&text=image",
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) => const Icon(Icons.broken_image_outlined),
                              ))),
                        Positioned(
                            right:10,
                            child: Container(
                              width: 23,
                              height:27,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(8),bottomLeft: Radius.circular(8),
                                ),
                                color:AppColors.mainColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 3.5),
                                child: SvgPicture.asset('assets/icons/medal_ic.svg'),
                              ),
                            ))
                      ],
                    ),
                    const SizedBox(height: 8,),
                    Expanded(child: Text(homeController.cities[index],maxLines: 2,style:Theme.of(Get.context!).textTheme.labelMedium))
                  ],
                );
              },
            ),
          ),
        ),
      ]
    );
  }

  Widget seasonalOffers(){
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
                  "پیشنهاد های فصلی",
                  style: Theme.of(Get.context!).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height:10,),
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
                          borderRadius: BorderRadius.circular(12)
                        ),
                        elevation: 5,
                        shadowColor: Colors.black26,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: 180,height: 92,child: ClipRRect(
                                child: CachedNetworkImage(
                                  imageUrl: "http://via.placeholder.com/320x150&text=image",
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) => const Icon(Icons.broken_image_outlined),
                                )),),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('اقامتگاه بوم گردی بام بر',style:Theme.of(Get.context!).textTheme.labelSmall!.copyWith(fontSize:12)),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(width: 5,),
                                        SvgPicture.asset('assets/icons/location_small_pin_ic.svg',color: AppColors.disabledIcon,width: 13,),
                                        const SizedBox(width: 5,),
                                        Text("استان فارس، شیراز",style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(fontSize: 10,color:AppColors.disabledText),)
                                      ],
                                    ),
                                    Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                        const SizedBox(width: 5,),
                                    SvgPicture.asset('assets/icons/price_ic.svg',color: AppColors.disabledIcon,width: 13,),
                                    const SizedBox(width: 5,),
                                    Text("قیمت:",style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(fontSize: 10,color:AppColors.disabledText),),
                                    const SizedBox(width: 2,),
                                    Text(formatAmount(500000),style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(fontSize: 10,color:AppColors.mainColor),),
                                    const SizedBox(width: 2,),
                                    Text('تومان',style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(fontSize: 10,color:AppColors.mainColor),),
                                    const Spacer(),
                                    Text('8.9',style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(fontSize: 10,color:AppColors.disabledText),),
                                    const SizedBox(width: 2,),
                                    SvgPicture.asset('assets/icons/star_ic.svg'),
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
        ]
    );
  }

}
