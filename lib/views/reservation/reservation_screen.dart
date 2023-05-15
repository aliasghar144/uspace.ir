import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/app/utils/custom_tab_indicator.dart';

class ReservationScreen extends StatelessWidget {
  ReservationScreen({Key? key}) : super(key: key);

  PageController secondPageController = PageController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 3,
      child: Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: IconButton(
                          splashRadius: 20,
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              'assets/icons/bell_ic.svg',
                              color: AppColors.disabledIcon,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: IconButton(
                          splashRadius: 20,
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_forward_rounded,
                                color: AppColors.disabledIcon)),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: MediaQuery.of(Get.context!).size.width,
                        height: 200,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: PageView.builder(
                            scrollDirection: axisDirectionToAxis(
                                flipAxisDirection(AxisDirection.right)),
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
                                    right: 7,
                                    bottom: Get.width * 0.090,
                                    left: 0,
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      width: MediaQuery.of(context).size.width,
                                      height: 160,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
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
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      width: MediaQuery.of(context).size.width,
                                      height: 170,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "http://via.placeholder.com/320x150&text=image",
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                                  Icons.broken_image_outlined),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 10,
                                    top: Get.width * 0.18,
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
                                                  color: AppColors.mainColor
                                                      .withOpacity(0.1),
                                                  spreadRadius: 1.2,
                                                  blurRadius: 2.75,
                                                  offset: const Offset(-1.5, 0))
                                            ],
                                            shape: BoxShape.circle),
                                        child: Center(
                                            child: IconButton(
                                          splashRadius: 18,
                                          onPressed: () {
                                            if (index != 2) {
                                              secondPageController.nextPage(
                                                  duration: const Duration(
                                                      milliseconds: 300),
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
                                    right: 10,
                                    top: Get.width * 0.18,
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
                                                  color: AppColors.mainColor
                                                      .withOpacity(0.1),
                                                  spreadRadius: 1.2,
                                                  blurRadius: 2.75,
                                                  offset: const Offset(1.5, 0))
                                            ],
                                            shape: BoxShape.circle),
                                        child: IconButton(
                                            splashRadius: 18,
                                            onPressed: () {
                                              if (index != 0) {
                                                secondPageController
                                                    .previousPage(
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    300),
                                                        curve:
                                                            Curves.easeInOut);
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
                                    bottom: Get.width * 0.05,
                                    right: Get.width / 10 + 20,
                                    left: Get.width / 10 + 20,
                                    child: Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black45,
                                              offset: Offset(
                                                1.0,
                                                5.0,
                                              ),
                                              blurRadius: 6.0,
                                              spreadRadius: 0.0,
                                            ), //BoxShadow
                                            BoxShadow(
                                              color: Colors.white,
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 0.0,
                                              spreadRadius: 5.0,
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Center(
                                            child: Text(
                                                'اتاق 3 تخته پریخان خانم هتل سنتی شیران_اصفهان',
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium)),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          children: [
                            Text('9.4',
                                style: Theme.of(context).textTheme.bodySmall),
                            Text('/',
                                style: Theme.of(context).textTheme.bodySmall),
                            Text('10',
                                style: Theme.of(context).textTheme.bodySmall),
                            const Spacer(),
                            Text('هتل سنتی سهرودی_اصفهان',
                                style:
                                    Theme.of(context).textTheme.displayMedium),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                                'استان اصفهان،شهر اصفهان، خیابان میرداماد،انتهای کوچه یازدهم',
                                style: Theme.of(context).textTheme.labelSmall),
                            const SizedBox(
                              width: 5,
                            ),
                            SvgPicture.asset(
                              'assets/icons/location_pin_nav_outline_ic.svg',
                              width: 15,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TabBar(
                        labelColor: AppColors.primaryTextColor,
                        unselectedLabelColor: AppColors.disabledText,
                        indicator: CustomTabIndicator(
                          color: AppColors.mainColor,
                          indicatorHeight: 3,
                          radius: 4,
                        ),
                          tabs: [
                        Tab(
                            child: Center(
                              child: Text("نظرات",style:TextStyle(
                                fontSize: 14,fontWeight: FontWeight.w400,
                              ),),
                            )),
                        Tab(
                            child: Center(
                              child: Text("اتاق ها",style:TextStyle(
                                fontSize: 14,fontWeight: FontWeight.w400,
                              ),),
                            )),
                        Tab(
                            child: Center(
                              child: Text("نکات مهم",style:TextStyle(
                                fontSize: 14,fontWeight: FontWeight.w400,
                              )),
                            )),
                        Tab(
                            child: Center(
                          child: Text("توضیحات",style:TextStyle(
                            fontSize: 14,fontWeight: FontWeight.w400,
                          ),),
                        )),
                      ])
                    ],
                  ),
                )
              ];
            },
            body: TabBarView(
              children: [
                Container(
                  width: Get.width,
                  height: 500,
                  color: Colors.red,
                ),
                Container(
                  width: Get.width,
                  height: 500,
                  color: Colors.blue,
                ),
                Container(
                  width: Get.width,
                  height: 500,
                  color: Colors.yellow,
                ),
                Container(
                  width: Get.width,
                  height: 500,
                  color: Colors.yellow,
                ),
              ],
            )),
      ),
    );
  }
}