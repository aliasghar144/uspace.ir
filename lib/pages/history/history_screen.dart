import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/controllers/user_controller.dart';
import 'package:uspace_ir/widgets/facilites_dialog.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({Key? key}) : super(key: key);

  final RxBool isExpansion = false.obs;

  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(onPressed: () {}, child: const Text('افزودن کد رهگیری')),
            const Spacer(),
            Text('همه سفارشات من', style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(fontSize: 16)),
          ],
        ),
        const SizedBox(height: 10,),
        ListView.separated(
          padding: EdgeInsets.zero,

          itemBuilder: (context, index) {
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
                      isExpansion.toggle();
                    },
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              orderStatus();
                            },
                            child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white, boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                  )
                                ]),
                                child: const Icon(Icons.info, color: Colors.red, size: 20)),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Flexible(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  'اتاق سه تخته پریخان خانم هتل سنتی شیران _اصفهان',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textDirection: TextDirection.rtl,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                RichText(textDirection: TextDirection.rtl, text: TextSpan(children: [TextSpan(text: 'قیمت پرداختی: ', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.grayColor)), TextSpan(text: '${'4500000'.seRagham()}تومان', style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color: AppColors.mainColor))]))
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
                              imageUrl: 'https://shiranhotel.uspace.ir/spaces/shiranhotel/images/main/shiranhotel_uspace_1638686061.jpg',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(textDirection: TextDirection.rtl, text: TextSpan(children: [TextSpan(text: 'تاریخ ورود:', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.grayColor)), TextSpan(text: 'چهارشنبه 27 تیر 1402', style: Theme.of(Get.context!).textTheme.labelMedium)])),
                      RichText(textDirection: TextDirection.rtl, text: TextSpan(children: [TextSpan(text: 'تاریخ خروج: ', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.grayColor)), TextSpan(text: 'جمعه 28 تیر 1402', style: Theme.of(Get.context!).textTheme.labelMedium)])),
                      RichText(textDirection: TextDirection.rtl, text: TextSpan(children: [TextSpan(text: 'مدت اقامت: ', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.grayColor)), TextSpan(text: '2 شب', style: Theme.of(Get.context!).textTheme.labelMedium)])),
                      RichText(textDirection: TextDirection.rtl, text: TextSpan(children: [TextSpan(text: 'تعداد اتاق: ', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.grayColor)), TextSpan(text: '1', style: Theme.of(Get.context!).textTheme.labelMedium)])),
                      RichText(textDirection: TextDirection.rtl, text: TextSpan(children: [TextSpan(text: 'تعداد مهمان: ', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.grayColor)), TextSpan(text: '2', style: Theme.of(Get.context!).textTheme.labelMedium)])),
                      Obx(() => isExpansion.value ? onExpansion() : const SizedBox()),
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
                                color: AppColors.confAwait,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'در انتظار تائید',
                                    style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.white),
                                  ),
                                  const SizedBox(width: 2),
                                  SvgPicture.asset('assets/icons/conf_await_ic.svg'),
                                ],
                              )),
                        ),
                        Obx(() => Text(isExpansion.value ? 'اطلاعات بیشتر' : 'اطلاعات کمتر',
                            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                  color: AppColors.grayColor,
                                ))),
                      ])
                    ]),
                  )),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 15);
          },
          itemCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
        )
      ]),
    );
  }

  Widget onExpansion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        RichText(textDirection: TextDirection.rtl, text: TextSpan(children: [TextSpan(text: 'قیمت یک شب: ', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.grayColor)), TextSpan(text: '${'2000000'.seRagham()} تومان', style: Theme.of(Get.context!).textTheme.labelMedium)])),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 0.3, color: AppColors.mainColor)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'شام دارد',
                    style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.mainColor),
                  ),
                  const SizedBox(width: 2),
                  SvgPicture.asset('assets/icons/dinner_ic.svg'),
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 0.3, color: AppColors.mainColor)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'نهار دارد',
                    style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.mainColor),
                  ),
                  const SizedBox(width: 2),
                  SvgPicture.asset('assets/icons/lunch_ic.svg'),
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 0.3, color: AppColors.mainColor)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'صبحانه دارد',
                    style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.mainColor),
                  ),
                  const SizedBox(width: 2),
                  SvgPicture.asset('assets/icons/breakfast_ic.svg'),
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
            const Spacer(
              flex: 1,
            ),
            Text(
              'جزئیات قیمت',
              style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color: AppColors.grayColor),
            ),
            const SizedBox(
              width: 2,
            ),
            const Icon(Icons.info, color: AppColors.grayColor, size: 20),
            const Spacer(flex: 2),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.mainColor.withOpacity(0.8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  InkWell(
                    onTap: () {
                      // Get.dialog(facilityDialog(
                      //     feature:reservationController.room.value!.data.rooms[roomsIndex].features,
                      //     title: reservationController.room.value!.data.rooms[roomsIndex].title,
                      //     hasBrakeFast: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[0].value,
                      //     hasDinner: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[1].value,
                      //     hasLunch: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[2].value
                      // ));
                    },
                    child: Text('امکانات',
                        style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(
                              color: Colors.white,
                            )),
                  ),
                  const SizedBox(width: 4),
                  SvgPicture.asset('assets/icons/facilities_ic.svg'),
                ])),
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
            itemCount: 5,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) {
              return const SizedBox(width: 10);
            },
            itemBuilder: (context, index) {
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
                      child: Text('چهارشنبه 27 تیر', style: Theme.of(Get.context!).textTheme.labelSmall),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'تومان ${'12000000'.seRagham()}',
                      style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color: AppColors.grayColor),
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'نفر اضافه ${'112000'.seRagham()}',
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

  void orderStatus() {
    Get.dialog(Dialog(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Text(
                    'وضعیت سفارش شما',
                    style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(color: AppColors.grayColor),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: InkWell(
                      onTap: () {
                        Get.close(1);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.grayColor, width: 1)),
                        child: const Icon(Icons.close, color: AppColors.grayColor, size: 10),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 0.3,
              color: Colors.black,
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                          child: Text(
                        'اتاق سه تخته پریخان خانم هتل شیران _ اصفهان',
                        maxLines: 1,
                        style: Theme.of(Get.context!).textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                      )),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        width: Get.width / 7,
                        height: Get.width / 7,
                        child: CachedNetworkImage(
                          imageUrl: "https://shiranhotel.uspace.ir/spaces/shiranhotel/images/main/shiranhotel_uspace_1638686061.jpg",
                          fit: BoxFit.fill,
                          errorWidget: (context, url, error) => const Icon(Icons.broken_image_outlined),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.confAwait,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'در انتظار تائید',
                            style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.white),
                          ),
                          const SizedBox(width: 2),
                          SvgPicture.asset('assets/icons/conf_await_ic.svg'),
                        ],
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'کاربر گرامی، متاسفانه سفارش شما رد شده است.',
                    style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color: AppColors.redColor),
                    textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xffECF1F4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: RichText(
                      textDirection: TextDirection.rtl,
                      text: TextSpan(children: [
                        TextSpan(text: 'علت رد سفارش شما توسط ارائه دهنده خدمت مورد نظر: \n ', style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: const Color.fromRGBO(0, 32, 51, 0.6))),
                        TextSpan(text: 'رزرو جهت تست بوده.', style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: const Color.fromRGBO(0, 32, 51, 0.6))),
                      ]),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
