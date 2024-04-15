import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/app/utils/color_extenstion.dart';
import 'package:uspace_ir/app/utils/pay_price_calculator.dart';
import 'package:uspace_ir/controllers/order_details_controller.dart';
import 'package:uspace_ir/models/order_model.dart';
import 'package:uspace_ir/pages/history/rules_of_canceling_screen.dart';
import 'package:uspace_ir/widgets/facilites_dialog.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String orderCode;

  const OrderDetailsScreen({required this.orderCode, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OrderDetailsController mainController = Get.put(OrderDetailsController(orderCode));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25))),
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
        actions: [
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 20),
              Container(
                padding: EdgeInsets.only(bottom: 5, left: Get.width * 0.09, right: 25),
                decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: AppColors.mainColor))),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(() => mainController.loading.value
                        ? Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              height: 15,
                              width: Get.width / 5,
                              margin: EdgeInsets.zero,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: const Color(0xffF3F3F3)),
                            ))
                        : Text(
                            mainController.order.value!.data.ecolodge.title,
                            style: Theme.of(Get.context!).textTheme.displayMedium,
                          )),
                    const SizedBox(
                      width: 8,
                    ),
                    const Icon(
                      FontAwesomeIcons.hotel,
                      size: 15,
                      color: AppColors.mainColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Obx(() => ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemBuilder: (context, rsvIndex) {
                      if (mainController.loading.value) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            height: Get.height / 4,
                            width: Get.width,
                            margin: EdgeInsets.zero,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: const Color(0xffF3F3F3)),
                          ),
                        );
                      }

                      return AnimatedSize(
                        curve: Curves.ease,
                        alignment: Alignment.topCenter,
                        duration: const Duration(milliseconds: 500),
                        child: Container(
                            margin: EdgeInsets.zero,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: const Color(0xffF3F3F3), boxShadow: const [
                              BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.14), blurRadius: 4, offset: Offset(0, 4)),
                            ]),
                            child: InkWell(
                              onTap: () {
                                mainController.order.value!.data.rsvItems[rsvIndex].isExpanded.toggle();
                              },
                              child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.end, children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            mainController.order.value!.data.rsvItems[rsvIndex].title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textDirection: TextDirection.rtl,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          RichText(textDirection: TextDirection.rtl, text: TextSpan(children: [TextSpan(text: 'قیمت پرداختی: ', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.grayColor)), TextSpan(text: '${payPriceCalculate(mainController.order.value!.data.rsvItems[rsvIndex].dayAndPrice).toString().seRagham()}تومان', style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color: AppColors.mainColor))]))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      width: Get.width / 6.5,
                                      height: Get.width / 6.5,
                                      child: CachedNetworkImage(
                                        imageUrl: mainController.order.value!.data.rsvItems[rsvIndex].thumbImage,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                RichText(
                                    textDirection: TextDirection.rtl,
                                    text: TextSpan(children: [
                                      TextSpan(text: 'تاریخ ورود:', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.grayColor)),
                                      TextSpan(
                                          text: mainController.order.value!.data.miladiCheckIn.toPersianDateStr(
                                            showDayStr: true,
                                          ),
                                          style: Theme.of(Get.context!).textTheme.labelMedium)
                                    ])),
                                RichText(
                                    textDirection: TextDirection.rtl,
                                    text: TextSpan(children: [
                                      TextSpan(text: 'تاریخ خروج: ', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.grayColor)),
                                      TextSpan(
                                          text: mainController.order.value!.data.miladiCheckIn.add(Duration(days: mainController.order.value!.data.duration)).toPersianDateStr(
                                                showDayStr: true,
                                              ),
                                          style: Theme.of(Get.context!).textTheme.labelMedium)
                                    ])),
                                RichText(
                                  textDirection: TextDirection.rtl,
                                  text: TextSpan(children: [TextSpan(text: 'مدت اقامت: ', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.grayColor)), TextSpan(text: mainController.order.value!.data.duration.toString(), style: Theme.of(Get.context!).textTheme.labelMedium)]),
                                ),
                                RichText(textDirection: TextDirection.rtl, text: TextSpan(children: [TextSpan(text: 'تعداد اتاق: ', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.grayColor)), TextSpan(text: mainController.order.value!.data.rsvItems.length.toString(), style: Theme.of(Get.context!).textTheme.labelMedium)])),
                                RichText(textDirection: TextDirection.rtl, text: TextSpan(children: [TextSpan(text: 'تعداد مهمان: ', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.grayColor)), TextSpan(text: mainController.order.value!.data.rsvItems[rsvIndex].roomCapacity.toString(), style: Theme.of(Get.context!).textTheme.labelMedium)])),
                                Obx(() => mainController.order.value!.data.rsvItems[rsvIndex].isExpanded.value ? onExpansion(rsvItems: mainController.order.value!.data.rsvItems[rsvIndex]) : const SizedBox()),
                                const SizedBox(
                                  height: 10,
                                ),
                                Stack(alignment: Alignment.center, children: [
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: colorStatus(mainController.order.value!.data.status),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              mainController.order.value!.data.status,
                                              style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.white),
                                            ),
                                            const SizedBox(width: 2),
                                            iconStatus(mainController.order.value!.data.status),
                                          ],
                                        )),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Obx(() => Text(mainController.order.value!.data.rsvItems[rsvIndex].isExpanded.value ? 'اطلاعات کمتر' : 'اطلاعات بیشتر',
                                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                              color: mainController.order.value!.data.rsvItems[rsvIndex].isExpanded.value ? AppColors.grayColor : AppColors.mainColor,
                                            ))),
                                  ),
                                ])
                              ]),
                            )),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 15);
                    },
                    itemCount: mainController.loading.value ? 3 : mainController.order.value!.data.rsvItems.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  )),
              const SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(() => mainController.loading.value ? const SizedBox() : button(mainController.order.value!.data.status, mainController)),
    );
  }

  Widget onExpansion({required RsvItem rsvItems}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        RichText(textDirection: TextDirection.rtl, text: TextSpan(children: [TextSpan(text: 'قیمت یک شب: ', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.grayColor)), TextSpan(text: '${payPriceCalculate(rsvItems.dayAndPrice).toString().seRagham()} تومان', style: Theme.of(Get.context!).textTheme.labelMedium)])),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 0.3, color: rsvItems.roomPackages.features[2].value == 1 ? AppColors.mainColor : AppColors.grayColor)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${rsvItems.roomPackages.features[2].feature.title} ${rsvItems.roomPackages.features[2].value == 1 ? 'دارد' : 'ندارد'}',
                    style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: rsvItems.roomPackages.features[2].value == 1 ? AppColors.mainColor : Colors.grey),
                  ),
                  const SizedBox(width: 2),
                  Icon(
                    IconData(
                      int.parse(rsvItems.roomPackages.features[2].feature.unicode, radix: 16),
                      fontFamily: 'FontAwesomeSolid',
                      fontPackage: 'font_awesome_flutter',
                    ),
                    size: 10,
                    color: rsvItems.roomPackages.features[2].value == 1 ? AppColors.mainColor : Colors.grey,
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 0.3, color: rsvItems.roomPackages.features[1].value == 1 ? AppColors.mainColor : Colors.grey)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${rsvItems.roomPackages.features[1].feature.title} ${rsvItems.roomPackages.features[1].value == 1 ? 'دارد' : 'ندارد'}',
                    style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: rsvItems.roomPackages.features[1].value == 1 ? AppColors.mainColor : Colors.grey),
                  ),
                  const SizedBox(width: 2),
                  Icon(
                    IconData(
                      int.parse(rsvItems.roomPackages.features[1].feature.unicode, radix: 16),
                      fontFamily: 'FontAwesomeSolid',
                      fontPackage: 'font_awesome_flutter',
                    ),
                    size: 10,
                    color: rsvItems.roomPackages.features[1].value == 1 ? AppColors.mainColor : Colors.grey,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 0.3, color: rsvItems.roomPackages.features[0].value == 1 ? AppColors.mainColor : Colors.grey)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${rsvItems.roomPackages.features[0].feature.title} ${rsvItems.roomPackages.features[0].value == 1 ? 'دارد' : 'ندارد'}',
                    style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: rsvItems.roomPackages.features[0].value == 1 ? AppColors.mainColor : Colors.grey),
                  ),
                  const SizedBox(width: 2),
                  Icon(
                    IconData(
                      int.parse(rsvItems.roomPackages.features[0].feature.unicode, radix: 16),
                      fontFamily: 'FontAwesomeSolid',
                      fontPackage: 'font_awesome_flutter',
                    ),
                    size: 10,
                    color: rsvItems.roomPackages.features[0].value == 1 ? AppColors.mainColor : Colors.grey,
                  )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                Get.dialog(facilityDialog(roomFeatures: rsvItems.features, title: rsvItems.title, hasBrakeFast: rsvItems.roomPackages.features[0].value, hasDinner: rsvItems.roomPackages.features[1].value, hasLunch: rsvItems.roomPackages.features[2].value));
              },
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.mainColor.withOpacity(0.8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Text('امکانات',
                        style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(
                              color: Colors.white,
                            )),
                    const SizedBox(width: 4),
                    SvgPicture.asset('assets/icons/facilities_ic.svg'),
                  ])),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          height: Get.width / 5.0,
          width: Get.width,
          padding: const EdgeInsets.only(right: 15),
          child: ListView.separated(
            itemCount: rsvItems.dayAndPrice.length,
            shrinkWrap: true,
            reverse: true,
            physics: const BouncingScrollPhysics(),
            // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) {
              return const SizedBox(width: 10);
            },
            itemBuilder: (context, dayIndex) {
              return Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 0.4, color: AppColors.mainColor)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor.withOpacity(0.1),
                      ),
                      child: Text(
                          rsvItems.dayAndPrice[dayIndex].date.toPersianDateStr(
                            showDayStr: true,
                          ),
                          style: Theme.of(Get.context!).textTheme.labelSmall),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'تومان ${rsvItems.dayAndPrice[dayIndex].originalPrice.toString().seRagham()}',
                      style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color: AppColors.grayColor),
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'نفر اضافه ${rsvItems.dayAndPrice[dayIndex].additionalGustPrice.toString().seRagham()}',
                      style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color: AppColors.grayColor),
                      textDirection: TextDirection.rtl,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('موجود', style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color: AppColors.mainColor)),
                        const SizedBox(width: 2),
                        Container(
                            decoration: const BoxDecoration(
                              color: AppColors.mainColor,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(2),
                            child: const Icon(Icons.done_rounded, size: 6, color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 3),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget button(String status, OrderDetailsController mainController) {
    switch (status) {
      case 'تایید شده و انتظار پرداخت':
        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0, right: 20, left: 20),
          child: Wrap(
              textDirection: TextDirection.rtl,
              alignment: WrapAlignment.center,
              runSpacing: 10,
              spacing: 10,
              children: mainController.order.value!.data.availableOperations
                  .map(
                    (e) => ElevatedButton(
                        onPressed: () {
                          print(e.name);
                          mainController.operation(e.name);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: e.btnType == 'simple' ? e.btnColor!.toColor() : Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: e.btnType == 'simple'
                                  ? const BorderSide(width: 0, color: Colors.transparent)
                                  : BorderSide(
                                      color: e.btnColor!.toColor(),
                                      width: 0.7,
                                    )),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            e.name,
                            style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(fontSize: 18.sp, color: e.btnType == 'simple' ? Colors.white : e.btnColor!.toColor()),
                          ),
                        )),
                  )
                  .toList()),
        );
      case 'انصراف از سفارش':
        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    mainController.operation('عدم پرداخت');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff4cae4c),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.refresh,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          'درخواست مجدد رزرو',
                          style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(fontSize: 18.sp, color: Colors.white),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        );
      case 'عدم پرداخت':
        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    mainController.operation('عدم پرداخت');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff4cae4c),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.refresh,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          'درخواست مجدد رزرو',
                          style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(fontSize: 18.sp, color: Colors.white),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        );
      case 'در انتظار تایید':
        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    mainController.operation('در انتظار تایید');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffd9534f),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'انصراف از سفارش',
                          style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(fontSize: 18.sp, color: Colors.white),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        const Icon(
                          Icons.cancel,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        );
      case 'پرداخت و قطعی شده':
        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Get.to(RulesOfCancelingScreen(),transition: Transition.downToUp);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: const BorderSide(color: Color(0xffd9534f),width: 0.6)

                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'لغو سفارش',
                          style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(fontSize: 18.sp, color: const Color(0xffd9534f).withOpacity(0.9)),
                        ),
                        const SizedBox(width: 5,),
                        const Icon(Icons.remove_shopping_cart_outlined,color: Color(0xffd9534f),size: 18,),
                      ],
                    ),
                  )),
              const SizedBox(width: 20,),
              ElevatedButton(
                  onPressed: () {
                    mainController.operation('پرداخت و قطعی شده');
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: AppColors.acceptedGuest,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'ارسال تیکت',
                          style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(fontSize: 18.sp,color: Colors.white),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        );
      default:
        return const SizedBox();
    }
  }

  iconSet(String mCode) {
    return IconDataSolid(int.parse(mCode, radix: 16));
  }

  colorStatus(String status) {
    switch (status) {
      case 'در انتظار پرداخت':
        return AppColors.pendingPay;
      case 'تایید شده و انتظار پرداخت':
        return AppColors.confAndPendingPay;
      case 'کنسل و تسویه شده':
        return AppColors.cancelAndSettled;
      case 'مهمان پذیرش شده':
        return AppColors.acceptedGuest;
      case 'سفارش رد شده':
        return AppColors.orderReject;
      case 'انصراف از سفارش':
        return AppColors.cancelOrder;
      case 'در انتظار تائید':
        return AppColors.confAwait;
      case 'در انتظار تایید':
        return AppColors.confAwait;
      case 'پرداخت و قطعی شده':
        return AppColors.mainColor;
      case 'عدم پرداخت':
        return AppColors.failToPay;
      default:
        return Colors.black;
    }
  }

  iconStatus(String status) {
    switch (status) {
      case 'در انتظار پرداخت':
        return const Icon(Icons.access_time_filled_rounded, size: 12, color: Colors.white);
      case 'تایید شده و انتظار پرداخت':
        return const Icon(Icons.access_time_filled_rounded, size: 12, color: Colors.white);
      case 'کنسل و تسویه شده':
        return const Icon(Icons.error_rounded, size: 12, color: Color(0xff596E7C));
      case 'مهمان پذیرش شده':
        return Container(decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), padding: const EdgeInsets.all(2), child: Icon(Icons.done, size: 10, color: AppColors.acceptedGuest));
      case 'سفارش رد شده':
        return const Icon(Icons.remove_circle, size: 12, color: Colors.white);
      case 'پرداخت و قطعی شده':
        return const Icon(Icons.done, size: 15, color: Colors.white);
      case 'انصراف از سفارش':
        return const Icon(Icons.logout_rounded, size: 12, color: Color(0xff230B34));
      case 'در انتظار تایید':
        return SvgPicture.asset('assets/icons/conf_await_ic.svg');
      case 'عدم پرداخت':
        return const Icon(Icons.block, size: 12, color: Colors.white);

      default:
        return const SizedBox();
    }
  }
}
