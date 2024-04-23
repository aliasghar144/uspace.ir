import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/controllers/order_details_controller.dart';

class FeedBackScreen extends StatelessWidget {
  FeedBackScreen({Key? key}) : super(key: key);

  final OrderDetailsController mainController = Get.find<OrderDetailsController>();


  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(microseconds: 1),() =>     scrollCtr.animateTo(scrollCtr.position.maxScrollExtent, duration: Duration(milliseconds: 1), curve: Curves.linear).then((value) =>
    //     scrollCtr.animateTo(scrollCtr.position.minScrollExtent, duration: Duration(milliseconds: 500), curve: Curves.easeIn))
    //   );
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
              const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'فرم نظرسنجی',
                  style: Theme
                      .of(Get.context!)
                      .textTheme
                      .displayLarge!
                      .copyWith(
                    fontSize: 20.sp,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(width: Get.width * 0.15, child: Image.asset('assets/images/feedback.png')),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'با ثبت نظر خود، دیگران را در انتخاب بهتر و ما را در ارائه اطلاعات دقیق تر همراهی نمایید.',
              style: Theme
                  .of(Get.context!)
                  .textTheme
                  .bodyLarge,
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              margin: EdgeInsets.zero,
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
                      mainController.feedbackRulesShow.value = value;
                    },
                    initiallyExpanded: false,
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    expandedAlignment: Alignment.topRight,
                    childrenPadding: const EdgeInsets.symmetric(horizontal: 15),
                    shape: Border.all(color: Colors.transparent),
                    title: Row(
                      children: [
                        const Icon(
                          Icons.info,
                          size: 20,
                          color: Colors.black54,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'قوانین ثبت نظرسنجی',
                          style: Theme
                              .of(Get.context!)
                              .textTheme
                              .bodyLarge,
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
                        'هدف از ثبت نظر شما درباره اقامتگاه ارائه اطلاعات مفید و مشخص برای راهنمایی سایر مهمانان و کاربران در فرآیند انتخاب یک اقامتگاه می باشد.',
                        style: Theme
                            .of(Get.context!)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: const Color(0xff515151)),
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'از ارایه‌ی اطلاعات شخصی خودتان مثل شماره تماس، ایمیل و آی‌دی شبکه‌های اجتماعی پرهیز کنید.',
                        style: Theme
                            .of(Get.context!)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: const Color(0xff515151)),
                        textDirection: TextDirection.rtl,
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
              height: 25,
            ),
            rateBar(title: 'تمیزی اتاق ها و وسایل', option: mainController.option1),
            rateBar(title: 'کیفیت و تنوع غذاها در اقامتگاه (فقط در صورت استفاده)', option: mainController.option2),
            rateBar(title: 'برخورد پرسنل و پذیرش', option: mainController.option3),
            rateBar(title: 'میزان رضایت از سایت رزرو', option: mainController.option4),
            rateBar(title: 'امتیاز کلی (ارزش خرید نسبت به کیفیت و هزینه)', option: mainController.option5),
            TextFormField(
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              textAlignVertical: TextAlignVertical.top,
              maxLines: 6,
              style: Theme
                  .of(Get.context!)
                  .textTheme
                  .bodyLarge,
              controller: mainController.feedbackTxtEditCtr,
              onTap: () {
                if (mainController.feedbackTxtEditCtr.selection == TextSelection.fromPosition(TextPosition(offset: mainController.feedbackTxtEditCtr.text.length - 1))) {
                  mainController.feedbackTxtEditCtr.selection = TextSelection.fromPosition(TextPosition(offset: mainController.feedbackTxtEditCtr.text.length));
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'لطفا نظر خود را بنویسید';
                }
                return null;
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(width: 0.3, color: AppColors.grayColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      width: 0.3,
                    )),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      width: 0.3,
                    )),
                hintText: 'نظری دارید؟ درصورت تمایل نظر شما در قسمت نظرات اقامتگاه نمایش داده خواهد شد.',
                hintTextDirection: TextDirection.rtl,
                hintStyle: Theme
                    .of(Get.context!)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: AppColors.grayColor.withOpacity(0.5)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.end, children: [
              Text(
                'نمایش به صورت ناشناس',
                style: Theme
                    .of(Get.context!)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontSize: 15.sp, color: Colors.black),
              ),
              const SizedBox(width: 5),
              InkWell(
                onTap: () {
                  mainController.anonymousUser.toggle();
                },
                borderRadius: BorderRadius.circular(100),
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Obx(() =>
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          border: mainController.anonymousUser.value ? null : Border.all(),
                          borderRadius: BorderRadius.circular(3),
                          color: mainController.anonymousUser.value ? AppColors.mainColor : Colors.transparent,
                          // boxShadow: [mainController.sendAzUnKnowPer.value ? BoxShadow(color: AppColors.mainColor.withOpacity(0.1), spreadRadius: 4, blurRadius: 0.1) : BoxShadow(color: AppColors.mainColor.withOpacity(0.1), spreadRadius: 6, blurRadius: 0.1)]
                        ),
                        child: mainController.anonymousUser.value
                            ? const Icon(
                          Icons.done_outlined,
                          size: 12,
                          color: Colors.white,
                        )
                            : null,
                      )),
                ),
              ),
            ]),
            const SizedBox(
              height: 20,
            ),
            Align(
                alignment: Alignment.topRight,
                child: Text(
                  'ارسال عکس ها و فیلم ها',
                  style: Theme
                      .of(Get.context!)
                      .textTheme
                      .bodyLarge,
                  textAlign: TextAlign.right,
                )),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Text(
                      'برای بارگزاری تصاویر حداکثر 15 عکس و حجم 20 مگابایت و برای فیلم حداکثر 4 ویدیو و حجم 100 مگابایت',
                      style: Theme
                          .of(Get.context!)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: AppColors.grayColor),
                      textAlign: TextAlign.right,
                    )),
                const SizedBox(
                  width: 5,
                ),
                const Icon(Icons.info_outline_rounded, size: 15, color: AppColors.grayColor),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Obx(
                  () =>
              mainController.selectedImages.isEmpty
                  ? InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () async {
                  final pickedFile = await mainController.picker.pickMultiImage(imageQuality: 50);
                  List<XFile> xFilePick = pickedFile;
                  if (xFilePick.isNotEmpty) {
                    for (var i = 0; i < xFilePick.length; i++) {
                      mainController.selectedImages.add(File(xFilePick[i].path));
                    }
                  }
                },
                child: Container(width: Get.width / 4.5, height: Get.width / 4.5, decoration: BoxDecoration(color: const Color(0xffF6FAFF), border: Border.all(color: const Color(0xffE8EEF3))), child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [SvgPicture.asset('assets/icons/upload_ic.svg'), const SizedBox(height: 5), Text('بارگذاری', style: Theme
                    .of(Get.context!)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: AppColors.grayColor))
                ])),
              )
                  : Row(mainAxisAlignment: MainAxisAlignment.end, mainAxisSize: MainAxisSize.max, children: [
                Flexible(
                    child: Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      alignment: WrapAlignment.end,
                      children: mainController.selectedImages
                          .map((e) =>
                          Stack(
                            alignment: Alignment.center,
                            fit: StackFit.loose,
                            children: [
                              Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                                width: Get.width / 5,
                                height: Get.width / 4,
                                child: Image.file(
                                  e,
                                  fit: BoxFit.cover,
                                  frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                                    if (wasSynchronouslyLoaded) return child;
                                    return AnimatedOpacity(
                                      opacity: frame == null ? 0 : 1,
                                      duration: const Duration(seconds: 2),
                                      curve: Curves.easeOut,
                                      child: child,
                                    );
                                  },
                                ),
                              ),
                              IconButton(
                                  icon: const Icon(Icons.close, color: Colors.white),
                                  onPressed: () {
                                    mainController.selectedImages.removeWhere(
                                          (element) => element.path == e.path,
                                    );
                                  }),
                            ],
                          ))
                          .toList(),
                    )),
                const SizedBox(width: 20),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: InkWell(
                    onTap: () async {
                      final pickedFile = await mainController.picker.pickMultiImage(imageQuality: 50);
                      List<XFile> xFilePick = pickedFile;
                      if (xFilePick.isNotEmpty) {
                        for (var i = 0; i < xFilePick.length; i++) {
                          mainController.selectedImages.add(File(xFilePick[i].path));
                        }
                      }
                    },
                    child: Column(children: [Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: const Color(0xffF6FAFF), border: Border.all(color: const Color(0xffE8EEF3))), child: SvgPicture.asset('assets/icons/upload_ic.svg')), const SizedBox(height: 8), Text('بارگذاری', style: Theme
                        .of(Get.context!)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: AppColors.grayColor))
                    ]),
                  ),
                ),
              ]),
            ),
            const SizedBox(
              height: 30,
            ),
            Obx(() => mainController.feedbackLoading.value && mainController.selectedImages.isNotEmpty ? progressBar() : const SizedBox()),
            const SizedBox(
              height: 20,
            ),
            Obx(() =>
            mainController.feedbackLoading.value ? const Align(
                alignment: Alignment.bottomCenter,
                child: CircularProgressIndicator()) :
                Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: mainController.feedbackLoading.value
                        ? null
                        : () {
                      mainController.sendFeedBack();
                    },
                    child: Container(
                        width: Get.width / 2,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child:
                        Text(
                          'ارسال نظر',
                          style: Theme
                              .of(Get.context!)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.white, fontSize: 20.sp),
                        )),
                  ),
                ),
            ),
        const SizedBox(
          height: 25,
        )
        ],
      ),
    ),)
    );
  }

  progressBar() {
    return Column(
      children: [
        Stack(
          textDirection: TextDirection.ltr,
          children: [
            Container(
                width: Get.width,
                height: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23),
                  color: AppColors.mainColor.withOpacity(0.2),
                )),
            Obx(() =>
                Container(
                  width: mainController.received.value < 0 && mainController.alltotal.value < 0 ? 1 : mainController.received.value * Get.width / mainController.alltotal.value,
                  height: 10,
                  alignment: Alignment.centerRight,
                  constraints: const BoxConstraints(minHeight: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(23),
                    color: AppColors.mainColor,
                  ),
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('درحال بارگذاری', style: Theme
                .of(Get.context!)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 14, color: Colors.black)),
            Obx(() =>
                Text(
                  '${((mainController.received.value / mainController.alltotal.value) * 100).toInt()} %',
                  style: Theme
                      .of(Get.context!)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black),
                  textDirection: TextDirection.ltr,
                )),
          ],
        )
      ],
    );
  }

  rateBar({
    required String title,
    required RxInt option,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: Theme
              .of(Get.context!)
              .textTheme
              .bodyLarge,
          maxLines: 2,
        ),
        const SizedBox(
          height: 10,
        ),
        Wrap(
          textDirection: TextDirection.rtl,
          direction: Axis.horizontal,
          runSpacing: 5,
          spacing: 3,
          crossAxisAlignment: WrapCrossAlignment.start,
          alignment: WrapAlignment.start,
          verticalDirection: VerticalDirection.down,
          runAlignment: WrapAlignment.end,
          children: mainController.feedbackPoint
              .map((e) =>
              InkWell(
                radius: 10,
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  option.value = e;
                },
                child: Obx(() =>
                    Container(
                      alignment: Alignment.center,

                      decoration: BoxDecoration(
                        color: e > option.value ? Colors.grey : AppColors.mainColor,
                        shape: BoxShape.circle,
                      ),
                      // alignment: Alignment.center,
                      constraints: const BoxConstraints(minWidth: 30),
                      width: 30,
                      padding: const EdgeInsets.all(3),
                      child: Text(
                        e.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    )),
              ))
              .toList(),
        ),
        const SizedBox(
          height: 5,
        ),
        const Divider(
          thickness: 1,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
