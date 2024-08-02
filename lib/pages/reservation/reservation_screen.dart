import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/app/utils/check_currency.dart';
import 'package:uspace_ir/controllers/reservation_controller.dart';
import 'package:uspace_ir/models/room_reservation_model.dart';
import 'package:uspace_ir/pages/reservation/reserve_room_screen.dart';
import 'package:uspace_ir/widgets/custom_progress.dart';
import 'package:uspace_ir/widgets/facilites_dialog.dart';
import 'package:uspace_ir/widgets/image_view.dart';
import 'package:uspace_ir/widgets/textfield.dart';
import 'package:uspace_ir/controllers/user_controller.dart';

class ReservationScreen extends StatelessWidget {
  final String url;

  ReservationScreen({required this.url, Key? key}) : super(key: key);

  final UserController userController = Get.find<UserController>();


  @override
  Widget build(BuildContext context) {
    ReservationController reservationController = Get.put(ReservationController(url));
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          notificationPredicate: (notification) {
            if (notification is OverscrollNotification || GetPlatform.isIOS) {
              return notification.depth == 2;
            }
            return notification.depth == 0;
          },
          color: AppColors.mainColor,
          onRefresh: () async {
            return onRefresh(reservationController, reservationController.url);
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: reservationController.mainScrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
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
                        const Spacer(),
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
                    const SizedBox(
                      height: 10,
                    ),
                    imageSec(reservationController),
                    const SizedBox(
                      height: 15,
                    ),
                    roomDetails(reservationController),
                    const SizedBox(
                      height: 30,
                    ),
                    timeAndDuration(reservationController),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              SliverAppBar(
                pinned: true,
                automaticallyImplyLeading: false,
                elevation: 0,
                actions: null,
                leading: null,
                title: Row(mainAxisSize: MainAxisSize.max, children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (!reservationController.loading.value) {
                          if (reservationController.commentList.isEmpty) {
                            sendComment(reservationController);
                          } else {
                            reservationController.tabIndex.value = 3;
                            Scrollable.ensureVisible(
                              reservationController.key3.currentContext!,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          }
                        }
                      },
                      child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(right: 5),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: const BoxDecoration(
                              border:  Border(
                                bottom: BorderSide(color: AppColors.mainColor, width: 2),
                              )),
                          child: Text(
                            'نظرات',
                            style: Theme.of(Get.context!).textTheme.labelLarge,
                          )),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (!reservationController.loading.value) {
                          reservationController.tabIndex.value = 2;
                          Scrollable.ensureVisible(
                            reservationController.key2.currentContext!,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: const BoxDecoration(
                              border: const Border(
                                bottom: BorderSide(color: AppColors.mainColor, width: 2),
                              )),
                          child: Text(
                            'توضیحات',
                            style: Theme.of(Get.context!).textTheme.labelLarge,
                          )),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (!reservationController.loading.value) {
                          reservationController.tabIndex.value = 1;
                          Scrollable.ensureVisible(
                            reservationController.key1.currentContext!,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(left: 5),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: AppColors.mainColor, width: 2),
                              )),
                          child: Text(
                            'اتاق ها',
                            style: Theme.of(Get.context!).textTheme.labelLarge,
                          )),
                    ),
                  ),
                ]),
              ),
              SliverToBoxAdapter(
                child: Column(children: [
                  rooms(reservationController),
                  details(reservationController),
                  comments(reservationController),
                  cancelingRules(reservationController),
                  const Divider(
                    color: AppColors.mainColor,
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  suggestion(reservationController),
                  const SizedBox(height: 80),
                ]),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 15.0),
              child: FloatingActionButton(
                  backgroundColor: AppColors.mainColor,
                  onPressed: () {
                    sendComment(reservationController);
                  },
                  child: SvgPicture.asset('assets/icons/chat_ic.svg')),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 15, bottom: 15.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(35),
                onTap: () {
                  Get.dialog(Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.end, children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                              splashRadius: 15,
                              onPressed: () {
                                Get.close(1);
                              },
                              icon: const Icon(Icons.cancel_outlined, color: Colors.grey, size: 15)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('قوانین', style: Theme.of(Get.context!).textTheme.bodyLarge),
                              const SizedBox(height: 15),
                              Text('رزرو کودکان', style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: AppColors.mainColor)),
                              const SizedBox(
                                height: 5,
                              ),
                              Obx(
                                () => reservationController.loading.value
                                    ? ListView.separated(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index) {
                                          return Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor: Colors.grey.shade100,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8),
                                                color: Colors.white,
                                              ),
                                              width: Get.width,
                                              height: 8,
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(height: 5);
                                        },
                                        itemCount: 2)
                                    : Text(
                                        reservationController.room.value!.data.rules.kidsTerms,
                                        textAlign: TextAlign.right,
                                        textDirection: TextDirection.rtl,
                                        style: Theme.of(Get.context!).textTheme.titleMedium,
                                      ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text('شرایط کنسلی رزرو اقامتگاه', style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: AppColors.mainColor)),
                              const SizedBox(
                                height: 5,
                              ),
                              reservationController.loading.value
                                  ? ListView.separated(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        return Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: Colors.white,
                                            ),
                                            width: Get.width,
                                            height: 8,
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(height: 5);
                                      },
                                      itemCount: 8)
                                  : Text(
                                      reservationController.room.value!.data.rules.cancelTerms ?? '-',
                                      textAlign: TextAlign.justify,
                                      textDirection: TextDirection.rtl,
                                      style: Theme.of(Get.context!).textTheme.titleMedium,
                                    ),
                              const SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                        )
                      ])));
                },
                child: Container(
                    padding: const EdgeInsets.only(
                      right: 6,
                      bottom: 6,
                      top: 6,
                      left: 12,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: Colors.red,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('قوانین', style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color: Colors.white, fontSize: 18.sp)),
                        const SizedBox(width: 5),
                        SvgPicture.asset('assets/icons/rules_ic.svg'),
                      ],
                    )),
              ),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  imageSec(ReservationController reservationController) {
    return Obx(() {
      if (reservationController.loading.value) {
        return Column(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.white),
                width: MediaQuery.of(Get.context!).size.width,
                height: 170,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: SizedBox(
                height: Get.width / 6.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                        child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                          decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      )),
                    )),
                    const SizedBox(width: 8),
                    Expanded(
                        child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                          decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      )),
                    )),
                    const SizedBox(width: 8),
                    Expanded(
                        child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                          decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      )),
                    )),
                    const SizedBox(width: 8),
                    Expanded(
                        child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                          decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      )),
                    )),
                    const SizedBox(width: 8),
                    Expanded(
                        child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                          decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      )),
                    )),
                  ],
                ),
              ),
            ),
          ],
        );
      } else {
        return Column(
          children: [
            SizedBox(
              width: MediaQuery.of(Get.context!).size.width,
              height: 200,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    PageView.builder(
                        scrollDirection: axisDirectionToAxis(flipAxisDirection(AxisDirection.right)),
                        allowImplicitScrolling: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: reservationController.room.value!.data.imageList.length,
                        controller: reservationController.pageController,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    reservationController.userImages.value = false;
                                    Get.to(
                                      ImageView(
                                        url: reservationController.room.value!.data.url,
                                        index: index,
                                        userImages: reservationController.userImages.value,
                                        imageList: reservationController.userImages.value ? null : reservationController.room.value!.data.imageList,
                                        commentList: reservationController.userImages.value ? reservationController.room.value!.data.commentsFiles : null,
                                      ),
                                    );
                                  },
                                  child: CachedNetworkImage(
                                      imageUrl: 'https://www.uspace.ir/spaces/${reservationController.url}/images/main/${reservationController.room.value!.data.imageList[index].fullImage}',
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
                                              Container(
                                                clipBehavior: Clip.hardEdge,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(25),
                                                    gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, stops: const [
                                                      0.50,
                                                      1
                                                    ], colors: [
                                                      Colors.transparent,
                                                      Colors.black.withOpacity(1),
                                                    ])),
                                                width: MediaQuery.of(context).size.width,
                                                height: 110,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                                child: Text(
                                                  reservationController.room.value!.data.imageList[index].caption ?? '',
                                                  maxLines: 2,
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      errorWidget: (context, url, error) {
                                        return Container(
                                          clipBehavior: Clip.none,
                                          width: MediaQuery.of(context).size.width,
                                          height: 180,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Image.asset(
                                            'assets/images/image_not_available.png',
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            ),
                          );
                        }),
                    Positioned(
                      left: 10,
                      top: Get.width * 0.16,
                      child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(color: Colors.white, boxShadow: [const BoxShadow(color: Colors.black12, spreadRadius: 1.2, blurRadius: 2.75, offset: Offset(1.5, 0)), BoxShadow(color: AppColors.mainColor.withOpacity(0.1), spreadRadius: 1.2, blurRadius: 2.75, offset: const Offset(1.5, 0))], shape: BoxShape.circle),
                          child: Center(
                              child: IconButton(
                                splashRadius: 18,
                                onPressed: () {
                                  if (reservationController.pageController.page != reservationController.room.value!.data.imageList.length-1) {
                                    reservationController.pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
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
                      top: Get.width * 0.16,
                      child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(color: Colors.white, boxShadow: [const BoxShadow(color: Colors.black12, spreadRadius: 1.2, blurRadius: 2.75, offset: Offset(1.5, 0)), BoxShadow(color: AppColors.mainColor.withOpacity(0.1), spreadRadius: 1.2, blurRadius: 2.75, offset: const Offset(1.5, 0))], shape: BoxShape.circle),
                          child: IconButton(
                              splashRadius: 18,
                              onPressed: () {
                                if (reservationController.pageController.page != 0) {
                                  reservationController.pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
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
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: SizedBox(
                height: Get.width / 6.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    reservationController.room.value!.data.commentsFiles.isEmpty
                        ? Flexible(
                            child: CachedNetworkImage(
                              imageUrl: 'https://www.uspace.ir/spaces/${reservationController.url}/images/thumb/${reservationController.room.value!.data.imageList[4].thumbImage}',
                              fit: BoxFit.cover,
                              progressIndicatorBuilder: (context, url, progress) {
                                return SizedBox(
                                  width: Get.width / 7,
                                  height: Get.width / 6.5,
                                  child: const Align(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1,
                                      color: AppColors.mainColor,
                                    ),
                                  ),
                                );
                              },
                              errorWidget: (context, url, error) {
                                return const SizedBox();
                              },
                              imageBuilder: (context, imageProvider) {
                                return InkWell(
                                  onTap: () {
                                    reservationController.userImages.value = false;
                                    dialogImagesView(reservationController);
                                  },
                                  child: Container(
                                      clipBehavior: Clip.none,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          opacity: 0.3,
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '...',
                                        style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(fontSize: 25),
                                      )),
                                );
                              },
                            ),
                          )
                        : CachedNetworkImage(
                            imageUrl: 'https://www.uspace.ir/spaces/${reservationController.url}/images/thumb/${reservationController.room.value!.data.imageList[4].thumbImage}',
                            fit: BoxFit.cover,
                            progressIndicatorBuilder: (context, url, progress) {
                              return SizedBox(
                                width: Get.width / 7,
                                height: Get.width / 6.5,
                                child: const Align(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1,
                                    color: AppColors.mainColor,
                                  ),
                                ),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return InkWell(
                                onTap: () {
                                  reservationController.userImages.value = true;
                                  dialogImagesView(reservationController);
                                },
                                child: Container(
                                    clipBehavior: Clip.none,
                                    width: Get.width / 3.8,
                                    height: Get.width / 6.5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                      Text('تصاویر ارسالی کاربران', style: Theme.of(Get.context!).textTheme.bodyMedium),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      SvgPicture.asset('assets/icons/photo_ic.svg'),
                                    ])),
                              );
                            },
                            imageBuilder: (context, imageProvider) {
                              return InkWell(
                                onTap: () {
                                  reservationController.userImages.value = true;
                                  dialogImagesView(reservationController);
                                },
                                child: Container(
                                    clipBehavior: Clip.none,
                                    // width: Get.width / 3.8,
                                    height: Get.width / 6.5,
                                    padding: const EdgeInsets.symmetric(horizontal: 4),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        opacity: 0.3,
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                      Text('تصاویر ارسالی کاربران', style: Theme.of(Get.context!).textTheme.bodyMedium),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      SvgPicture.asset('assets/icons/photo_ic.svg'),
                                    ])),
                              );
                            },
                          ),
                    const SizedBox(width: 5),
                    reservationController.room.value!.data.commentsFiles.isEmpty
                        ? Flexible(
                            child: InkWell(
                              onTap: () {
                                reservationController.pageController.animateToPage(3, duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
                              },
                              child: CachedNetworkImage(
                                imageUrl: 'https://www.uspace.ir/spaces/${reservationController.url}/images/thumb/${reservationController.room.value!.data.imageList[3].thumbImage}',
                                fit: BoxFit.cover,
                                progressIndicatorBuilder: (context, url, progress) {
                                  return SizedBox(
                                    width: Get.width / 7,
                                    height: Get.width / 6.5,
                                    child: const Align(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1,
                                        color: AppColors.mainColor,
                                      ),
                                    ),
                                  );
                                },
                                errorWidget: (context, url, error) {
                                  return const SizedBox();
                                },
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    clipBehavior: Clip.none,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        : Flexible(
                            child: CachedNetworkImage(
                              imageUrl: 'https://www.uspace.ir/spaces/${reservationController.url}/images/thumb/${reservationController.room.value!.data.imageList[3].thumbImage}',
                              fit: BoxFit.cover,
                              progressIndicatorBuilder: (context, url, progress) {
                                return SizedBox(
                                  width: Get.width / 7,
                                  height: Get.width / 6.5,
                                  child: const Align(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1,
                                      color: AppColors.mainColor,
                                    ),
                                  ),
                                );
                              },
                              errorWidget: (context, url, error) {
                                return const SizedBox();
                              },
                              imageBuilder: (context, imageProvider) {
                                return InkWell(
                                  onTap: () {
                                    reservationController.userImages.value = true;
                                    dialogImagesView(reservationController);
                                  },
                                  child: Container(
                                      clipBehavior: Clip.none,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          opacity: 0.3,
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '...',
                                        style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(fontSize: 25),
                                      )),
                                );
                              },
                            ),
                          ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: InkWell(
                        onTap: () {
                          reservationController.pageController.animateToPage(2, duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
                        },
                        child: CachedNetworkImage(
                          imageUrl: 'https://www.uspace.ir/spaces/${reservationController.url}/images/thumb/${reservationController.room.value!.data.imageList[2].thumbImage}',
                          fit: BoxFit.cover,
                          progressIndicatorBuilder: (context, url, progress) {
                            return SizedBox(
                              width: Get.width / 7,
                              height: Get.width / 6.5,
                              child: const Align(
                                child: CircularProgressIndicator(
                                  strokeWidth: 1,
                                  color: AppColors.mainColor,
                                ),
                              ),
                            );
                          },
                          errorWidget: (context, url, error) {
                            return const SizedBox();
                          },
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              clipBehavior: Clip.none,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: InkWell(
                        onTap: () {
                          reservationController.pageController.animateToPage(1, duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
                        },
                        child: CachedNetworkImage(
                          imageUrl: 'https://www.uspace.ir/spaces/${reservationController.url}/images/thumb/${reservationController.room.value!.data.imageList[1].thumbImage}',
                          fit: BoxFit.cover,
                          progressIndicatorBuilder: (context, url, progress) {
                            return SizedBox(
                              width: Get.width / 7,
                              height: Get.width / 6.5,
                              child: const Align(
                                child: CircularProgressIndicator(
                                  strokeWidth: 1,
                                  color: AppColors.mainColor,
                                ),
                              ),
                            );
                          },
                          errorWidget: (context, url, error) {
                            return const SizedBox();
                          },
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              clipBehavior: Clip.none,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: InkWell(
                        onTap: () {
                          reservationController.pageController.animateToPage(0, duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
                        },
                        child: CachedNetworkImage(
                          imageUrl: 'https://www.uspace.ir/spaces/${reservationController.url}/images/thumb/${reservationController.room.value!.data.imageList[0].thumbImage}',
                          fit: BoxFit.cover,
                          progressIndicatorBuilder: (context, url, progress) {
                            return SizedBox(
                              width: Get.width / 7,
                              height: Get.width / 6.5,
                              child: const Align(
                                child: CircularProgressIndicator(
                                  strokeWidth: 1,
                                  color: AppColors.mainColor,
                                ),
                              ),
                            );
                          },
                          errorWidget: (context, url, error) {
                            return const SizedBox();
                          },
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              clipBehavior: Clip.none,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      }
    });
  }

  dialogImagesView(ReservationController reservationController) {
    return Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Obx(() => Row(children: [
                Flexible(
                  child: InkWell(
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(18)),
                    onTap: () {
                      reservationController.userImages.value = false;
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: const BoxDecoration(border: Border(right: BorderSide(width: 0.15, color: Colors.black))),
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text('تصاویر اختصاصی یو اسپیس', style: Theme.of(Get.context!).textTheme.labelSmall),
                          const SizedBox(width: 2),
                          SvgPicture.asset('assets/icons/photo_ic.svg', color: reservationController.userImages.value ? AppColors.grayColor : AppColors.mainColor),
                        ])),
                  ),
                ),
                    reservationController.room.value!.data.commentsFiles.isEmpty
                    ? const SizedBox()
                    : Flexible(
                        child: InkWell(
                          borderRadius: const BorderRadius.only(topRight: Radius.circular(18)),
                          onTap: () {
                            reservationController.userImages.value = true;
                          },
                          child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              decoration: const BoxDecoration(border: Border(right: BorderSide(width: 0.15, color: Colors.black))),
                              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                Text('تصاویر ارسالی کاربران', style: Theme.of(Get.context!).textTheme.labelSmall),
                                const SizedBox(width: 2),
                                SvgPicture.asset('assets/icons/photo_ic.svg', color: reservationController.userImages.value ? AppColors.mainColor : AppColors.grayColor),
                              ])),
                        ),
                      ),
              ])),
          Container(
            height: 1,
            color: Colors.black,
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
              width: Get.width,
              constraints: BoxConstraints(
                minHeight: Get.height / 2.5,
                maxHeight: Get.height / 1.75,
              ),
              child: Obx(() => GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: reservationController.userImages.value ? reservationController.room.value!.data.commentsFiles.length : reservationController.room.value!.data.imageList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(
                            ImageView(
                              url: reservationController.room.value!.data.url,
                              index: index,
                              userImages: reservationController.userImages.value,
                              imageList: reservationController.userImages.value ? null : reservationController.room.value!.data.imageList,
                              commentList: reservationController.userImages.value ? reservationController.room.value!.data.commentsFiles : null,
                            ),
                          );
                        },
                        child: Hero(
                          tag: 'singleImage',
                          child: CachedNetworkImage(
                            imageUrl: reservationController.userImages.value ? reservationController.room.value!.data.commentsFiles[index].fileName : 'https://www.uspace.ir/spaces/${reservationController.url}/images/thumb/${reservationController.room.value!.data.imageList[index].thumbImage}',
                            progressIndicatorBuilder: (context, url, progress) {
                              return const Align(
                                child: CircularProgressIndicator(
                                  strokeWidth: 1,
                                  color: AppColors.mainColor,
                                ),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return Container(
                                clipBehavior: Clip.none,
                                width: Get.width / 4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Image.asset(
                                  'assets/images/image_not_available.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              );
                            },
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                margin: const EdgeInsets.all(3),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                height: Get.width / 4.5,
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ))),
          const SizedBox(
            height: 20,
          ),
        ]),
      ),
    );
  }

  roomDetails(ReservationController reservationController) {
    return Obx(() {
      if (reservationController.loading.value) {
        return Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                      width: Get.width / 4.5,
                      height: 8,
                    )),
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
                Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                      width: Get.width / 3,
                      height: 8,
                    )),
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
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(children: [
                    Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                          width: Get.width / 4.5,
                          height: 8,
                        )),
                    const SizedBox(width: 5),
                    SvgPicture.asset('assets/icons/capacity_ic.svg', width: 20, color: AppColors.grayColor),
                  ]),
                  const SizedBox(height: 20),
                  Row(children: [
                    Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                          width: Get.width / 4.5,
                          height: 8,
                        )),
                    const SizedBox(width: 5),
                    SvgPicture.asset('assets/icons/rooms_ic.svg', width: 20, color: AppColors.grayColor),
                  ]),
                ],
              ),
              const SizedBox(
                width: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(children: [
                    Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                          width: Get.width / 4.5,
                          height: 8,
                        )),
                    const SizedBox(width: 5),
                    SvgPicture.asset('assets/icons/delivery_time_ic.svg', width: 20, color: AppColors.grayColor),
                  ]),
                  const SizedBox(height: 20),
                  Row(children: [
                    Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                          width: Get.width / 4.5,
                          height: 8,
                        )),
                    const SizedBox(width: 5),
                    SvgPicture.asset('assets/icons/discharge_time_ic.svg', width: 20, color: AppColors.grayColor),
                  ]),
                ],
              ),
            ]),
          ),
        ]);
      } else {
        return Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              children: [
                InkWell(
                    onTap: () {
                      // print(roomReservationModelToJson(reservationController.room.value!).runtimeType);
                      if (reservationController.favChecker().value) {
                        userController.removeFav(reservationController.room.value!);
                      } else {
                        userController.addToFav(reservationController.room.value!);
                      }
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Obx(() => Icon(reservationController.favChecker().value ? Icons.favorite_rounded : Icons.favorite_border_rounded, color: reservationController.favChecker().value ? Colors.red : null, size: 23)),
                    )),
                const SizedBox(
                  width: 10,
                ),
                // InkWell(
                //     onTap: () {},
                //     borderRadius: BorderRadius.circular(8),
                //     child: Padding(
                //       padding: const EdgeInsets.all(4.0),
                //       child: SvgPicture.asset('assets/icons/share_line_ic.svg'),
                //     )),
                Expanded(
                    child: Text(
                  reservationController.room.value!.data.title,
                  style: Theme.of(Get.context!).textTheme.displayMedium,
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.end,
                )),
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
                Text('(${reservationController.room.value!.data.avgFbRate.value.toStringAsFixed(1)}/10)', textDirection: TextDirection.ltr, style: Theme.of(Get.context!).textTheme.labelMedium),
                const SizedBox(
                  width: 5,
                ),
                Text('(${reservationController.room.value!.data.visitNumber.toString()} بازدید)', textDirection: TextDirection.rtl, style: Theme.of(Get.context!).textTheme.labelMedium),
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
                Expanded(
                  child: Text('استان ${reservationController.room.value!.data.province}،شهر ${reservationController.room.value!.data.city}،${reservationController.room.value!.data.address}', textDirection: TextDirection.rtl, style: Theme.of(Get.context!).textTheme.labelSmall),
                ),
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
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(children: [
                    Text(reservationController.room.value!.data.capacity, textDirection: TextDirection.rtl, style: Theme.of(Get.context!).textTheme.labelMedium),
                    Text('ظرفیت: ', textDirection: TextDirection.rtl, style: Theme.of(Get.context!).textTheme.labelMedium),
                    const SizedBox(width: 5),
                    SvgPicture.asset('assets/icons/capacity_ic.svg', width: 20, color: AppColors.grayColor),
                  ]),
                  const SizedBox(height: 20),
                  Row(children: [
                    Text("واحد", textDirection: TextDirection.rtl, style: Theme.of(Get.context!).textTheme.labelMedium),
                    Text(reservationController.room.value!.data.roomsNumber.toString(), textDirection: TextDirection.rtl, style: Theme.of(Get.context!).textTheme.labelMedium),
                    Text('اتاق ها: ', textDirection: TextDirection.rtl, style: Theme.of(Get.context!).textTheme.labelMedium),
                    const SizedBox(width: 5),
                    SvgPicture.asset('assets/icons/rooms_ic.svg', width: 20, color: AppColors.grayColor),
                  ]),
                ],
              ),
              const SizedBox(
                width: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(children: [
                    Text('${reservationController.room.value!.data.rules.entryTime}:00', textDirection: TextDirection.rtl, style: Theme.of(Get.context!).textTheme.labelMedium),
                    Text('زمان تحویل: ', textDirection: TextDirection.rtl, style: Theme.of(Get.context!).textTheme.labelMedium),
                    const SizedBox(width: 5),
                    SvgPicture.asset('assets/icons/delivery_time_ic.svg', width: 20, color: AppColors.grayColor),
                  ]),
                  const SizedBox(height: 20),
                  Row(children: [
                    Text('${reservationController.room.value!.data.rules.exitTime}:00', textDirection: TextDirection.rtl, style: Theme.of(Get.context!).textTheme.labelMedium),
                    Text('زمان تخلیه: ', textDirection: TextDirection.rtl, style: Theme.of(Get.context!).textTheme.labelMedium),
                    const SizedBox(width: 5),
                    SvgPicture.asset('assets/icons/discharge_time_ic.svg', width: 20, color: AppColors.grayColor),
                  ]),
                ],
              ),
            ]),
          ),
        ]);
      }
    });
  }

  timeAndDuration(ReservationController reservationController) {
    return Container(
        width: Get.width,
        height: 40.h,
        color: AppColors.mainColor.withOpacity(0.08),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Obx(() => Directionality(
                  textDirection: TextDirection.rtl,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Row(children: [
                        Text(
                          'به مدت: ',
                          style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: AppColors.mainColor),
                          textDirection: TextDirection.rtl,
                        )
                      ]),
                      style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: AppColors.mainColor),
                      items: reservationController.durationDropDownItems.map((selectedType) {
                        return DropdownMenuItem(
                          value: selectedType,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RichText(
                                  textDirection: TextDirection.rtl,
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: 'به مدت: ',
                                      style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: AppColors.mainColor),
                                    ),
                                    TextSpan(
                                      text: selectedType.toString(),
                                      style: Theme.of(Get.context!).textTheme.labelMedium,
                                    ),
                                    TextSpan(
                                      text: ' شب',
                                      style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: AppColors.mainColor),
                                    ),
                                  ])),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (!reservationController.loadingRoom.value) {
                          reservationController.setSelectedDuration(value!);
                          reservationController.choseEntryDate();
                        }
                      },
                      value: reservationController.durationValue.value,
                      buttonStyleData: ButtonStyleData(
                        height: 27.h,
                        width: Get.width / 2.8,
                        padding: const EdgeInsets.only(right: 10, left: 8, top: 0, bottom: 2),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), color: Colors.transparent, border: Border.all(color: AppColors.grayColor, width: 0.3)),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down_rounded,
                        ),
                        iconEnabledColor: AppColors.grayColor,
                      ),
                      dropdownStyleData: DropdownStyleData(
                          elevation: 2,
                          padding: EdgeInsets.zero,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(12), bottomLeft: Radius.circular(12)),
                          ),
                          direction: DropdownDirection.textDirection,
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: MaterialStateProperty.all(6),
                            thumbVisibility: MaterialStateProperty.all(true),
                          )),
                    ),
                  ),
                )),
            InkWell(
              onTap: () async {
                if (!reservationController.loadingRoom.value) {
                  Jalali? picked = await showPersianDatePicker(
                    context: Get.context!,
                    helpText: '',
                    initialEntryMode: PDatePickerEntryMode.calendarOnly,
                    initialDate: reservationController.entryDate.value.toJalali() != Jalali.now() ? reservationController.entryDate.value.toJalali() : Jalali.now(),
                    firstDate: Jalali.now(),
                    lastDate: Jalali(1404, 1),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData(
                          fontFamily: 'iransans',
                          primaryTextTheme: Typography.blackRedwoodCity,
                          dialogTheme: const DialogTheme(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  picked?.toDateTime();
                  if (picked != null) {
                    reservationController.isDateSelected.value = true;
                    reservationController.entryDate.value = picked.toDateTime();
                    reservationController.choseEntryDate();
                  }
                }
              },
              child: Container(
                  height: 27.h,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: AppColors.grayColor, width: 0.3),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(children: [
                      const Icon(Icons.arrow_drop_down_rounded, color: AppColors.disabledIcon),
                      const SizedBox(width: 15),
                      Row(
                        children: [
                          Text('${reservationController.entryDate.value.toJalali().year}/${reservationController.entryDate.value.toJalali().month}/${reservationController.entryDate.value.toJalali().day}  ', style: Theme.of(Get.context!).textTheme.labelMedium),
                          Text('تاریخ ورود:', style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: AppColors.mainColor), textDirection: TextDirection.rtl),
                        ],
                      ),
                    ]),
                  )),
            ),
          ],
        ));
  }

  rooms(ReservationController reservationController) {
    return Obx(() {
      if (reservationController.loading.value || reservationController.loadingRoom.value) {
        return ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              dragStartBehavior: DragStartBehavior.down,
              child: Column(children: [
                const SizedBox(height: 20),
                ListView.separated(
                  itemCount: 3,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                          width: Get.width,
                          height: Get.width / 1.25,
                        ));
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  color: AppColors.mainColor,
                  thickness: 1,
                ),
                const SizedBox(
                  height: 15,
                ),
              ])),
        );
      } else {
        return ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              dragStartBehavior: DragStartBehavior.down,
              child: Column(key: reservationController.key1, children: [
                const SizedBox(height: 20),
                ListView.separated(
                  itemCount: reservationController.room.value!.data.rooms.length,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                  itemBuilder: (context, roomsIndex) {
                    return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.roomsBackground,
                        ),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              reservationController.room.value!.data.rooms[roomsIndex].title,
                              style: Theme.of(Get.context!).textTheme.bodyMedium,
                              textAlign: TextAlign.end,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      reservationController.room.value!.data.rooms[roomsIndex].roomPackages.isEmpty ? const SizedBox() : InkWell(
                                        onTap: () {
                                          Get.dialog(facilityDialog(roomFeatures: reservationController.room.value!.data.rooms[roomsIndex].features, title: reservationController.room.value!.data.rooms[roomsIndex].title, hasBrakeFast: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[0].value, hasDinner: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[1].value, hasLunch: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[2].value));
                                        },
                                        borderRadius: BorderRadius.circular(30),
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                              color: AppColors.mainColor.withOpacity(0.8),
                                            ),
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                            child: Row(mainAxisSize: MainAxisSize.min, children: [
                                              Text('امکانات',
                                                  style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(
                                                        color: Colors.white,
                                                      )),
                                              const SizedBox(width: 4),
                                              SvgPicture.asset('assets/icons/facilities_ic.svg'),
                                            ])),
                                      ),
                                      const SizedBox(height: 5),
                                      reservationController.room.value!.data.rooms[roomsIndex].details == null
                                          ? const SizedBox()
                                          : Text(
                                              'توضیحات:',
                                              style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: Colors.grey),
                                              textDirection: TextDirection.rtl,
                                            ),
                                      reservationController.room.value!.data.rooms[roomsIndex].details == null ? const SizedBox() : Text(reservationController.room.value!.data.rooms[roomsIndex].details ?? '', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: Colors.grey), maxLines: 2, textDirection: TextDirection.rtl, softWrap: true, overflow: TextOverflow.ellipsis),
                                      reservationController.room.value!.data.rooms[roomsIndex].roomPackages.isEmpty ? const SizedBox() : reservationController.durationValue.value != 1 && reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.totalCustomerDiscount == 0
                                          ? RichText(
                                              textDirection: TextDirection.rtl,
                                              text: TextSpan(children: [
                                                TextSpan(text: 'قیمت یک شب: ', style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.grey)),
                                                TextSpan(text: oneNightPrice(reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.days).toString().seRagham(), style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.black.withOpacity(0.7))),
                                                TextSpan(text: ' تومان', style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.black.withOpacity(0.7))),
                                              ]),
                                            )
                                          : const SizedBox(),
                                      const SizedBox(height: 5),
                                      reservationController.room.value!.data.rooms[roomsIndex].roomPackages.isEmpty ? const SizedBox() : reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.totalCustomerDiscount != 0
                                          ? RichText(
                                              textDirection: TextDirection.rtl,
                                              text: TextSpan(children: [
                                                TextSpan(text: 'قیمت یک شب: ', style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.grey)),
                                                TextSpan(
                                                    text: oneNightPrice(reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.days),
                                                    style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(
                                                          color: Colors.black.withOpacity(0.7),
                                                        )),
                                                TextSpan(text: ' تومان', style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.black.withOpacity(0.7))),
                                              ]),
                                            )
                                          : const SizedBox(),
                                      reservationController.room.value!.data.rooms[roomsIndex].roomPackages.isEmpty ? const SizedBox() :reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.totalCustomerDiscount != 0
                                          ? Container(
                                              margin: const EdgeInsets.only(top: 5, bottom: 5),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: AppColors.redColor.withOpacity(0.8),
                                              ),
                                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                              child: RichText(
                                                textDirection: TextDirection.rtl,
                                                text: TextSpan(children: [
                                                  TextSpan(text: (reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.totalOriginalPrice - reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.totalCustomerPrice).toString().seRagham(), style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: Colors.white)),
                                                  TextSpan(text: 'تومان تخفیف', style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: Colors.white)),
                                                ]),
                                              ),
                                            )
                                          : const SizedBox(),
                                      const SizedBox(height: 8),
                                      reservationController.room.value!.data.rooms[roomsIndex].roomPackages.isEmpty ? const SizedBox() : Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          color: Colors.grey.withOpacity(0.12),
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                        child: RichText(
                                          textDirection: TextDirection.rtl,
                                          text: TextSpan(children: [
                                            TextSpan(text: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.totalPay.toString().seRagham(), style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(color: AppColors.mainColor)),
                                            TextSpan(text: ' تومان ', style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(color: AppColors.mainColor)),
                                            TextSpan(text: 'برای ', style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.grey)),
                                            TextSpan(text: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.durationDay.toString(), style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color: Colors.grey)),
                                            TextSpan(text: ' شب', style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.grey)),
                                          ]),
                                        ),
                                      ),
                                      reservationController.room.value!.data.rooms[roomsIndex].roomPackages.isEmpty ? Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          color: Colors.grey.withOpacity(0.12),
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                        child: RichText(
                                          textDirection: TextDirection.rtl,
                                          text: TextSpan(children: [
                                            TextSpan(text: reservationController.room.value!.data.maxDiscountPrice.toString().beToman().seRagham(), style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(color: AppColors.mainColor)),
                                            TextSpan(text: ' تومان ', style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(color: AppColors.mainColor)),
                                            TextSpan(text: 'برای ', style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.grey)),
                                            TextSpan(text: 'هر', style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color: Colors.grey)),
                                            TextSpan(text: reservationController.room.value!.data.unitPrice, style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.grey)),
                                          ]),
                                        ),
                                      ) : const SizedBox(),
                                      reservationController.room.value!.data.rooms[roomsIndex].roomPackages.isEmpty ? InkWell(
                                        onTap: () {
                                          Get.to(
                                                () => RoomReservationScreen(roomsIndex: roomsIndex),
                                          );
                                        },
                                        child: Container(
                                          margin:const EdgeInsets.only(top:15),
                                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(6),
                                            color: AppColors.mainColor,
                                          ),
                                          child: Text('رزرو اتاق', style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(fontSize: 14.sp, color: Colors.white)),
                                        ),
                                      ) : const SizedBox(),

                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Hero(
                                  tag: roomsIndex,
                                  child: CachedNetworkImage(
                                    height: Get.width / 3.5,
                                    width: Get.width / 3.5,
                                    progressIndicatorBuilder: (context, url, progress) {
                                      return const Align(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 1,
                                          color: AppColors.mainColor,
                                        ),
                                      );
                                    },
                                    errorWidget: (context, url, error) {
                                      return Container(
                                        clipBehavior: Clip.none,
                                        width: Get.width / 4,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Image.asset(
                                          'assets/images/image_not_available.png',
                                          fit: BoxFit.scaleDown,
                                        ),
                                      );
                                    },
                                    imageUrl: reservationController.room.value!.data.rooms[roomsIndex].thumbImage,
                                    fit: BoxFit.cover,
                                    imageBuilder: (context, imageProvider) {
                                      return Container(
                                        clipBehavior: Clip.none,
                                        width: Get.width / 4,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          reservationController.room.value!.data.rooms[roomsIndex].roomPackages.isEmpty ? const SizedBox() : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(text: 'ظرفیت اضافه:', style: Theme.of(Get.context!).textTheme.bodySmall),
                                  TextSpan(text: '${reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.additionalNumber} نفر'.toPersianDigit(), style: Theme.of(Get.context!).textTheme.titleLarge),
                                ]),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(text: 'پرداختی برای: ', style: Theme.of(Get.context!).textTheme.bodySmall),
                                  TextSpan(text: '${reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.paidNumber} نفر'.toPersianDigit(), style: Theme.of(Get.context!).textTheme.titleLarge),
                                ]),
                              ),
                            ]),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                           reservationController.room.value!.data.rooms[roomsIndex].roomPackages.isEmpty ? const SizedBox() : Container(
                            alignment: Alignment.topRight,
                            height: Get.width / 4.7,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: ListView.separated(
                                itemCount: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.days.length,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (context, index) {
                                  return const SizedBox(width: 10);
                                },
                                itemBuilder: (context, roomIndex) {
                                  if (reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.status == 'unavailable') {
                                    return Container(
                                      width: Get.width / 4.05,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 0.4, color: AppColors.mainColor)),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: Get.width / 4.05,
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                                            decoration: BoxDecoration(
                                              color: AppColors.redColor.withOpacity(0.1),
                                            ),
                                            child: Text(
                                                reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.days[roomIndex].date.toPersianDateStr(
                                                  showDayStr: true,
                                                ),
                                                style: Theme.of(Get.context!).textTheme.labelSmall),
                                          ),
                                          const Spacer(),
                                          Text('ناموجود', style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color: AppColors.redColor)),
                                          const SizedBox(height: 3)
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      width: Get.width / 4.05,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 0.4, color: AppColors.mainColor)),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: Get.width / 4.05,
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                                            decoration: BoxDecoration(
                                              color: AppColors.mainColor.withOpacity(0.1),
                                            ),
                                            child: Text(
                                              reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.days[roomIndex].date.toPersianDateStr(
                                                showDayStr: true,
                                              ),
                                              style: Theme.of(Get.context!).textTheme.labelSmall,
                                              maxLines: 1,
                                            ),
                                          ),
                                          const SizedBox(height: 3),
                                          Text(
                                            '${reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.days[roomIndex].originalPrice.toString().seRagham()} تومان',
                                            style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color: AppColors.grayColor),
                                            textDirection: TextDirection.rtl,
                                            maxLines: 1,
                                          ),
                                          const SizedBox(height: 3),
                                          Text(
                                            reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.days[roomIndex].additionalGustPrice == 0 ? 'نفر اضافه ندارد' : 'نفر اضافه: ${reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.days[roomIndex].additionalGustPrice.toString().seRagham()} تومان',
                                            style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color: AppColors.grayColor),
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.center,
                                          ),
                                          const Spacer(),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.days[roomIndex].availability == 'available'
                                                  ? Container(
                                                      decoration: const BoxDecoration(
                                                        color: AppColors.mainColor,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      padding: const EdgeInsets.all(2),
                                                      child: const Icon(Icons.done_rounded, size: 6, color: Colors.white))
                                                  : const SizedBox(),
                                              reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.days[roomIndex].availability == 'available' ? const SizedBox(width: 2) : const SizedBox(),
                                              Text(reservationController.roomAvailabilityCheck(reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.days[roomIndex].availability), style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color: AppColors.mainColor)),
                                            ],
                                          ),
                                          const SizedBox(height: 3)
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          reservationController.room.value!.data.rooms[roomsIndex].roomPackages.isEmpty ? const SizedBox() :Container(
                              width: Get.width,
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1), borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5))),
                              child: Get.width > 360
                                  ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                      InkWell(
                                        onTap: () {
                                          if (reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.reservePermission) {
                                            Get.to(
                                              () => RoomReservationScreen(roomsIndex: roomsIndex),
                                            );
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(6),
                                            color: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.reservePermission ? AppColors.mainColor : AppColors.disabledIcon,
                                          ),
                                          child: Text('رزرو اتاق', style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(fontSize: 14.sp, color: Colors.white)),
                                        ),
                                      ),
                                      Expanded(
                                        child: Wrap(
                                          direction: Axis.horizontal,
                                          crossAxisAlignment: WrapCrossAlignment.end,
                                          spacing: 3,
                                          runSpacing: 10,
                                          alignment: WrapAlignment.end,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(6),
                                                border: Border.all(width: 0.1, color: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[2].value == 1 ? AppColors.mainColor : Colors.grey),
                                              ),
                                              child: Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: [
                                                Text(reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[2].value == 1 ? 'شام دارد' : 'شام ندارد', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[2].value == 1 ? AppColors.mainColor : Colors.grey)),
                                                const SizedBox(width: 2),
                                                SvgPicture.asset('assets/icons/lunch_ic.svg', color: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[2].value == 1 ? AppColors.mainColor : Colors.grey),
                                              ]),
                                            ),
                                            const SizedBox(width: 5),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(6),
                                                border: Border.all(width: 0.1, color: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[1].value == 1 ? AppColors.mainColor : Colors.grey),
                                              ),
                                              child: Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: [
                                                Text(reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[1].value == 1 ? 'نهار دارد' : 'نهار ندارد', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[1].value == 1 ? AppColors.mainColor : Colors.grey)),
                                                const SizedBox(width: 2),
                                                SvgPicture.asset('assets/icons/dinner_ic.svg', color: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[1].value == 1 ? AppColors.mainColor : Colors.grey),
                                              ]),
                                            ),
                                            const SizedBox(width: 5),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(6),
                                                border: Border.all(width: 0.1, color: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[0].value == 1 ? AppColors.mainColor : Colors.grey),
                                              ),
                                              child: Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: [
                                                Text(reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[0].value == 1 ? 'صبحانه دارد' : 'صبحانه ندارد', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[0].value == 1 ? AppColors.mainColor : Colors.grey)),
                                                const SizedBox(width: 2),
                                                SvgPicture.asset('assets/icons/breakfast_ic.svg', color: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[0].value == 1 ? AppColors.mainColor : Colors.grey),
                                              ]),
                                            ),
                                          ],
                                        ),
                                      )
                                    ])
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.reservePermission) {
                                              // Get.toNamed("${Get.currentRoute}/$roomsIndex",arguments: {
                                              //   'roomsIndex':roomsIndex
                                              // });
                                              Get.to(() => RoomReservationScreen(roomsIndex: roomsIndex));
                                            }
                                          },
                                          child: Container(
                                            width: Get.width / 3.5,
                                            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(6),
                                              color: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.reservePermission ? AppColors.mainColor : AppColors.disabledIcon,
                                            ),
                                            child: Text('رزرو اتاق', style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(fontSize: 14.sp, color: Colors.white)),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          children: [
                                            Row(children: [
                                              Container(
                                                width: Get.width / 4,
                                                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(6),
                                                  border: Border.all(width: 0.1, color: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[2].value == 1 ? AppColors.mainColor : Colors.grey),
                                                ),
                                                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                  Text(reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[2].value == 1 ? 'شام دارد' : 'شام ندارد', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[2].value == 1 ? AppColors.mainColor : Colors.grey)),
                                                  const SizedBox(width: 2),
                                                  SvgPicture.asset('assets/icons/lunch_ic.svg', color: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[2].value == 1 ? AppColors.mainColor : Colors.grey),
                                                ]),
                                              ),
                                              const SizedBox(width: 5),
                                              Container(
                                                width: Get.width / 4,
                                                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(6),
                                                  border: Border.all(width: 0.1, color: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[0].value == 1 ? AppColors.mainColor : Colors.grey),
                                                ),
                                                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                  Text(reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[0].value == 1 ? 'صبحانه دارد' : 'صبحانه ندارد', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[0].value == 1 ? AppColors.mainColor : Colors.grey)),
                                                  const SizedBox(width: 2),
                                                  SvgPicture.asset('assets/icons/breakfast_ic.svg', color: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[0].value == 1 ? AppColors.mainColor : Colors.grey),
                                                ]),
                                              ),
                                            ]),
                                            const SizedBox(height: 8),
                                            Container(
                                              width: Get.width / 3,
                                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(6),
                                                border: Border.all(width: 0.1, color: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[1].value == 1 ? AppColors.mainColor : Colors.grey),
                                              ),
                                              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                Text(reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[1].value == 1 ? 'نهار دارد' : 'نهار ندارد', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[1].value == 1 ? AppColors.mainColor : Colors.grey)),
                                                const SizedBox(width: 2),
                                                SvgPicture.asset('assets/icons/dinner_ic.svg', color: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[1].value == 1 ? AppColors.mainColor : Colors.grey),
                                              ]),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                        ]));
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  color: AppColors.mainColor,
                  thickness: 1,
                ),
              ])),
        );
      }
    });
  }

  details(ReservationController reservationController) {
    return Obx(() => reservationController.loading.value
        ? ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              dragStartBehavior: DragStartBehavior.down,
              child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Padding(
                    padding: const EdgeInsets.only(right: 15, left: 15, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              width: Get.width / 3,
                              height: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                              ),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                  ),
                                  width: Get.width,
                                  height: 8,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 5);
                            },
                            itemCount: 10),
                        const SizedBox(
                          height: 15,
                        ),
                        Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              width: Get.width / 3,
                              height: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                              ),
                            )),
                        const SizedBox(
                          height: 5,
                        ),
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                  ),
                                  width: Get.width,
                                  height: 8,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 5);
                            },
                            itemCount: 10),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    )),
              ]),
            ),
          )
        : ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              dragStartBehavior: DragStartBehavior.down,
              child: Column(key: reservationController.key2, crossAxisAlignment: CrossAxisAlignment.end, children: [
                Padding(
                    padding: const EdgeInsets.only(right: 15, left: 15, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Html(
                              style: {
                                'body': Style(
                                  lineHeight: LineHeight.number(1.25),
                                ),
                              },
                              data: reservationController.room.value!.data.content,
                            )),
                        Directionality(textDirection: TextDirection.rtl, child: Html(data: reservationController.room.value!.data.distance)),
                        Container(
                          height: 165,
                          width: Get.width,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(23),
                          ),
                          child: FlutterMap(
                            options: MapOptions(
                              onPositionChanged: (position, hasGesture) {
                                if (hasGesture) {
                                  reservationController.markerSized.value = (28.0 * (position.zoom! / 9.5));
                                }
                              },
                              interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                              center: LatLng(reservationController.room.value!.data.mapLong, reservationController.room.value!.data.mapLat),
                              minZoom: 6,
                              maxZoom: 17,
                            ),
                            children: [
                              TileLayer(
                                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                              ),
                              MarkerLayer(markers: [
                                Marker(
                                  rotate: false,
                                  point: LatLng(reservationController.room.value!.data.mapLong, reservationController.room.value!.data.mapLat),
                                  builder: (ctx) => Tooltip(
                                    message: reservationController.room.value!.data.address,
                                    triggerMode: TooltipTriggerMode.tap,
                                    textAlign: TextAlign.center,
                                    child: Obx(() => Stack(
                                          alignment: Alignment.center,
                                          clipBehavior: Clip.none,
                                          children: [
                                            Positioned(
                                              bottom: 15,
                                              child: Icon(
                                                Icons.location_on_sharp,
                                                size: reservationController.markerSized.value,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                  anchorPos: AnchorPos.align(AnchorAlign.center),
                                ),
                              ]),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text('امکانات و ویژگی ها', style: Theme.of(Get.context!).textTheme.bodySmall),
                        const SizedBox(height: 5),
                        ListView.separated(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Text(reservationController.room.value!.data.features[index].feature.title, textAlign: TextAlign.right, style: Theme.of(Get.context!).textTheme.titleMedium);
                          },
                          separatorBuilder: (context, index) => const SizedBox(height: 5),
                          itemCount: reservationController.room.value!.data.features.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                        ),
                        const SizedBox(height: 20),
                      ],
                    )),
              ]),
            ),
          ));
  }

  comments(ReservationController reservationController) {
    return Obx(() {
      if (reservationController.loading.value) {
        return ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Container(
                  height: 1,
                  width: Get.width,
                  color: Colors.black.withOpacity(0.1),
                ),
                const SizedBox(height: 20),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        width: Get.width,
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                      width: Get.width / 3.2,
                                      height: 15,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white,
                                      )),
                                ),
                                const Spacer(),
                                Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                      width: Get.width / 4.5,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white,
                                      )),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    clipBehavior: Clip.hardEdge,
                                    width: 35,
                                    height: 35,
                                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 48.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ListView.separated(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        return Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: Colors.white,
                                            ),
                                            width: Get.width,
                                            height: 8,
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(height: 5);
                                      },
                                      itemCount: 8),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 20);
                    },
                    itemCount: 6),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        );
      } else {
        if (reservationController.commentList.isEmpty) {
          return const SizedBox();
        } else {
          return ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Obx(() => Column(
                    key: reservationController.key3,
                    children: [
                      Container(
                        height: 1,
                        width: Get.width,
                        color: Colors.black.withOpacity(0.1),
                      ),
                      userImages(reservationController),
                      const SizedBox(height: 20),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              width: Get.width,
                              margin: const EdgeInsets.symmetric(horizontal: 25),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      // reservationController.commentList[index].type == 'feedback'
                                      //     ? Row(
                                      //         children: [
                                      //           RateStar(point: reservationController.commentList[index].option1?.point, title: reservationController.commentList[index].option1!.title),
                                      //           RateStar(point: reservationController.commentList[index].option2?.point, title: reservationController.commentList[index].option2!.title),
                                      //           RateStar(point: reservationController.commentList[index].option3?.point, title: reservationController.commentList[index].option3!.title),
                                      //           RateStar(point: reservationController.commentList[index].option4?.point, title: reservationController.commentList[index].option4!.title),
                                      //           RateStar(point: reservationController.commentList[index].option5?.point, title: reservationController.commentList[index].option5!.title),
                                      //         ],
                                      //       )
                                      //     : const SizedBox(),
                                      const Spacer(),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              reservationController.commentList[index].type != 'feedback'
                                                  ? Container(
                                                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8),
                                                        border: Border.all(
                                                          width: 0.5,
                                                          color: AppColors.grayColor,
                                                        ),
                                                      ),
                                                      child: Text('رزرو کننده نیست', style: Theme.of(Get.context!).textTheme.titleSmall!.copyWith(color: AppColors.grayColor)))
                                                  : const SizedBox(),
                                              const SizedBox(width: 5),
                                              Text(reservationController.commentList[index].name, style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: Colors.black.withOpacity(0.6))),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              reservationController.commentList[index].type == 'feedback' ? Text('رزرو کننده اقامتگاه (در تاریخ ${reservationController.commentList[index].date.toPersianDateStr(strMonth: true)})', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.grayColor)) : Text('تاریخ ثبت نظر ${reservationController.commentList[index].date.toPersianDateStr(strMonth: true)}', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.grayColor)),
                                              const SizedBox(width: 5),
                                              reservationController.commentList[index].type == 'feedback'
                                                  ? Container(
                                                      width: 12,
                                                      height: 12,
                                                      decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.acceptedGuest),
                                                      child: const Icon(
                                                        Icons.done,
                                                        size: 8,
                                                        color: Colors.white,
                                                      ))
                                                  : const SizedBox()
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        clipBehavior: Clip.hardEdge,
                                        width: 35,
                                        height: 35,
                                        decoration: const BoxDecoration(shape: BoxShape.circle),
                                        child: const Icon(Icons.account_circle_rounded, size: 30),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 48.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        reservationController.commentList[index].comment == null
                                            ? const SizedBox()
                                            : ReadMoreText(
                                                reservationController.commentList[index].comment ?? '',
                                                textAlign: TextAlign.justify,
                                                style: Theme.of(Get.context!).textTheme.titleMedium!,
                                                trimLines: 4,
                                                textDirection: TextDirection.rtl,
                                                trimMode: TrimMode.Line,
                                                lessStyle: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.mainColor),
                                                trimCollapsedText: ' نمایش بیشتر',
                                                trimExpandedText: ' نمایش کمتر',
                                                moreStyle: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.mainColor),
                                              ),
                                        const SizedBox(height: 5),
                                        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                          Row(children: [
                                            SizedBox(width: 15, child: Align(
                                                alignment:Alignment.center,
                                                child: Obx(() => Text(reservationController.commentList[index].dislikes.value.toString())))),
                                            InkWell(
                                                borderRadius: BorderRadius.circular(8),
                                                onTap: () {
                                                  // reservationController.dislikeLocal(reservationController.commentList[index].id);
                                                  reservationController.dislikeApi(id:reservationController.commentList[index].id,commentType:reservationController.commentList[index].type,index:index);
                                                },
                                                child: Obx(() => Padding(
                                                      padding: const EdgeInsets.all(3),
                                                      child: Icon(Icons.thumb_down, size: 20, color: reservationController.dislikedComment.contains(reservationController.commentList[index].id) ? AppColors.redColor : AppColors.disabledIcon),
                                                    ))),
                                            const SizedBox(width:5),
                                            InkWell(
                                                borderRadius: BorderRadius.circular(8),
                                                onTap: () {
                                                  // reservationController.likeLocal(reservationController.commentList[index].id);
                                                  reservationController.likeApi(id:reservationController.commentList[index].id,commentType:reservationController.commentList[index].type,index:index);

                                                },
                                                child: Obx(() => Padding(
                                                      padding: const EdgeInsets.all(3.0),
                                                      child: Icon(Icons.thumb_up_sharp, size: 20, color: reservationController.likedComment.contains(reservationController.commentList[index].id) ? AppColors.acceptedGuest : AppColors.disabledIcon),
                                                    ))),
                                            SizedBox(
                                                width: 15,
                                                child: Align(
                                                  alignment:Alignment.center,
                                                  child: Obx(
                                                    () => Text(reservationController.commentList[index].likes.value.toString()),
                                                  ),
                                                )),
                                          ]),
                                          const Spacer(),
                                          InkWell(
                                            borderRadius: BorderRadius.circular(8),
                                            onTap: () {
                                              sendComment(reservationController);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2.0),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 5.0),
                                                    child: Text('پاسخ به این نظر', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.mainColor)),
                                                  ),
                                                  const Icon(
                                                    Icons.reply_rounded,
                                                    size: 15,
                                                    color: AppColors.mainColor,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ])
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  reservationController.commentList[index].replies[0].replier != null
                                      ? ListView.separated(
                                          physics: const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (context, commentIndex) {
                                            return Align(
                                              child: Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                  margin: EdgeInsets.only(right: Get.width / 6, bottom: 15),
                                                  width: Get.width,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.backGroundDisabled.withOpacity(0.5),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                          children: [
                                                            const SizedBox(
                                                              height: 4,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              children: [
                                                                reservationController.commentList[index].replies[commentIndex].replier == 'مدیریت اقامتگاه'
                                                                    ? Container(
                                                                        width: 12,
                                                                        height: 12,
                                                                        decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.mainColor),
                                                                        child: const Icon(
                                                                          Icons.done,
                                                                          size: 8,
                                                                          color: Colors.white,
                                                                        ))
                                                                    : Container(
                                                                        width: 12,
                                                                        height: 12,
                                                                        decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.acceptedGuest),
                                                                        child: const Icon(
                                                                          Icons.done,
                                                                          size: 8,
                                                                          color: Colors.white,
                                                                        )),
                                                                const SizedBox(width: 5),
                                                                Text('پاسخ: ${reservationController.commentList[index].replies[commentIndex].replier}', style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: Colors.black.withOpacity(0.6))),
                                                              ],
                                                            ),
                                                            Text(
                                                              DateTime.parse(reservationController.commentList[index].replies[commentIndex].replyDate ?? DateTime.now().toString()).toPersianDateStr(strMonth: true),
                                                              style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.grayColor),
                                                              textDirection: TextDirection.rtl,
                                                            ),
                                                            const Divider(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              reservationController.commentList[index].replies[commentIndex].replyComment!,
                                                              textAlign: TextAlign.right,
                                                              textDirection: TextDirection.rtl,
                                                              style: Theme.of(Get.context!).textTheme.titleMedium,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      Container(
                                                        clipBehavior: Clip.hardEdge,
                                                        width: 30,
                                                        height: 30,
                                                        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all()),
                                                        child: CachedNetworkImage(
                                                          imageUrl: reservationController.commentList[index].replies[commentIndex].replyAvatar ?? '',
                                                          errorWidget: (context, url, error) {
                                                            return Container(
                                                              clipBehavior: Clip.hardEdge,
                                                              width: 30,
                                                              height: 30,
                                                              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all()),
                                                              child: const Icon(
                                                                Icons.done,
                                                                size: 8,
                                                                color: Colors.white,
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                            );
                                          },
                                          separatorBuilder: (context, commentIndex) {
                                            return const SizedBox(height: 5);
                                          },
                                          itemCount: reservationController.commentList[index].replies.length)
                                      : const SizedBox(),
                                  SizedBox(
                                    width: Get.width,
                                    child: Wrap(
                                      crossAxisAlignment: WrapCrossAlignment.start,
                                      runAlignment: WrapAlignment.end,
                                      alignment: WrapAlignment.center,
                                      textDirection: TextDirection.rtl,
                                      spacing: 25,
                                      runSpacing: 15,
                                      children: [
                                        Tooltip(
                                          message: reservationController.commentList[index].option1?.title ?? 'امتیاز کلی (ارزش خرید نسبت به کیفیت و هزینه)',
                                          triggerMode: TooltipTriggerMode.tap,
                                          child: customProgress(width: Get.width / 9, centerText: reservationController.commentList[index].option1?.point ?? '-', endColor: AppColors.mainColor, startColor: AppColors.mainColor, fontSize: 10, percent: double.parse(reservationController.commentList[index].option1?.point ?? '0') / 10, footer: 'امتیاز کلی', radius: 15),
                                        ),
                                        Tooltip(
                                          message: reservationController.commentList[index].option2?.title ?? 'تمیزی اتاق و وسایل',
                                          triggerMode: TooltipTriggerMode.tap,
                                          child: customProgress(width: Get.width / 9, centerText: reservationController.commentList[index].option2?.point ?? '-', endColor: AppColors.mainColor, startColor: AppColors.mainColor, fontSize: 10, percent: double.parse(reservationController.commentList[index].option2?.point ?? '0') / 10, footer: 'تمیزی اتاق', radius: 15),
                                        ),
                                        Tooltip(
                                          message: reservationController.commentList[index].option3?.title ?? 'کیفیت و تنوع غذا',
                                          triggerMode: TooltipTriggerMode.tap,
                                          child: customProgress(centerText: reservationController.commentList[index].option3?.point ?? '_', endColor: AppColors.mainColor, startColor: AppColors.mainColor, width: Get.width / 9, fontSize: 10, percent: double.parse(reservationController.commentList[index].option3?.point ?? '0') / 10, footer: 'کیفیت و تنوع غذا', radius: 15),
                                        ),
                                        Tooltip(
                                          message: reservationController.commentList[index].option4?.title ?? 'برخورد پرسنل و پذیرش',
                                          triggerMode: TooltipTriggerMode.tap,
                                          child: customProgress(centerText: reservationController.commentList[index].option4?.point ?? '-', endColor: AppColors.mainColor, width: Get.width / 9, startColor: AppColors.mainColor, fontSize: 10, percent: double.parse(reservationController.commentList[index].option4?.point ?? '0') / 10, footer: 'برخورد پرسنل', radius: 15),
                                        ),
                                        Tooltip(
                                          message: reservationController.commentList[index].option5?.title ?? 'میزان رضایت از سایت رزرو',
                                          triggerMode: TooltipTriggerMode.tap,
                                          child: customProgress(centerText: reservationController.commentList[index].option5?.point ?? '-', endColor: AppColors.mainColor, width: Get.width / 9, startColor: AppColors.mainColor, fontSize: 10, percent: double.parse(reservationController.commentList[index].option5?.point ?? '0') / 10, footer: 'رضایت از سایت رزرو', radius: 15),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              height: 25,
                              thickness: 1.25,
                            );
                          },
                          itemCount: reservationController.commentList.length),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(() {
                        if (reservationController.hasMoreComment.value) {
                          if (!reservationController.loadMore.value) {
                            return TextButton(
                              onPressed: () {
                                reservationController.commentsPages.value += 1;
                                reservationController.loadMoreComment();
                              },
                              child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: AppColors.mainColor, width: 0.5)), child: const Text('نمایش بیشتر')),
                            );
                          } else {
                            return SizedBox(
                              width: Get.width / 7,
                              height: Get.width / 6.5,
                              child: const Align(
                                child: CircularProgressIndicator(
                                  strokeWidth: 1,
                                  color: AppColors.mainColor,
                                ),
                              ),
                            );
                          }
                        } else {
                          return const SizedBox();
                        }
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )),
            ),
          );
        }
      }
    });
  }

  cancelingRules(ReservationController reservationController) {
    return Obx(() {
      if (reservationController.loading.value) {
        return const SizedBox();
      } else {
        return Column(children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.black26,
              ),
            ),
            child: Theme(
              data: Theme.of(Get.context!).copyWith(
                listTileTheme: ListTileTheme.of(Get.context!).copyWith(dense: true),
              ),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ExpansionTile(
                  onExpansionChanged: (value) {
                    reservationController.cancelingRules.value = value;
                  },
                  initiallyExpanded: false,
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  expandedAlignment: Alignment.topRight,
                  childrenPadding: const EdgeInsets.symmetric(horizontal: 15),
                  shape: Border.all(color: Colors.transparent),
                  title: Row(
                    children: [
                      Text(
                        'شرایط کنسلی',
                        style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: AppColors.disabledText),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  children: [
                    Container(
                      height: 0.5,
                      color: AppColors.grayColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      reservationController.room.value!.data.rules.cancelTerms??'-',
                      textAlign: TextAlign.justify,
                      textDirection: TextDirection.rtl,
                      style: Theme.of(Get.context!).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.black26,
              ),
            ),
            child: Theme(
              data: Theme.of(Get.context!).copyWith(
                listTileTheme: ListTileTheme.of(Get.context!).copyWith(dense: true),
              ),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ExpansionTile(
                  onExpansionChanged: (value) {
                    reservationController.cancelingRules.value = value;
                  },
                  initiallyExpanded: false,
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  expandedAlignment: Alignment.topRight,
                  childrenPadding: const EdgeInsets.symmetric(horizontal: 15),
                  shape: Border.all(color: Colors.transparent),
                  title: Row(
                    children: [
                      Text(
                        'قوانین خردسال',
                        style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: AppColors.disabledText),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  children: [
                    Container(
                      height: 0.5,
                      color: AppColors.grayColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      reservationController.room.value!.data.rules.kidsTerms,
                      textAlign: TextAlign.justify,
                      textDirection: TextDirection.rtl,
                      style: Theme.of(Get.context!).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ]);
      }
    });
  }

  suggestion(ReservationController reservationController) {
    return Obx(() {
      if (reservationController.loading.value) {
        return Column(children: [
          Text('پیشنهادهایی برای شما', style: Theme.of(Get.context!).textTheme.bodyMedium),
          const SizedBox(
            height: 25,
          ),
          SizedBox(
            width: MediaQuery.of(Get.context!).size.width,
            height: 220,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ListView.separated(
                scrollDirection: axisDirectionToAxis(flipAxisDirection(AxisDirection.right)),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                physics: const BouncingScrollPhysics(),
                itemCount: 3,
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 15);
                },
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      width: MediaQuery.of(context).size.width / 2.5,
                    ),
                  );
                },
              ),
            ),
          ),
        ]);
      } else {
        return Column(children: [
          Text('پیشنهادهایی برای شما', style: Theme.of(Get.context!).textTheme.bodyMedium),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment:Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: InkWell(
                onTap: (){
                  reservationController.fetchSuggestion(link: reservationController.room.value!.data.province);
                  suggestionBottomSheet(reservationController,reservationController.room.value!.data.province);
                },
                borderRadius: BorderRadius.circular(5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical:5.0),
                  child: Row(
                    mainAxisAlignment:MainAxisAlignment.end,
                    mainAxisSize:MainAxisSize.min,
                    children: [
                      Text('لیست اقامت های بوم گردی ${reservationController.room.value!.data.province}', style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: AppColors.mainColor)),
                      const SizedBox(width:5),
                      const Icon(Icons.arrow_forward_ios_rounded,color:AppColors.mainColor,size:20),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Align(
            alignment:Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: InkWell(
                onTap: (){
                  reservationController.fetchSuggestion(link: reservationController.room.value!.data.city);
                  suggestionBottomSheet(reservationController,reservationController.room.value!.data.city);
                },
                borderRadius: BorderRadius.circular(5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical:5.0),
                  child: Row(
                    mainAxisAlignment:MainAxisAlignment.end,
                    mainAxisSize:MainAxisSize.min,
                    children: [
                      const Icon(Icons.arrow_back_ios_rounded,color:AppColors.mainColor,size:20),
                      const SizedBox(width:5),
                      Text('لیست اقامت های بوم گردی ${reservationController.room.value!.data.city}', style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: AppColors.mainColor)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          SizedBox(
            width: MediaQuery.of(Get.context!).size.width,
            height: 220,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ListView.separated(
                scrollDirection: axisDirectionToAxis(flipAxisDirection(AxisDirection.right)),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                physics: const BouncingScrollPhysics(),
                controller: reservationController.roomSugestionController,
                itemCount: reservationController.room.value!.data.ecolodgeSuggestions.data.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 15);
                },
                itemBuilder: (context, index) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(22),
                    onTap: () {
                      reservationController.durationValue.value = 1;
                      reservationController.mainScrollController.jumpTo(0.0);
                      reservationController.url = reservationController.room.value!.data.ecolodgeSuggestions.data[index].url;
                      reservationController.getMainInfo(roomUrl: reservationController.room.value!.data.ecolodgeSuggestions.data[index].url);
                    },
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: reservationController.room.value!.data.ecolodgeSuggestions.data[index].image,
                          fit: BoxFit.cover,
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              clipBehavior: Clip.none,
                              constraints: BoxConstraints(minWidth: Get.width / 2.5),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, stops: const [
                                    0.50,
                                    30
                                  ], colors: [
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
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                    child: Text(
                                      reservationController.room.value!.data.ecolodgeSuggestions.data[index].title,
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          errorWidget: (context, url, error) => const Icon(Icons.broken_image_outlined),
                        ),
                        CachedNetworkImage(
                          imageUrl: reservationController.room.value!.data.ecolodgeSuggestions.data[index].image,
                          fit: BoxFit.cover,
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              clipBehavior: Clip.none,
                              constraints: BoxConstraints(minWidth: Get.width / 2.5),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, stops: const [
                                    0.80,
                                    0.98
                                  ], colors: [
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
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                    child: Text(
                                      reservationController.room.value!.data.ecolodgeSuggestions.data[index].title,
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          errorWidget: (context, url, error) => const Icon(Icons.broken_image_outlined),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ]);
      }
    });
  }

  sendComment(ReservationController reservationController) {
    return Get.bottomSheet(
        isScrollControlled: true,
        SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    icon: const Icon(
                      Icons.cancel_rounded,
                      color: AppColors.grayColor,
                    )),
                Expanded(child: Text('ثبت نظر برای ${reservationController.room.value!.data.title}', textAlign: TextAlign.center, style: Theme.of(Get.context!).textTheme.labelLarge)),
              ]),
              const SizedBox(
                height: 15,
              ),
              FocusScope(
                child: Focus(
                  onFocusChange: (value) {
                    reservationController.isTextFieldSelected.value = value;
                  },
                  child: Obx(() => MyTextField(
                        label: 'نام',
                        textEditingController: reservationController.nameController,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[ا-ی ئ و ]'))],
                        maxline: 1,
                        onEditingComplete: () {
                          reservationController.isTextFieldSelected.value = false;
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        keyboardType: TextInputType.name,
                        verticalScrollPadding: 15,
                        iconButton: reservationController.isTextFieldSelected.value
                            ? IconButton(
                                onPressed: () {
                                  reservationController.nameController.clear();
                                },
                                splashRadius: 20,
                                icon: SvgPicture.asset('assets/icons/close_ic.svg'))
                            : null,
                        textInputAction: TextInputAction.next,
                      )),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              MyTextField(
                label: 'پست الکترونیکی',
                hintText: 'پست الکترونیکی (اختیاری)',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9@_]')),
                ],
                textEditingController: reservationController.emailController,
                maxline: 1,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(
                height: 25,
              ),
              MyTextField(
                label: 'نظر شما',
                textEditingController: reservationController.commentController,
                verticalScrollPadding: 15,
                maxline: 6,
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: Get.width,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    reservationController.sendReply();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      )),
                  child: Text('ارسال نظر', style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color: Colors.white)),
                ),
              )
            ]),
          ),
        ),
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(28), topLeft: Radius.circular(28))));
  }

  String oneNightPrice(List<Day> days) {
    for (Day day in days) {
      if (day.originalPrice > 0) {
        return day.originalPrice.toString().seRagham();
      }
    }
    return '0';
  }

  void onRefresh(ReservationController reservationController, String url) async {
    if (reservationController.durationValue.value == 0) {
      reservationController.getMainInfo(roomUrl: url);
    } else {
      reservationController.getMainInfo(roomUrl: url);
      reservationController.choseEntryDate();
    }
  }

  userImages(ReservationController reservationController) {
    if (reservationController.room.value!.data.commentsFiles.isEmpty) {
      return const SizedBox();
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 15),
            const Text('تصاویر ارسالی کاربران'),
            const SizedBox(height: 15),
            Row(
              children: [
                reservationController.room.value!.data.commentsFiles.length >= 3
                    ? InkWell(
                        onTap: () {
                          reservationController.userImages.value = true;
                          dialogImagesView(reservationController);
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(border: Border.all(color: AppColors.mainColor, width: 0.8), borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              'مشاهده همه تصاویر',
                              style: Theme.of(Get.context!).textTheme.bodySmall,
                            )),
                      )
                    : const SizedBox(),
                const SizedBox(width: 10),
                reservationController.room.value!.data.commentsFiles.isNotEmpty
                    ? Expanded(
                        child: CachedNetworkImage(
                            imageUrl: reservationController.room.value!.data.commentsFiles[0].fileName,
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
                                height: Get.height * 0.15,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Container(
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(25),
                                          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, stops: const [
                                            0.50,
                                            1
                                          ], colors: [
                                            Colors.transparent,
                                            Colors.black.withOpacity(1),
                                          ])),
                                      width: MediaQuery.of(context).size.width,
                                      height: 110,
                                    ),
                                  ],
                                ),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return Container(
                                clipBehavior: Clip.none,
                                width: MediaQuery.of(context).size.width,
                                height: 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Image.asset(
                                  'assets/images/image_not_available.png',
                                  fit: BoxFit.cover,
                                ),
                              );
                            }))
                    : const SizedBox(),
                const SizedBox(width: 10),
                reservationController.room.value!.data.commentsFiles.length >= 2
                    ? Expanded(
                        child: CachedNetworkImage(
                            imageUrl: reservationController.room.value!.data.commentsFiles[1].fileName,
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
                                height: Get.height * 0.15,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Container(
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(25),
                                          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, stops: const [
                                            0.50,
                                            1
                                          ], colors: [
                                            Colors.transparent,
                                            Colors.black.withOpacity(1),
                                          ])),
                                      width: MediaQuery.of(context).size.width,
                                      height: 110,
                                    ),
                                  ],
                                ),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return Container(
                                clipBehavior: Clip.none,
                                width: MediaQuery.of(context).size.width,
                                height: 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Image.asset(
                                  'assets/images/image_not_available.png',
                                  fit: BoxFit.cover,
                                ),
                              );
                            }))
                    : const SizedBox(),
                const SizedBox(width: 10),
                reservationController.room.value!.data.commentsFiles.length >= 3
                    ? Expanded(
                        child: CachedNetworkImage(
                            imageUrl: reservationController.room.value!.data.commentsFiles[2].fileName,
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
                                height: Get.height * 0.15,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Container(
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(25),
                                          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, stops: const [
                                            0.50,
                                            1
                                          ], colors: [
                                            Colors.transparent,
                                            Colors.black.withOpacity(1),
                                          ])),
                                      width: MediaQuery.of(context).size.width,
                                      height: 110,
                                    ),
                                  ],
                                ),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return Container(
                                clipBehavior: Clip.none,
                                width: MediaQuery.of(context).size.width,
                                height: 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Image.asset(
                                  'assets/images/image_not_available.png',
                                  fit: BoxFit.cover,
                                ),
                              );
                            }))
                    : const SizedBox(),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              height: 1,
              width: Get.width,
              color: Colors.black.withOpacity(0.1),
            ),
          ],
        ),
      );
    }
  }


  suggestionBottomSheet(ReservationController mainCtr,String city){
    return Get.bottomSheet(
        isScrollControlled: true,
        SizedBox(
          width:Get.width,
          height:Get.height,
          child: SafeArea(
            top: true,
            child: SingleChildScrollView(
              controller: mainCtr.bottomSheetScreenScrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 50,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      padding:const EdgeInsets.only(bottom: 5,left: 15),
                      margin: const EdgeInsets.only(bottom:10),
                      decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1.5,color:AppColors.mainColor))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('اقامتگاه های بومگردی ${city}',style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(color:AppColors.mainColor),textDirection: TextDirection.rtl,),
                        ],
                      ),
                    ),
                  ),
                  Obx(() =>
                  mainCtr.suggestionLoading.value ? loading() : body(mainCtr),
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(28), topLeft: Radius.circular(28))));
  }

  Widget loading(){
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView.separated(
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 25,
                );
              },
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 15, top: 15),
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), boxShadow: [
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
                    ]),
                    width: MediaQuery.of(context).size.width,
                    height: 160,
                  ),
                );
              }),
        ),
      ),
    );
  }

  Widget body(ReservationController mainCtr){
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView.separated(
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 25,
                );
              },
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 15, top: 15),
              itemCount: mainCtr.ecolodgesResult.isEmpty ? 5 : mainCtr.ecolodgesResult.length + 1,
              itemBuilder: (context, index) {
                if (!mainCtr.loadMoreSuggest.value && index < mainCtr.ecolodgesResult.length) {
                  return InkWell(
                    onTap: () {

                      //TODO:
                      mainCtr.url = mainCtr.ecolodgesResult[index].url;
                      mainCtr.getMainInfo(roomUrl: mainCtr.ecolodgesResult[index].url);
                      mainCtr.mainScrollController.animateTo(0,                  duration: Duration(milliseconds: 500), //duration of scroll
                          curve:Curves.fastOutSlowIn);
                      Get.back();
                      mainCtr.ecolodgesResult.clear();

                    },
                    borderRadius: BorderRadius.circular(25),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), boxShadow: [
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
                            ]),
                            width: MediaQuery.of(context).size.width,
                            height: 160,
                            child: CachedNetworkImage(
                              imageUrl: mainCtr.ecolodgesResult[index].image,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => const Icon(Icons.broken_image_outlined),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, stops: const [
                                  0.50,
                                  30
                                ], colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(1),
                                ])),
                            width: MediaQuery.of(context).size.width,
                            height: 160,
                          ),
                        ),
                        if (mainCtr.ecolodgesResult[index].maxDiscountPercent != null && mainCtr.ecolodgesResult[index].maxDiscountPercent! > 0)
                          Positioned(
                            right: Get.width * 0.10,
                            top: 0,
                            child: Container(
                              height: 25,
                              width: 40,
                              decoration: const BoxDecoration(color: Color(0xffEA213B), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))),
                              child: Center(child: Text('${mainCtr.ecolodgesResult[index].maxDiscountPercent}%', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white))),
                            ),
                          )
                        else
                          const SizedBox(),
                        Positioned(
                          right: 0,
                          bottom: Get.width * 0.08,
                          width: Get.width,
                          child: Container(
                            margin: EdgeInsets.only(right: Get.width * 0.05, left: Get.width * 0.13),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  mainCtr.ecolodgesResult[index].title,
                                  style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SvgPicture.asset('assets/icons/location_small_pin_ic.svg', color: Colors.white, width: 18),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Text(
                                        mainCtr.ecolodgesResult[index].address,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.elliptical(45, 50), topRight: Radius.elliptical(45, 50))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                            child: Text(
                              mainCtr.ecolodgesResult[index].minPrice == 0 ? 'تماس با پشتیبانی' : '${mainCtr.ecolodgesResult[index].minPrice?.toString().beToman().seRagham()} ${checkCurrency(mainCtr.ecolodgesResult[index].currency)}/${mainCtr.ecolodgesResult[index].unitPrice}',
                              maxLines: 1,
                              style: Theme.of(context).textTheme.labelMedium!.copyWith(color: AppColors.mainColor),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
                if (!mainCtr.loadMoreSuggest.value && mainCtr.nextLinkSuggest.value == 'null') {
                  return const SizedBox();
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }


}
