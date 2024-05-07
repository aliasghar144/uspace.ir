import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/controllers/reservation_controller.dart';
import 'package:uspace_ir/controllers/room_reservation_controller.dart';
import 'package:uspace_ir/models/room_reservation_model.dart';
import 'package:uspace_ir/pages/reservation/register_reservation_screen.dart';
import 'package:uspace_ir/widgets/facilites_dialog.dart';
import 'package:uspace_ir/widgets/image_view.dart';

class RoomReservationScreen extends StatelessWidget {
  final int roomsIndex;

  RoomReservationScreen({
    required this.roomsIndex,
    Key? key}) : super(key: key);

  final ReservationController reservationController = Get.find();

  final RefreshController refreshController =
  RefreshController(initialRefresh: false,);


  @override
  Widget build(BuildContext context) {
    // int roomsIndex = Get.arguments['roomsIndex'];
    RoomReservationController roomReservationController = Get.put(RoomReservationController());
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
          child: _buildBody(roomsIndex,roomReservationController),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () {
                if(!reservationController.loadingRoom.value){
                  List<Room> rooms = [];
                  // this use when user select more than one room
                  for(int i = 0; i < roomReservationController.dropdownValue.value;i++){
                    rooms.add(reservationController.room.value!.data.rooms[roomsIndex]);
                  }
                  Get.to(RegisterReservationScreen(roomUrl: reservationController.room.value!.data.url, duration: reservationController.durationValue.value,reserveDate: reservationController.entryDate,room: rooms,));
                }
              },
              child: Container(
                height: 55,
                width: Get.width / 1.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: AppColors.mainColor,
                ),
                child: Center(
                    child: Text(
                  'ثبت رزرو',
                  style: Theme.of(Get.context!).textTheme.displayMedium!.copyWith(fontSize: 18, color: Colors.white),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildBody(int roomsIndex,RoomReservationController roomReservationController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(height: 15),
        mainSection(roomsIndex,roomReservationController),
      ],
    );
  }

  mainSection(int roomsIndex,RoomReservationController roomReservationController) {
    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Hero(
        tag: roomsIndex,
        child: Material(
          child: CachedNetworkImage(
            imageUrl: reservationController.room.value!.data.rooms[roomsIndex].thumbImage,
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
                          Get.to(ImageView(
                            index: 0,
                            url: reservationController.room.value!.data.url,
                            image:reservationController.room.value!.data.rooms[roomsIndex].thumbImage
                          ),);
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
                        reservationController.room.value!.data.rooms[roomsIndex].title,
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
            errorWidget: (context, url, error) => Container(
            clipBehavior: Clip.none,
              width: MediaQuery.of(context).size.width,
              height: Get.width / 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset('assets/images/image_not_available.png',fit: BoxFit.scaleDown,),
          ),
          ),
        ),
      ),
      const SizedBox(height: 15),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Obx(() => Directionality(
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
                    if(!reservationController.loadingRoom.value){
                      reservationController.setSelectedDuration(value!);
                      reservationController.choseEntryDate();
                    }
                  },
                  value: reservationController.durationValue.value == 0 ? null : reservationController.durationValue.value,
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
      ),
      const SizedBox(height: 15),
      Container(height: 0.5, color: Colors.grey),
      const SizedBox(height: 15),
      facilities(roomsIndex,roomReservationController),
    ]);
  }

  facilities(int roomsIndex,RoomReservationController roomReservationController) {
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
                onTap: () {
                  Get.dialog(facilityDialog(roomFeatures: reservationController.room.value!.data.rooms[roomsIndex].features, title: reservationController.room.value!.data.rooms[roomsIndex].title, hasBrakeFast: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[0].value, hasDinner: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[1].value, hasLunch: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[2].value));
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
          const SizedBox(width: 5),
          Container(
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
        const SizedBox(
          height: 10,
        ),
        reservationController.room.value!.data.rooms[roomsIndex].details == null ? const SizedBox() :
        RichText(
          textDirection: TextDirection.rtl,
          text: TextSpan(children: [
            TextSpan(text: 'توضیحات: ', style: Theme.of(Get.context!).textTheme.bodyMedium),
            TextSpan(text: reservationController.room.value!.data.rooms[roomsIndex].details, style: Theme.of(Get.context!).textTheme.titleLarge!.copyWith(),),
          ]),
        ),
        const SizedBox(
          height: 5,
        ),
        RichText(
          text: TextSpan(children: [
            TextSpan(text: 'پرداختی برای: ', style: Theme.of(Get.context!).textTheme.bodyMedium),
            TextSpan(text: '${reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.paidNumber} نفر'.toPersianDigit(), style: Theme.of(Get.context!).textTheme.titleLarge),
          ]),
        ),
        const SizedBox(
          height: 5,
        ),
        RichText(
          text: TextSpan(children: [
            TextSpan(text: 'ظرفیت اضافه:', style: Theme.of(Get.context!).textTheme.bodyMedium),
            TextSpan(text: '${reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.additionalNumber} نفر'.toPersianDigit(), style: Theme.of(Get.context!).textTheme.titleLarge),
          ]),
        ),
        const SizedBox(
          height: 5,
        ),
        Obx(() => reservationController.durationValue.value != 1 && reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.totalCustomerDiscount == 0?
            Obx(() => reservationController.loadingRoom.value || reservationController.loading.value ? const SizedBox(): RichText(
              textDirection: TextDirection.rtl,
              text: TextSpan(children: [
                TextSpan(text: 'قیمت یک شب: ', style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.grey)),
                TextSpan(text: oneNightPrice(reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.days).toString().seRagham(), style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.black.withOpacity(0.7))),
                TextSpan(text: ' تومان', style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.black.withOpacity(0.7))),
              ]),
            )):const SizedBox(),),
        const SizedBox(height: 5),
        Obx(() => reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.totalCustomerDiscount != 0
            ? RichText(
          textDirection: TextDirection.rtl,
          text: TextSpan(children: [
            TextSpan(text: 'قیمت یک شب: ', style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.grey)),
            TextSpan(text: oneNightPrice(reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.days), style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.black.withOpacity(0.7))),
            TextSpan(text: ' تومان', style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.black.withOpacity(0.7))),
          ]),
        )
            : const SizedBox(),),
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
                      items: roomReservationController.dropDownItems(loop: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.totalAvailable, unit: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.unit),
                      onChanged: (unit) {
                        roomReservationController.dropdownValue.value = unit!;
                      },
                      value: roomReservationController.dropdownValue.value,
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
              child: Obx(() => reservationController.loadingRoom.value || reservationController.loading.value ? RichText(
                textDirection: TextDirection.rtl,
                text: TextSpan(children: [
                  TextSpan(text: '- - - -', style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(color: AppColors.mainColor)),
                  TextSpan(text: ' تومان ', style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(color: AppColors.mainColor)),
                  TextSpan(text: 'برای ', style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.grey)),
                  TextSpan(text: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.durationDay.toString(), style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color: Colors.grey)),
                  TextSpan(text: ' شب', style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.grey)),
                ]),
              ) : RichText(
                textDirection: TextDirection.rtl,
                text: TextSpan(children: [
                  TextSpan(text: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.totalCustomerPrice.toString().seRagham(), style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(color: AppColors.mainColor)),
                  TextSpan(text: ' تومان ', style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(color: AppColors.mainColor)),
                  TextSpan(text: 'برای ', style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.grey)),
                  TextSpan(text: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.durationDay.toString(), style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color: Colors.grey)),
                  TextSpan(text: ' شب', style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.grey)),
                ]),
              )),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Obx(() => reservationController.loading.value || reservationController.loadingRoom.value
            ? Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,

    child: Container(alignment: Alignment.topRight,
          height: Get.width / 4.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xffE8E8E8).withOpacity(0.5),
          ),),
            )
            : Container(
                alignment: Alignment.topRight,
                height: Get.width / 4.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xffE8E8E8).withOpacity(0.5),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(width: 0.4, color: AppColors.mainColor)),
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
                                maxLines: 1,
                                textDirection: TextDirection.rtl,
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
              )),
        const SizedBox(
          height: 50,
        ),

      ]),
    );
  }

  String oneNightPrice(List<Day> days) {
    for (Day day in days){
      if(day.originalPrice > 0){
        return day.originalPrice.toString().seRagham();
      }
    }
    return '0';
  }


}
