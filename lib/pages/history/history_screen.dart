import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/controllers/history_controller.dart';
import 'package:uspace_ir/controllers/user_controller.dart';
import 'package:uspace_ir/pages/history/order_details_screen.dart';
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
          IconButton(onPressed: (){Get.to(OrderDetailsScreen(orderCode: '2af5a4bd4'));}, icon: Icon(Icons.add)),
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
                                    historyController.fetchOrderHistory(historyController.orderCodeTextEditController.text);
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
              Text('همه سفارشات من', style: Theme.of(Get.context!).textTheme.bodyLarge),
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
                  return InkWell(
                    borderRadius:BorderRadius.circular(24),
                    onTap: (){
                      print(historyController.orderHistory[orderIndex].trackCode);
                      navigateTo(historyController.orderHistory[orderIndex].trackCode);
                    },
                    child: Container(
                        margin: EdgeInsets.zero,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: const Color(0xffF3F3F3), boxShadow: const [
                          BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.14), blurRadius: 4, offset: Offset(0, 4)),
                        ]),
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
                                      historyController.orderHistory[orderIndex].ecolosge.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textDirection: TextDirection.rtl,
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
                                  imageUrl: historyController.orderHistory[orderIndex].ecolosge.image,
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
                                    text: historyController.orderHistory[orderIndex].miladiCheckIn.toPersianDateStr(
                                      showDayStr: true,
                                    ),
                                    style: Theme.of(Get.context!).textTheme.labelMedium)
                              ])),
                          RichText(
                              textDirection: TextDirection.rtl,
                              text: TextSpan(children: [
                                TextSpan(text: 'تاریخ خروج: ', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.grayColor)),
                                TextSpan(
                                    text: historyController.orderHistory[orderIndex].miladiCheckIn.add(Duration(days: historyController.orderHistory[orderIndex].duration)).toPersianDateStr(
                                          showDayStr: true,
                                        ),
                                    style: Theme.of(Get.context!).textTheme.labelMedium)
                              ])),
                          RichText(
                            textDirection: TextDirection.rtl,
                            text: TextSpan(children:
                            [
                              TextSpan(text: 'مدت اقامت: ', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.grayColor)),
                              TextSpan(text: historyController.orderHistory[orderIndex].duration.toString(), style: Theme.of(Get.context!).textTheme.labelMedium)
                            ]
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Stack(alignment: Alignment.center, children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(8),
                                  onTap:(){
                                    navigateTo(historyController.orderHistory[orderIndex].trackCode);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.arrow_back,size: 10,color:AppColors.mainColor,),
                                        const SizedBox(width:5),
                                        Text('نمایش بیشتر',style:Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color:AppColors.mainColor)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: colorStatus(historyController.orderHistory[orderIndex].status),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        historyController.orderHistory[orderIndex].status,
                                        style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.white),
                                      ),
                                      const SizedBox(width: 2),
                                      iconStatus(historyController.orderHistory[orderIndex].status),
                                    ],
                                  )),
                            ),
                          ])
                        ])),
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
        case 'پرداخت و قطعی شده':
        return AppColors.mainColor;
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
      case 'پرداخت و قطعی شده':
        return const Icon(Icons.done, size: 15, color: Colors.white);
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

  void navigateTo(String orderCode) {
    Get.to(OrderDetailsScreen(orderCode: orderCode,));
  }
}
