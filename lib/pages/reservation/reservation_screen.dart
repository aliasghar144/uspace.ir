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
import 'package:uspace_ir/app/utils/custom_tab_indicator.dart';
import 'package:uspace_ir/controllers/reservation_controller.dart';
import 'package:uspace_ir/models/room_reservation_model.dart';
import 'package:uspace_ir/pages/reservation/reserve_room_screen.dart';
import 'package:uspace_ir/widgets/comment_rate_bar.dart';
import 'package:uspace_ir/widgets/facilites_dialog.dart';
import 'package:uspace_ir/widgets/single_image_view.dart';
import 'package:uspace_ir/widgets/textfield.dart';

class ReservationScreen extends StatelessWidget {
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String url = Get.arguments['url'] ?? '';
    ReservationController reservationController = Get.put(ReservationController(url));
    return DefaultTabController(
      length: 3,
      initialIndex: 2,
      child: Scaffold(
        body: NestedScrollView(
            controller: reservationController.screenScrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  leading: Padding(
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
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                ),
                SliverToBoxAdapter(
                  child: _buildBody(reservationController),
                )
              ];
            },
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                comments(reservationController),
                details(reservationController),
                rooms(reservationController),
              ],
            )),
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
            Obx(
              () => reservationController.tabIndex.value == 1
                  ? Align(
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
                                                  reservationController.room.value!.data.rules.kidsTerms ?? '-',
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
                                                reservationController.room.value!.data.rules.cancelTerms ?? '',
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
                  : const SizedBox(),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      ),
    );
  }

  _buildBody(ReservationController reservationController) {
    return Obx(() => reservationController.loading.value
        ? Column(
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
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          reservationController.isFave.toggle();
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Obx(() => Icon(reservationController.isFave.value ? Icons.favorite_rounded : Icons.favorite_border_rounded, color: reservationController.isFave.value ? Colors.red : null, size: 23)),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SvgPicture.asset('assets/icons/share_line_ic.svg'),
                        )),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                            height: 10,
                          )),
                    )
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
              const SizedBox(
                height: 30,
              ),
              Container(
                  width: Get.width,
                  height: 50,
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
                                  reservationController.setSelectedDuration(value!);
                                },
                                value: reservationController.durationValue.value == "" ? null : reservationController.durationValue.value,
                                buttonStyleData: ButtonStyleData(
                                  height: 35,
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
                          Jalali? picked = await showPersianDatePicker(
                            context: Get.context!,
                            helpText: '',
                            initialEntryMode: PDatePickerEntryMode.calendarOnly,
                            initialDate: reservationController.entryDate.value.toJalali(),
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
                          }
                        },
                        child: Container(
                            height: 35,
                            width: Get.width / 2 - 50,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: AppColors.grayColor, width: 0.3),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(children: [
                                const Icon(Icons.arrow_drop_down_rounded, color: AppColors.disabledIcon),
                                const Spacer(),
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
                  )),
              const SizedBox(
                height: 5,
              ),
              TabBar(
                  labelColor: AppColors.primaryTextColor,
                  unselectedLabelColor: AppColors.disabledText,
                  labelPadding: EdgeInsets.zero,
                  onTap: (value) {
                    reservationController.tabIndex.value = value;
                  },
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  indicator: const CustomTabIndicator(
                    color: AppColors.mainColor,
                    indicatorHeight: 3,
                    radius: 4,
                  ),
                  tabs: [
                    Tab(
                        child: Center(
                      child: Text(
                        "نظرات",
                        style: Theme.of(Get.context!).textTheme.labelLarge,
                      ),
                    )),
                    Tab(
                        child: Center(
                      child: Text(
                        "توضیحات",
                        style: Theme.of(Get.context!).textTheme.labelLarge,
                      ),
                    )),
                    Tab(
                        child: Center(
                      child: Text(
                        "اتاق ها",
                        style: Theme.of(Get.context!).textTheme.labelLarge,
                      ),
                    )),
                  ])
            ],
          )
        : Column(
            children: [
              SizedBox(
                width: MediaQuery.of(Get.context!).size.width,
                height: 200,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: PageView.builder(
                      scrollDirection: axisDirectionToAxis(flipAxisDirection(AxisDirection.right)),
                      allowImplicitScrolling: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: reservationController.room.value!.data.imageList.length + 1,
                      controller: reservationController.pageController,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(SingleImageView(), arguments: {'image': reservationController.room.value!.data.mainImage});
                                  },
                                  child: CachedNetworkImage(
                                    imageUrl: reservationController.room.value!.data.mainImage,
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
                                              top: Get.width * 0.16,
                                              child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(color: Colors.white, boxShadow: [const BoxShadow(color: Colors.black12, spreadRadius: 1.2, blurRadius: 2.75, offset: Offset(1.5, 0)), BoxShadow(color: AppColors.mainColor.withOpacity(0.1), spreadRadius: 1.2, blurRadius: 2.75, offset: const Offset(1.5, 0))], shape: BoxShape.circle),
                                                  child: Center(
                                                      child: IconButton(
                                                    splashRadius: 18,
                                                    onPressed: () {
                                                      if (index != 2) {
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
                                              right: -10,
                                              top: Get.width * 0.16,
                                              child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(color: Colors.white, boxShadow: [const BoxShadow(color: Colors.black12, spreadRadius: 1.2, blurRadius: 2.75, offset: Offset(1.5, 0)), BoxShadow(color: AppColors.mainColor.withOpacity(0.1), spreadRadius: 1.2, blurRadius: 2.75, offset: const Offset(1.5, 0))], shape: BoxShape.circle),
                                                  child: IconButton(
                                                      splashRadius: 18,
                                                      onPressed: () {
                                                        if (index != 0) {
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
                                                reservationController.room.value!.data.title,
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    errorWidget: (context, url, error) => const Icon(Icons.broken_image_outlined),
                                  ),
                                ),
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
                                    Get.to(SingleImageView(), arguments: {'image': 'https://www.uspace.ir/spaces/${reservationController.url}/images/main/${reservationController.room.value!.data.imageList[index - 1].fullImage}'});
                                  },
                                  child: CachedNetworkImage(
                                    imageUrl: 'https://www.uspace.ir/spaces/${reservationController.url}/images/main/${reservationController.room.value!.data.imageList[index - 1].fullImage}',
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
                                              top: Get.width * 0.16,
                                              child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(color: Colors.white, boxShadow: [const BoxShadow(color: Colors.black12, spreadRadius: 1.2, blurRadius: 2.75, offset: Offset(1.5, 0)), BoxShadow(color: AppColors.mainColor.withOpacity(0.1), spreadRadius: 1.2, blurRadius: 2.75, offset: const Offset(1.5, 0))], shape: BoxShape.circle),
                                                  child: Center(
                                                      child: IconButton(
                                                    splashRadius: 18,
                                                    onPressed: () {
                                                      if (index != reservationController.room.value!.data.imageList.length) {
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
                                              right: -10,
                                              top: Get.width * 0.16,
                                              child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(color: Colors.white, boxShadow: [const BoxShadow(color: Colors.black12, spreadRadius: 1.2, blurRadius: 2.75, offset: Offset(1.5, 0)), BoxShadow(color: AppColors.mainColor.withOpacity(0.1), spreadRadius: 1.2, blurRadius: 2.75, offset: const Offset(1.5, 0))], shape: BoxShape.circle),
                                                  child: IconButton(
                                                      splashRadius: 18,
                                                      onPressed: () {
                                                        if (index != 0) {
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
                                                reservationController.room.value!.data.imageList[index - 1].caption ?? '',
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
                                    errorWidget: (context, url, error) => const Icon(Icons.broken_image_outlined),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      }),
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
                      CachedNetworkImage(
                        imageUrl: reservationController.room.value!.data.mainImageThumb,
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
                              imagesView(reservationController);
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
                              imagesView(reservationController);
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
                      Flexible(
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
                            return InkWell(
                              onTap: () {
                                imagesView(reservationController);
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
                            reservationController.pageController.animateToPage(1, duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
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
                      ),
                      const SizedBox(width: 5),
                      Flexible(
                        child: InkWell(
                          onTap: () {
                            reservationController.pageController.animateToPage(0, duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
                          },
                          child: CachedNetworkImage(
                            imageUrl: reservationController.room.value!.data.mainImageThumb,
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
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          reservationController.isFave.toggle();
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Obx(() => Icon(reservationController.isFave.value ? Icons.favorite_rounded : Icons.favorite_border_rounded, color: reservationController.isFave.value ? Colors.red : null, size: 23)),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SvgPicture.asset('assets/icons/share_line_ic.svg'),
                        )),
                    Expanded(
                        child: Text(reservationController.room.value!.data.title, style: Theme.of(Get.context!).textTheme.displayMedium,overflow: TextOverflow.fade,textAlign: TextAlign.end,)),
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
                    Text('9.4/10', textDirection: TextDirection.rtl, style: Theme.of(Get.context!).textTheme.labelMedium),
                    const SizedBox(
                      width: 5,
                    ),
                    Text('(39852 بازدید)', textDirection: TextDirection.rtl, style: Theme.of(Get.context!).textTheme.labelMedium),
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
              const SizedBox(
                height: 30,
              ),
              Container(
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
                                value: reservationController.durationValue.value == "" ? null : reservationController.durationValue.value,
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
                            }
                            reservationController.choseEntryDate();
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
                  )),
              const SizedBox(
                height: 5,
              ),
              TabBar(
                  labelColor: AppColors.primaryTextColor,
                  unselectedLabelColor: AppColors.disabledText,
                  labelPadding: EdgeInsets.zero,
                  onTap: (value) {
                    reservationController.tabIndex.value = value;
                  },
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  indicator: const CustomTabIndicator(
                    color: AppColors.mainColor,
                    indicatorHeight: 3,
                    radius: 4,
                  ),
                  tabs: [
                    Tab(
                        child: Center(
                      child: Text(
                        "نظرات",
                        style: Theme.of(Get.context!).textTheme.labelLarge,
                      ),
                    )),
                    Tab(
                        child: Center(
                      child: Text(
                        "توضیحات",
                        style: Theme.of(Get.context!).textTheme.labelLarge,
                      ),
                    )),
                    Tab(
                        child: Center(
                      child: Text(
                        "اتاق ها",
                        style: Theme.of(Get.context!).textTheme.labelLarge,
                      ),
                    )),
                  ])
            ],
          ));
  }

  imagesView(ReservationController reservationController) {
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
                Flexible(
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
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: reservationController.room.value!.data.imageList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.to(SingleImageView(), arguments: {'image': 'https://www.uspace.ir/spaces/${reservationController.url}/images/main/${reservationController.room.value!.data.imageList[index].fullImage}'});
                    },
                    child: Hero(
                      tag: 'singleImage',
                      child: CachedNetworkImage(
                        imageUrl: 'https://www.uspace.ir/spaces/${reservationController.url}/images/thumb/${reservationController.room.value!.data.imageList[index].thumbImage}',
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
              )),
          const SizedBox(
            height: 20,
          ),
        ]),
      ),
    );
  }

  rooms(ReservationController reservationController) {
    return Obx(() => reservationController.loading.value || reservationController.loadingRoom.value
        ? ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                dragStartBehavior: DragStartBehavior.down,
                child: Column(children: [
                  Container(
                    height: 1,
                    width: Get.width,
                    color: Colors.black.withOpacity(0.1),
                  ),
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
                  const SizedBox(
                    height: 135,
                  ),
                ])),
          )
        : ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                dragStartBehavior: DragStartBehavior.down,
                child: Column(children: [
                  Container(
                    height: 1,
                    width: Get.width,
                    color: Colors.black.withOpacity(0.1),
                  ),
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
                                        InkWell(
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
                                        if (reservationController.room.value!.data.rooms[roomsIndex].details == null) const SizedBox() else Text(reservationController.room.value!.data.rooms[roomsIndex].details ?? '', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: Colors.grey), maxLines: 2, textDirection: TextDirection.rtl, softWrap: true, overflow: TextOverflow.ellipsis),
                                        reservationController.durationValue.value != 1 && reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.totalCustomerDiscount == 0
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
                                        reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.totalCustomerDiscount != 0
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
                                        reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.totalCustomerDiscount != 0
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
                                        Container(
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
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                mainAxisAlignment:MainAxisAlignment.end,
                                  children:[
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
                                  ]
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              alignment: Alignment.topRight,
                              height: Get.height * 0.09,
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
                                        width: Get.width / 4.55,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 0.4, color: AppColors.mainColor)),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: Get.width / 4.55,
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
                                                overflow: TextOverflow.ellipsis,
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
                            Container(
                                width:Get.width,
                                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1), borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5))),
                                child: Get.width > 360
                                    ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                        InkWell(
                                          onTap: () {
                                            if (reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.reservePermission) {
                                              Get.to(() => RoomReservationScreen(), arguments: {
                                                'roomsIndex': roomsIndex,
                                              });
                                              // Get.to(RoomReservationScreen(), arguments: {
                                              //   'roomsIndex': roomsIndex,
                                              // });
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
                                                child: Row(
                                                        mainAxisSize:MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.center, children: [
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
                                                child: Row(
                                                    mainAxisSize:MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.center, children: [
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
                                                child: Row(
                                                    mainAxisSize:MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.center, children: [
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
                                                Get.to(() => RoomReservationScreen(), arguments: {
                                                  'roomsIndex': roomsIndex,
                                                });
                                                // Get.to(RoomReservationScreen(), arguments: {
                                                //   'roomsIndex': roomsIndex,
                                                // });
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
                  const SizedBox(
                    height: 15,
                  ),
                  Text('پیشنهادهایی برای شما', style: Theme.of(Get.context!).textTheme.bodyMedium),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('لیست اقامت های بوم گردی ${reservationController.room.value!.data.province}', style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: AppColors.mainColor)),
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
                        itemCount: reservationController.room.value!.data.ecolodgeSuggestions.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(width: 15);
                        },
                        itemBuilder: (context, index) {
                          return InkWell(
                            borderRadius: BorderRadius.circular(22),
                            onTap: () {
                              reservationController.durationValue.value = 1;
                              reservationController.screenScrollController.jumpTo(0.0);
                              reservationController.url = reservationController.room.value!.data.ecolodgeSuggestions[index].url;
                              reservationController.getMainInfo(roomUrl: reservationController.room.value!.data.ecolodgeSuggestions[index].url);
                            },
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: reservationController.room.value!.data.ecolodgeSuggestions[index].image,
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
                                              reservationController.room.value!.data.ecolodgeSuggestions[index].title,
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
                                  imageUrl: reservationController.room.value!.data.ecolodgeSuggestions[index].image,
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
                                              reservationController.room.value!.data.ecolodgeSuggestions[index].title,
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
                  const SizedBox(
                    height: 135,
                  ),
                ])),
          ));
  }

  details(ReservationController reservationController) {
    return Obx(() => reservationController.loading.value
        ? ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              dragStartBehavior: DragStartBehavior.down,
              child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Container(
                  height: 1,
                  width: Get.width,
                  color: Colors.black.withOpacity(0.1),
                ),
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
              child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Container(
                  height: 1,
                  width: Get.width,
                  color: Colors.black.withOpacity(0.1),
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 15, left: 15, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Html(
                              style:{
                                'body' : Style(
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
                              center: LatLng(reservationController.room.value!.data.mapLong, reservationController.room.value!.data.mapLat),
                              minZoom: 3,
                              maxZoom: 17,
                            ),
                            children: [
                              TileLayer(
                                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                              ),
                              MarkerLayer(markers: [
                                Marker(
                                  rotate: true,
                                  width: 80,
                                  height: 80,
                                  rotateAlignment: Alignment.center,
                                  point: LatLng(reservationController.room.value!.data.mapLong, reservationController.room.value!.data.mapLat),
                                  builder: (ctx) => const Icon(
                                    Icons.location_on,
                                    size: 28,
                                    color: Colors.red,
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
                        const SizedBox(
                          height: 60,
                        ),
                      ],
                    )),
              ]),
            ),
          ));
  }

  comments(ReservationController reservationController) {
    return Obx(() => reservationController.loading.value
        ? ScrollConfiguration(
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
          )
        : reservationController.room.value!.data.comments.isEmpty
            ? ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 1,
                        width: Get.width,
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ],
                  ),
                ),
              )
            : ScrollConfiguration(
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
                                      reservationController.room.value!.data.comments[index].type == 'feedback'
                                          ? Row(
                                              children: [
                                                RateStar(point: reservationController.room.value!.data.comments[index].option1?.point, title: reservationController.room.value!.data.comments[index].option1!.title),
                                                RateStar(point: reservationController.room.value!.data.comments[index].option2?.point, title: reservationController.room.value!.data.comments[index].option2!.title),
                                                RateStar(point: reservationController.room.value!.data.comments[index].option3?.point, title: reservationController.room.value!.data.comments[index].option3!.title),
                                                RateStar(point: reservationController.room.value!.data.comments[index].option4?.point, title: reservationController.room.value!.data.comments[index].option4!.title),
                                                RateStar(point: reservationController.room.value!.data.comments[index].option5?.point, title: reservationController.room.value!.data.comments[index].option5!.title),
                                              ],
                                            )
                                          : const SizedBox(),
                                      const Spacer(),
                                      Column(
                                        crossAxisAlignment:CrossAxisAlignment.end,
                                        children: [
                                          Text(reservationController.room.value!.data.comments[index].name, style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: Colors.black.withOpacity(0.6))),
                                          Row(
                                            mainAxisAlignment:MainAxisAlignment.start,
                                            children: [
                                              Text(reservationController.room.value!.data.comments[index].type == 'feedback' ? 'رزرو کننده اقامتگاه':'رزرو کننده نیست',style:Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color:AppColors.grayColor )),
                                              const SizedBox(width:5),
                                              reservationController.room.value!.data.comments[index].type == 'feedback' ? Container(
                                                  width:12,
                                                  height:12,
                                                  decoration:BoxDecoration(
                                                  shape:BoxShape.circle,
                                                    color: AppColors.acceptedGuest
                                                  ),
                                                  child: Icon(Icons.done,size: 8,color:Colors.white,)) : const SizedBox()
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
                                        child: const Icon(Icons.account_circle_rounded,size: 30),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 48.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        reservationController.room.value!.data.comments[index].comment == null
                                            ? const SizedBox()
                                            : ReadMoreText(
                                                reservationController.room.value!.data.comments[index].comment ?? '',
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
                                        reservationController.room.value!.data.comments[index].comment == null
                                            ? const SizedBox()
                                            : Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                                Text(
                                                  reservationController.room.value!.data.comments[index].date.toPersianDate(),
                                                  style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.grayColor),
                                                  textDirection: TextDirection.rtl,
                                                ),
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
                                                        SvgPicture.asset('assets/icons/reply_ic.svg'),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 6, top: 5.0),
                                                          child: Text('پاسخ', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.mainColor)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ])
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 20);
                          },
                          itemCount: reservationController.room.value!.data.comments.length),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ));
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
}
