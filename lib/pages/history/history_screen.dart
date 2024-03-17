import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/app/utils/pay_price_calculator.dart';
import 'package:uspace_ir/controllers/history_controller.dart';
import 'package:uspace_ir/controllers/user_controller.dart';
import 'package:uspace_ir/models/order_model.dart';
import 'package:uspace_ir/models/room_reservation_model.dart';
import 'package:uspace_ir/widgets/facilites_dialog.dart';
import 'package:uspace_ir/widgets/textfield.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({Key? key}) : super(key: key);

  final RxBool isExpansion = false.obs;

  final UserController userController = Get.find();
  final HistoryController historyController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: historyController.formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    Get.dialog(Dialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 10),
                            const Text(
                              'لطفا کد رهگیری خود را در قسمت زیر وارد کنید.',
                              textDirection: TextDirection.rtl,
                            ),
                            const SizedBox(height: 10),
                            MyTextField(
                              label: 'کد رهگیری',
                              textInputAction: TextInputAction.done,
                              inputFormatters: [FilteringTextInputFormatter.deny(RegExp('[!@#ا-ی ئ و ]'))],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'لطفا کد رهگیری را وارد کنید.';
                                }
                                return null;
                              },
                              textEditingController: historyController.orderCodeTextEditController,
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                                onPressed: () {
                                  if (historyController.formKey.currentState!.validate()) {
                                    historyController.addOrderCode(historyController.orderCodeTextEditController.text);
                                    historyController.orderCodeTextEditController.clear();
                                    Get.back();
                                  }
                                },
                                child: Text(
                                  'افزودن کد',
                                  style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color: Colors.white),
                                )),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ));
                  },
                  child: const Text('افزودن کد رهگیری')),
              const Spacer(),
              Text('همه سفارشات من', style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(fontSize: 16)),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(() => ListView.separated(
                padding: EdgeInsets.zero,
                itemBuilder: (context, orderIndex) {
                  if (historyController.loading.value) {
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
                  if (historyController.orderHistory[orderIndex].data.rsvItems.length > 1) {
                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, roomIndex) {
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
                                  historyController.orderHistory[orderIndex].data.rsvItems[roomIndex].isExpanded.toggle();
                                },
                                child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.end, children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          orderStatus(orderIndex, roomIndex);
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
                                            child: Icon(Icons.info, color: orderStatusChecker(historyController.orderHistory[orderIndex].data.status), size: 20)),
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
                                            Text(
                                              historyController.orderHistory[orderIndex].data.rsvItems[roomIndex].title,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textDirection: TextDirection.rtl,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            RichText(
                                              textDirection: TextDirection.rtl,
                                              text: TextSpan(
                                                children: [TextSpan(text: 'قیمت پرداختی: ', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.grayColor)), TextSpan(text: '${payPriceCalculate(historyController.orderHistory[orderIndex].data.rsvItems[roomIndex].dayAndPrice).toString().seRagham()}تومان', style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color: AppColors.mainColor))],
                                              ),
                                            ),
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
                                          imageUrl: historyController.orderHistory[orderIndex].data.rsvItems[roomIndex].thumbImage,
                                          fit: BoxFit.fill,
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
                                        TextSpan(text: 'تاریخ ورود: ', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.grayColor)),
                                        TextSpan(
                                            text: historyController.orderHistory[orderIndex].data.miladiCheckIn.toPersianDateStr(
                                              showDayStr: true,
                                            ),
                                            style: Theme.of(Get.context!).textTheme.labelMedium)
                                      ])),
                                  RichText(
                                      textDirection: TextDirection.rtl,
                                      text: TextSpan(children: [
                                        TextSpan(text: 'تاریخ خروج: ', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.grayColor)),
                                        TextSpan(
                                            text: historyController.orderHistory[orderIndex].data.miladiCheckIn.add(Duration(days: historyController.orderHistory[orderIndex].data.duration)).toPersianDateStr(
                                                  showDayStr: true,
                                                ),
                                            style: Theme.of(Get.context!).textTheme.labelMedium)
                                      ])),
                                  RichText(textDirection: TextDirection.rtl, text: TextSpan(children: [TextSpan(text: 'مدت اقامت: ', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.grayColor)), TextSpan(text: historyController.orderHistory[orderIndex].data.duration.toString(), style: Theme.of(Get.context!).textTheme.labelMedium)])),
                                  RichText(textDirection: TextDirection.rtl, text: TextSpan(children: [TextSpan(text: 'تعداد اتاق: ', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.grayColor)), TextSpan(text: historyController.orderHistory[orderIndex].data.rsvItems.length.toString(), style: Theme.of(Get.context!).textTheme.labelMedium)])),
                                  RichText(textDirection: TextDirection.rtl, text: TextSpan(children: [TextSpan(text: 'تعداد مهمان: ', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.grayColor)), TextSpan(text: historyController.orderHistory[orderIndex].data.rsvItems[roomIndex].roomCapacity.toString(), style: Theme.of(Get.context!).textTheme.labelMedium)])),
                                  Obx(() => historyController.orderHistory[orderIndex].data.rsvItems[roomIndex].isExpanded.value ? onExpansion(orderIndex: orderIndex, roomIndex: roomIndex, oneDayPrice: historyController.orderHistory[orderIndex].data.rsvItems[roomIndex].dayAndPrice[0].originalPrice.toString(), title: historyController.orderHistory[orderIndex].data.rsvItems[roomIndex].title, featureElement: historyController.orderHistory[orderIndex].data.rsvItems[roomIndex].features, roomPackages: historyController.orderHistory[orderIndex].data.rsvItems[roomIndex].roomPackages) : const SizedBox()),
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
                                            color: colorStatus(historyController.orderHistory[orderIndex].data.status),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                historyController.orderHistory[orderIndex].data.status,
                                                style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.white),
                                              ),
                                              const SizedBox(width: 2),
                                              iconStatus(historyController.orderHistory[orderIndex].data.status)
                                            ],
                                          )),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Obx(() => Text(historyController.orderHistory[orderIndex].data.rsvItems[roomIndex].isExpanded.value ? 'اطلاعات کمتر' : 'اطلاعات بیشتر',
                                          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                                color: AppColors.grayColor,
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
                      itemCount: historyController.orderHistory[orderIndex].data.rsvItems.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
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
                            historyController.orderHistory[orderIndex].data.rsvItems[0].isExpanded.toggle();
                          },
                          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.end, children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    orderStatus(orderIndex, 0);
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
                                      child: Icon(Icons.info, color: orderStatusChecker(historyController.orderHistory[orderIndex].data.status), size: 20)),
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
                                      Text(
                                        historyController.orderHistory[orderIndex].data.rsvItems[0].title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textDirection: TextDirection.rtl,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      RichText(textDirection: TextDirection.rtl, text: TextSpan(children: [TextSpan(text: 'قیمت پرداختی: ', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.grayColor)), TextSpan(text: '${payPriceCalculate(historyController.orderHistory[orderIndex].data.rsvItems[0].dayAndPrice).toString().seRagham()}تومان', style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color: AppColors.mainColor))]))
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
                                    imageUrl: historyController.orderHistory[orderIndex].data.rsvItems[0].thumbImage,
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
                                      text: historyController.orderHistory[orderIndex].data.miladiCheckIn.toPersianDateStr(
                                        showDayStr: true,
                                      ),
                                      style: Theme.of(Get.context!).textTheme.labelMedium)
                                ])),
                            RichText(
                                textDirection: TextDirection.rtl,
                                text: TextSpan(children: [
                                  TextSpan(text: 'تاریخ خروج: ', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.grayColor)),
                                  TextSpan(
                                      text: historyController.orderHistory[orderIndex].data.miladiCheckIn.add(Duration(days: historyController.orderHistory[orderIndex].data.duration)).toPersianDateStr(
                                            showDayStr: true,
                                          ),
                                      style: Theme.of(Get.context!).textTheme.labelMedium)
                                ])),
                            RichText(
                              textDirection: TextDirection.rtl,
                              text: TextSpan(children:
                              [
                                TextSpan(text: 'مدت اقامت: ', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.grayColor)),
                                TextSpan(text: historyController.orderHistory[orderIndex].data.duration.toString(), style: Theme.of(Get.context!).textTheme.labelMedium)
                              ]
                              ),
                            ),
                            RichText(textDirection: TextDirection.rtl, text: TextSpan(children: [TextSpan(text: 'تعداد اتاق: ', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.grayColor)), TextSpan(text: historyController.orderHistory[orderIndex].data.rsvItems.length.toString(), style: Theme.of(Get.context!).textTheme.labelMedium)])),
                            RichText(textDirection: TextDirection.rtl, text: TextSpan(children: [TextSpan(text: 'تعداد مهمان: ', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.grayColor)), TextSpan(text: historyController.orderHistory[orderIndex].data.rsvItems[0].roomCapacity.toString(), style: Theme.of(Get.context!).textTheme.labelMedium)])),
                            Obx(() => historyController.orderHistory[orderIndex].data.rsvItems[0].isExpanded.value ? onExpansion(roomIndex: 0, orderIndex: orderIndex, roomPackages: historyController.orderHistory[orderIndex].data.rsvItems[0].roomPackages, featureElement: historyController.orderHistory[orderIndex].data.rsvItems[0].features, title: historyController.orderHistory[orderIndex].data.rsvItems[0].title, oneDayPrice: historyController.orderHistory[orderIndex].data.rsvItems[0].dayAndPrice[0].originalPrice.toString()) : const SizedBox()),
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
                                      color: colorStatus(historyController.orderHistory[orderIndex].data.status),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          historyController.orderHistory[orderIndex].data.status,
                                          style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.white),
                                        ),
                                        const SizedBox(width: 2),
                                        iconStatus(historyController.orderHistory[orderIndex].data.status),
                                      ],
                                    )),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Obx(() => Text(historyController.orderHistory[orderIndex].data.rsvItems[0].isExpanded.value ? 'اطلاعات کمتر' : 'اطلاعات بیشتر',
                                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                          color: AppColors.grayColor,
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
                itemCount: historyController.loading.value ? 3 : historyController.orderHistory.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              )),
          const SizedBox(
            height: 20,
          )
        ]),
      ),
    );
  }

  Widget onExpansion({required int roomIndex, required int orderIndex, required String oneDayPrice, required RoomPackages roomPackages, required List<RoomFeature> featureElement, required String title}) {
    print(historyController.orderHistory[orderIndex].data.status);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        RichText(textDirection: TextDirection.rtl, text: TextSpan(children: [TextSpan(text: 'قیمت یک شب: ', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.grayColor)), TextSpan(text: '${oneDayPrice.seRagham()} تومان', style: Theme.of(Get.context!).textTheme.labelMedium)])),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 0.3, color: roomPackages.features[0].value == 1 ? AppColors.mainColor : AppColors.grayColor)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${roomPackages.features[0].feature.title} ${roomPackages.features[0].value == 1 ? 'دارد' : 'ندارد'}',
                    style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: roomPackages.features[0].value == 1 ? AppColors.mainColor : Colors.grey),
                  ),
                  const SizedBox(width: 2),
                  Icon(
                    IconData(
                      int.parse(roomPackages.features[0].feature.unicode ?? 'f00c', radix: 16),
                      fontFamily: 'FontAwesomeSolid',
                      fontPackage: 'font_awesome_flutter',
                    ),
                    size: 10,
                    color: roomPackages.features[0].value == 1 ? AppColors.mainColor : Colors.grey,
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 0.3, color: roomPackages.features[1].value == 1 ? AppColors.mainColor : Colors.grey)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${roomPackages.features[1].feature.title} ${roomPackages.features[1].value == 1 ? 'دارد' : 'ندارد'}',
                    style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: roomPackages.features[1].value == 1 ? AppColors.mainColor : Colors.grey),
                  ),
                  const SizedBox(width: 2),
                  Icon(
                    IconData(
                      int.parse(roomPackages.features[1].feature.unicode ?? 'f00c', radix: 16),
                      fontFamily: 'FontAwesomeSolid',
                      fontPackage: 'font_awesome_flutter',
                    ),
                    size: 10,
                    color: roomPackages.features[1].value == 1 ? AppColors.mainColor : Colors.grey,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 0.3, color: roomPackages.features[2].value == 1 ? AppColors.mainColor : Colors.grey)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${roomPackages.features[2].feature.title} ${roomPackages.features[2].value == 1 ? 'دارد' : 'ندارد'}',
                    style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: roomPackages.features[2].value == 1 ? AppColors.mainColor : Colors.grey),
                  ),
                  const SizedBox(width: 2),
                  Icon(
                    IconData(
                      int.parse(roomPackages.features[2].feature.unicode ?? 'f00c', radix: 16),
                      fontFamily: 'FontAwesomeSolid',
                      fontPackage: 'font_awesome_flutter',
                    ),
                    size: 10,
                    color: roomPackages.features[2].value == 1 ? AppColors.mainColor : Colors.grey,
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
                Get.dialog(facilityDialog(roomFeatures: featureElement, title: title, hasBrakeFast: roomPackages.features[0].value, hasDinner: roomPackages.features[1].value, hasLunch: roomPackages.features[2].value));
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
            itemCount: historyController.orderHistory[orderIndex].data.rsvItems[roomIndex].dayAndPrice.length,
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
                          historyController.orderHistory[orderIndex].data.rsvItems[roomIndex].dayAndPrice[dayIndex].date.toPersianDateStr(
                            showDayStr: true,
                          ),
                          style: Theme.of(Get.context!).textTheme.labelSmall),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'تومان ${historyController.orderHistory[orderIndex].data.rsvItems[roomIndex].dayAndPrice[dayIndex].originalPrice.toString().seRagham()}',
                      style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color: AppColors.grayColor),
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'نفر اضافه ${historyController.orderHistory[orderIndex].data.rsvItems[roomIndex].dayAndPrice[dayIndex].additionalGustPrice.toString().seRagham()}',
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

  void orderStatus(int orderIndex, int roomIndex) {
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                          child: Text(
                        historyController.orderHistory[orderIndex].data.ecolodge.title,
                        maxLines: 2,
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
                          imageUrl: historyController.orderHistory[orderIndex].data.rsvItems[roomIndex].thumbImage,
                          fit: BoxFit.fill,
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
                        color: colorStatus(historyController.orderHistory[orderIndex].data.status),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            historyController.orderHistory[orderIndex].data.status,
                            style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.white),
                          ),
                          const SizedBox(width: 2),
                          iconStatus(historyController.orderHistory[orderIndex].data.status),
                        ],
                      )),
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
                        TextSpan(text: historyController.orderHistory[orderIndex].data.cancelInfo ?? '-', style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: const Color.fromRGBO(0, 32, 51, 0.6))),
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

  Color orderStatusChecker(String status) {
    switch (status) {
      case 'سفارش رد شده':
        return Colors.red;
      case 'عدم پرداخت':
        return Colors.black;
      default:
        return Colors.grey;
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
