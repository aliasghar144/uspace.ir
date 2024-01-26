import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/controllers/reservation_controller.dart';
import 'package:uspace_ir/controllers/room_reservation_controller.dart';
import 'package:uspace_ir/pages/reservation/register_reservation_screen.dart';
import 'package:uspace_ir/widgets/facilites_dialog.dart';
import 'package:uspace_ir/widgets/single_image_view.dart';
import 'package:uspace_ir/controllers/dropdown_controller.dart';

class RoomReservationScreen extends StatelessWidget {
  RoomReservationScreen({Key? key}) : super(key: key);

  final DropDownController dropDownController = Get.put(DropDownController());

  final ReservationController reservationController = Get.find();

  final RoomReservationController roomReservationController = Get.put(RoomReservationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          child: _buildBody(),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom:15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: (){
                Get.to(RegisterReservationScreen());
              },
              child: Container(
                height: 55,
                width: Get.width / 1.5,
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(50),
                  color: AppColors.mainColor,
                ),
                child: Center(child: Text('ثبت رزرو',style: Theme.of(Get.context!).textTheme.displayMedium!.copyWith(fontSize:18,color:Colors.white),)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(height: 15),
        mainSection(),
      ],
    );
  }

  mainSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Hero(
        tag: 'Room${Get.arguments}',
        child: Material(
          child: CachedNetworkImage(
            imageUrl: "https://www.uspace.ir/public/img/ecolodge/categories/trade-hotel2.jpg",
            fit: BoxFit.cover,
            imageBuilder: (context, imageProvider) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
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
                height: Get.width / 2,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () {
                          Get.to(SingleImageView(), arguments: 'https://www.uspace.ir/public/img/ecolodge/categories/trade-hotel2.jpg');
                        },
                        icon: const Icon(Icons.fullscreen, color: Colors.white),
                      ),
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
                        'هتل سنتی پریخان خانم هتل سنتی شیران _ اصفهان',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              );
            },
            errorWidget: (context, url, error) => const Icon(Icons.broken_image_outlined),
          ),
        ),
      ),
      const SizedBox(height: 15),
      SizedBox(
          width: Get.width,
          height: 50,
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
                        Obx(
                          () => reservationController.isDateSelected.value
                              ? Row(
                                  children: [
                                    Text('${reservationController.entryDate.value.toJalali().year}/${reservationController.entryDate.value.toJalali().month}/${reservationController.entryDate.value.toJalali().day}  ', style: Theme.of(Get.context!).textTheme.labelMedium),
                                    Text('تاریخ ورود:', style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: AppColors.mainColor), textDirection: TextDirection.rtl),
                                  ],
                                )
                              : Text('تاریخ ورود:', style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: AppColors.mainColor), textDirection: TextDirection.rtl),
                        ),
                      ]),
                    )),
              ),
            ],
          )),
      const SizedBox(height: 15),
      Container(height: 0.5, color: Colors.grey),
      const SizedBox(height: 15),
      facilities(),
    ]);
  }

  facilities() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: AppColors.mainColor.withOpacity(0.8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              InkWell(
                onTap:(){
                  Get.dialog(facilityDialog(title: 'هتل سه تخته پریخان خانم هتل سنتی شیران_اصفهان',hasBrakeFast: 0, hasDinner: 0, hasLunch: 0));
                },
                child: Text('امکانات',
                    style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(
                          color: Colors.white,
                        )),
              ),
              const SizedBox(width: 4),
              SvgPicture.asset('assets/icons/facilities_ic.svg'),
            ])),
        const SizedBox(
          height: 10,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(width: 0.1),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('صبحانه دارد', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.mainColor)),
              const SizedBox(width: 2),
              SvgPicture.asset('assets/icons/lunch_ic.svg'),
            ]),
          ),
          const SizedBox(width: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(width: 0.1),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('صبحانه دارد', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.mainColor)),
              const SizedBox(width: 2),
              SvgPicture.asset('assets/icons/dinner_ic.svg'),
            ]),
          ),
          const SizedBox(width: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(width: 0.1),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('صبحانه دارد', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.mainColor)),
              const SizedBox(width: 2),
              SvgPicture.asset('assets/icons/breakfast_ic.svg'),
            ]),
          ),
        ]),
        const SizedBox(
          height: 10,
        ),
        RichText(
          text: TextSpan(children: [
            TextSpan(text: 'توضیحات: ', style: Theme.of(Get.context!).textTheme.bodyMedium),
            TextSpan(text: 'دارای تشک مسافرتی برای 3 نفر'.toPersianDigit(), style: Theme.of(Get.context!).textTheme.titleLarge),
          ]),
        ),
        const SizedBox(
          height: 5,
        ),
        RichText(
          text: TextSpan(children: [
            TextSpan(text: 'پرداختی برای: ', style: Theme.of(Get.context!).textTheme.bodyMedium),
            TextSpan(text: '2 نفر'.toPersianDigit(), style: Theme.of(Get.context!).textTheme.titleLarge),
          ]),
        ),
        const SizedBox(
          height: 5,
        ),
        RichText(
          text: TextSpan(children: [
            TextSpan(text: 'ظرفیت اضافه:', style: Theme.of(Get.context!).textTheme.bodyMedium),
            TextSpan(text: '3 نفر'.toPersianDigit(), style: Theme.of(Get.context!).textTheme.titleLarge),
          ]),
        ),
        const SizedBox(
          height: 5,
        ),
        RichText(
          text: TextSpan(children: [
            TextSpan(text: 'قیمت یک شب: ', style: Theme.of(Get.context!).textTheme.bodyMedium),
            TextSpan(text: '2000000'.toPersianDigit().seRagham(), style: Theme.of(Get.context!).textTheme.titleLarge),
            TextSpan(text: ' تومان', style: Theme.of(Get.context!).textTheme.titleLarge),
          ]),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() => Directionality(
                  textDirection: TextDirection.rtl,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: AppColors.mainColor),
                      items: roomReservationController.numberOfRoomItems.map((selectedType) {
                        return DropdownMenuItem(
                          value: selectedType,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RichText(
                                  textDirection: TextDirection.rtl,
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: 'تعداد سوئیت: ',
                                      style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: AppColors.mainColor),
                                    ),
                                    TextSpan(
                                      text: selectedType,
                                      style: Theme.of(Get.context!).textTheme.labelMedium,
                                    )
                                  ])),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        roomReservationController.numberOfRoom.value = value!;
                      },
                      value: roomReservationController.numberOfRoom.value,
                      buttonStyleData: ButtonStyleData(
                        height: 35,
                        width: Get.width / 2.8,
                        padding: const EdgeInsets.only(right: 10, left: 8, top: 0, bottom: 2),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), color: Colors.transparent, border: Border.all(color: AppColors.grayColor, width: 0.3)),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 20,
                        ),
                        iconEnabledColor: AppColors.mainColor,
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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey.withOpacity(0.12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: RichText(
                textDirection: TextDirection.rtl,
                text: TextSpan(children: [
                  TextSpan(text: '20000000'.beToman().seRagham(), style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(color: AppColors.mainColor)),
                  TextSpan(text: ' تومان ', style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(color: AppColors.mainColor)),
                  TextSpan(text: 'برای', style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.grey)),
                  TextSpan(text: ' 2 ', style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color: Colors.grey)),
                  TextSpan(text: 'شب', style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.grey)),
                ]),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          height: Get.width / 4.15,
          width: Get.width,
          decoration: BoxDecoration(
            color: const Color(0xffE8E8E8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListView.separated(
            itemCount: 5,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
        ),
      ]),
    );
  }

}
