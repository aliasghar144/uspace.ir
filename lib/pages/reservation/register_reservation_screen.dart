import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/controllers/register_reservation_controller.dart';
import 'package:uspace_ir/controllers/reservation_controller.dart';
import 'package:uspace_ir/controllers/user_controller.dart';
import 'package:uspace_ir/models/room_reservation_model.dart';
import 'package:uspace_ir/pages/reservation/more_room_selection_screen.dart';
import 'package:uspace_ir/widgets/facilites_dialog.dart';
import 'package:uspace_ir/widgets/textfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterReservationScreen extends StatelessWidget {
  final String roomUrl;
  final int duration;
  final Rx<DateTime> reserveDate;
  final List<Room> room;
  RegisterReservationScreen({
    required this.roomUrl,
    required this.duration,
    required this.reserveDate,
    required this.room,
    Key? key}) : super(key: key);

  final ReservationController reservationController = Get.find();
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    final RegisterReservationController mainController = Get.put(RegisterReservationController(duration: duration,roomUrl: roomUrl,reserveDate: reserveDate,room: room));
    return GestureDetector(
      onTap: () {
        return FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Form(
        key: mainController.formKey,
        child: Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: 15, top: 15.0),
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
                  padding: const EdgeInsets.only(right: 15, top: 15.0),
                  child: IconButton(
                    splashRadius: 20,
                    icon: SvgPicture.asset('assets/icons/bell_ic.svg'),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            body: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Get.to(MoreRoomSelectionScreen());
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'انتخاب اتاق های بیشتر',
                                  style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(
                                        fontSize: 14.sp,
                                        color: AppColors.mainColor,
                                      ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                SvgPicture.asset(
                                  'assets/icons/rooms_big_ic.svg',
                                  width: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                        width: Get.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Spacer(),
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              padding: const EdgeInsets.only(right: 15, top: 5, bottom: 5, left: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    width: 0.3,
                                    color: AppColors.grayColor,
                                  )),
                              child: Row(
                                children: [
                                  const Icon(Icons.arrow_drop_down, size: 20, color: AppColors.grayColor),
                                  const SizedBox(width: 20),
                                  Text(
                                    '${reservationController.durationValue.value} شب',
                                    style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.black),
                                    textDirection: TextDirection.rtl,
                                  ),
                                  Text('به مدت: ', style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: AppColors.grayColor), textDirection: TextDirection.rtl),
                                ],
                              ),
                            ),
                            const SizedBox(width: 15),
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              padding: const EdgeInsets.only(right: 15, top: 5, bottom: 5, left: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    width: 0.3,
                                    color: AppColors.grayColor,
                                  )),
                              child: Row(
                                children: [
                                  const Icon(Icons.arrow_drop_down, size: 20, color: AppColors.grayColor),
                                  const SizedBox(width: 20),
                                  Text(
                                    '${reservationController.entryDate.value.toJalali().year}/${reservationController.entryDate.value.toJalali().month}/${reservationController.entryDate.value.toJalali().day}  ',
                                    style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.black),
                                    textDirection: TextDirection.rtl,
                                  ),
                                  Text('تاریخ ورود: ', style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: AppColors.grayColor), textDirection: TextDirection.rtl),
                                ],
                              ),
                            ),
                            const Spacer(),
                          ],
                        )),
                    const SizedBox(height: 15),
                    Container(
                      height: 0.5,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 15),
                    roomDetails(mainController),
                    const SizedBox(height: 15),
                    bookerDetails(mainController),
                    const SizedBox(height: 25),
                    sendButton(mainController),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget roomDetails(RegisterReservationController mainController) {
    return Obx(() => mainController.roomRegisterList.isEmpty
        ? const SizedBox()
        : ListView.separated(
            itemCount: mainController.roomRegisterList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 15,
              );
            },
            itemBuilder: (context, roomIndex) {
              return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: const Color(0xffF3F3F3), boxShadow: const [
                    BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.14), blurRadius: 4, offset: Offset(0, 4)),
                  ]),
                  child: Theme(
                    data: ThemeData(
                      dividerColor: Colors.transparent,
                    ),
                    child: ExpansionTile(
                      onExpansionChanged: (value) {
                        mainController.roomRegisterList[roomIndex].isExpanded.value = value;
                      },
                      initiallyExpanded: mainController.roomRegisterList[roomIndex].isExpanded.value,
                      expandedCrossAxisAlignment: CrossAxisAlignment.end,
                      expandedAlignment: Alignment.topRight,
                      shape: Border.all(color: Colors.transparent),
                      trailing: const SizedBox(),
                      tilePadding: const EdgeInsets.only(left: 10),
                      title: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  removeRoom(roomIndex, mainController);
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white, boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.25),
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                      )
                                    ]),
                                    child: SvgPicture.asset('assets/icons/trash_bin_ic.svg')),
                              ),
                              Expanded(
                                  child: Text(
                                mainController.roomRegisterList[roomIndex].roomReservationModel.title,
                                style: Theme.of(Get.context!).textTheme.bodyMedium,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                              )),
                            ],
                          ),
                          Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      RichText(
                                          textDirection: TextDirection.rtl,
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: mainController.roomRegisterList[roomIndex].roomReservationModel.roomPackages[0].finance.days.first.date.toPersianDateStr(
                                                  showDayStr: true,
                                                ),
                                                style: Theme.of(Get.context!).textTheme.labelSmall),
                                            reservationController.durationValue.value > 1 ? TextSpan(text: ' / ', style: Theme.of(Get.context!).textTheme.labelSmall) : const TextSpan(),
                                            reservationController.durationValue.value > 1
                                                ? TextSpan(
                                                    text: mainController.roomRegisterList[roomIndex].roomReservationModel.roomPackages[0].finance.days.last.date.toPersianDateStr(
                                                      showDayStr: true,
                                                    ),
                                                    style: Theme.of(Get.context!).textTheme.labelSmall)
                                                : const TextSpan(),
                                          ])),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '${priceCalculator(
                                          additionalGust: mainController.roomRegisterList[roomIndex].additionalGuest.value,
                                          oneNightPrice: mainController.roomRegisterList[roomIndex].roomReservationModel.roomPackages[0].finance.priceInfo.totalCustomerPrice,
                                          gustPrice: mainController.roomRegisterList[roomIndex].roomReservationModel.roomPackages[0].finance.days[0].additionalGustPrice,
                                        )}تومان / ${mainController.duration.toString()} شب',
                                        style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(fontSize: 16.sp, color: AppColors.mainColor),
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  width: Get.width / 5,
                                  height: Get.width / 5,
                                  child: CachedNetworkImage(
                                    imageUrl: mainController.roomRegisterList[roomIndex].roomReservationModel.thumbImage,
                                    fit: BoxFit.fill,
                                    errorWidget: (context, url, error) => Container(
                                      clipBehavior: Clip.none,
                                      height: Get.width / 5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Image.asset(
                                        'assets/images/image_not_available.png',
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Obx(
                                    () => Row(
                                  children: [
                                    mainController.roomRegisterList[roomIndex].isExpanded.value
                                        ? const Icon(
                                      Icons.keyboard_arrow_up,
                                      color: AppColors.grayColor,
                                      size: 15,
                                    )
                                        : const Icon(Icons.keyboard_arrow_down, color: AppColors.mainColor, size: 15),
                                    mainController.roomRegisterList[roomIndex].isExpanded.value
                                        ? Text(
                                      'اطلاعات کمتر',
                                      style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color: AppColors.grayColor),
                                    )
                                        : Text(
                                      'اطلاعات بیشتر',
                                      style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color: AppColors.mainColor),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: DropdownButtonHideUnderline(
                                  child: Obx(() => DropdownButton2(
                                    isExpanded: true,
                                    style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(
                                      color: AppColors.mainColor,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    items: mainController.roomRegisterList[roomIndex].additionalGuestList,
                                    onChanged: (unit) {
                                      mainController.roomRegisterList[roomIndex].additionalGuest.value = unit!;
                                    },
                                    value: mainController.roomRegisterList[roomIndex].additionalGuest.value,
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
                                  )),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'نفر اضافی: ',
                                style: Theme.of(Get.context!).textTheme.bodyMedium,
                                textDirection: TextDirection.rtl,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5,),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: () {
                                  Get.dialog(facilityDialog(roomFeatures: mainController.roomRegisterList[roomIndex].roomReservationModel.features, title: mainController.roomRegisterList[roomIndex].roomReservationModel.title, hasBrakeFast: mainController.roomRegisterList[roomIndex].roomReservationModel.roomPackages[0].features[0].value, hasDinner: mainController.roomRegisterList[roomIndex].roomReservationModel.roomPackages[0].features[1].value, hasLunch: mainController.roomRegisterList[roomIndex].roomReservationModel.roomPackages[0].features[2].value));
                                },
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
                              const SizedBox(
                                height: 10,
                              ),
                              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                Flexible(
                                  flex: 2,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(width: 0.1, color: mainController.roomRegisterList[roomIndex].roomReservationModel.roomPackages[0].features[2].value == 1 ? AppColors.mainColor : Colors.grey),
                                    ),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                      Text(mainController.roomRegisterList[roomIndex].roomReservationModel.roomPackages[0].features[2].value == 1 ? 'شام دارد' : 'شام ندارد', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: mainController.roomRegisterList[roomIndex].roomReservationModel.roomPackages[0].features[2].value == 1 ? AppColors.mainColor : Colors.grey)),
                                      const SizedBox(width: 2),
                                      SvgPicture.asset('assets/icons/lunch_ic.svg', color: mainController.roomRegisterList[roomIndex].roomReservationModel.roomPackages[0].features[2].value == 1 ? AppColors.mainColor : Colors.grey),
                                    ]),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Flexible(
                                  flex: 2,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(width: 0.1, color: mainController.roomRegisterList[roomIndex].roomReservationModel.roomPackages[0].features[1].value == 1 ? AppColors.mainColor : Colors.grey),
                                    ),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                      Text(mainController.roomRegisterList[roomIndex].roomReservationModel.roomPackages[0].features[1].value == 1 ? 'نهار دارد' : 'نهار ندارد', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: mainController.roomRegisterList[roomIndex].roomReservationModel.roomPackages[0].features[1].value == 1 ? AppColors.mainColor : Colors.grey)),
                                      const SizedBox(width: 2),
                                      SvgPicture.asset('assets/icons/dinner_ic.svg', color: mainController.roomRegisterList[roomIndex].roomReservationModel.roomPackages[0].features[1].value == 1 ? AppColors.mainColor : Colors.grey),
                                    ]),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Flexible(
                                  flex: 2,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(width: 0.1, color: mainController.roomRegisterList[roomIndex].roomReservationModel.roomPackages[0].features[0].value == 1 ? AppColors.mainColor : Colors.grey),
                                    ),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                      Text(mainController.roomRegisterList[roomIndex].roomReservationModel.roomPackages[0].features[0].value == 1 ? 'صبحانه دارد' : 'صبحانه ندارد', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: mainController.roomRegisterList[roomIndex].roomReservationModel.roomPackages[0].features[0].value == 1 ? AppColors.mainColor : Colors.grey)),
                                      const SizedBox(width: 2),
                                      SvgPicture.asset('assets/icons/breakfast_ic.svg', color: mainController.roomRegisterList[roomIndex].roomReservationModel.roomPackages[0].features[0].value == 1 ? AppColors.mainColor : Colors.grey),
                                    ]),
                                  ),
                                ),
                              ]),
                              const SizedBox(
                                height: 10,
                              ),
                              mainController.roomRegisterList[roomIndex].roomReservationModel.details == null
                                  ? const SizedBox()
                                  : RichText(
                                      textDirection: TextDirection.rtl,
                                      text: TextSpan(children: [
                                        TextSpan(text: 'توضیحات: ', style: Theme.of(Get.context!).textTheme.bodyMedium),
                                        TextSpan(text: mainController.roomRegisterList[roomIndex].roomReservationModel.details?.toPersianDigit(), style: Theme.of(Get.context!).textTheme.titleLarge),
                                      ]),
                                    ),
                              const SizedBox(
                                height: 5,
                              ),
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(text: 'پرداختی برای: ', style: Theme.of(Get.context!).textTheme.bodyMedium),
                                  TextSpan(text: mainController.roomRegisterList[roomIndex].roomReservationModel.roomPackages[0].finance.priceInfo.paidNumber.toString().toPersianDigit(), style: Theme.of(Get.context!).textTheme.titleLarge),
                                  TextSpan(text: ' نفر', style: Theme.of(Get.context!).textTheme.titleLarge),
                                ]),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Flexible(
                                    child: Container(
                                      height: Get.width / 4.7,
                                      width: Get.width,
                                      padding: const EdgeInsets.only(right: 15),
                                      child: ListView.separated(
                                        itemCount: mainController.roomRegisterList[roomIndex].roomReservationModel.roomPackages[0].finance.days.length,
                                        shrinkWrap: true,
                                        reverse: true,
                                        physics: const BouncingScrollPhysics(),
                                        // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                        scrollDirection: Axis.horizontal,
                                        separatorBuilder: (context, roomsIndex) {
                                          return const SizedBox(width: 10);
                                        },
                                        itemBuilder: (context, daysIndex) {
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
                                                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.mainColor.withOpacity(0.1),
                                                  ),
                                                  child: Text(
                                                      mainController.roomRegisterList[roomIndex].roomReservationModel.roomPackages[0].finance.days[daysIndex].date.toPersianDateStr(
                                                        showDayStr: true,
                                                      ),
                                                      style: Theme.of(Get.context!).textTheme.labelSmall,
                                                      maxLines: 1,
                                                      textAlign: TextAlign.start),
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  '${mainController.roomRegisterList[roomIndex].roomReservationModel.roomPackages[0].finance.days[daysIndex].originalPrice.toString().seRagham()} تومان',
                                                  style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color: AppColors.grayColor),
                                                  textDirection: TextDirection.rtl,
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  'نفر اضافه: ${mainController.roomRegisterList[roomIndex].roomReservationModel.roomPackages[0].finance.days[daysIndex].additionalGustPrice.toString().seRagham()} تومان',
                                                  style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color: AppColors.grayColor),
                                                  textDirection: TextDirection.rtl,
                                                ),
                                                const Spacer(),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    mainController.roomRegisterList[roomIndex].roomReservationModel.roomPackages[0].finance.days[daysIndex].availability == 'available'
                                                        ? Container(
                                                            decoration: const BoxDecoration(
                                                              color: AppColors.mainColor,
                                                              shape: BoxShape.circle,
                                                            ),
                                                            padding: const EdgeInsets.all(2),
                                                            child: const Icon(Icons.done_rounded, size: 6, color: Colors.white))
                                                        : const SizedBox(),
                                                    mainController.roomRegisterList[roomIndex].roomReservationModel.roomPackages[0].finance.days[daysIndex].availability == 'available' ? const SizedBox(width: 2) : const SizedBox(),
                                                    Text(reservationController.roomAvailabilityCheck(mainController.roomRegisterList[roomIndex].roomReservationModel.roomPackages[0].finance.days[daysIndex].availability), style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color: AppColors.mainColor)),
                                                  ],
                                                ),
                                                const SizedBox(height: 3),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'جزئیات قیمت',
                                    style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color: AppColors.grayColor),
                                  ),
                                  const SizedBox(width: 5),
                                  const Icon(
                                    Icons.info,
                                    color: AppColors.grayColor,
                                    size: 15,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ));
            },
          ));
  }

  Widget bookerDetails(RegisterReservationController mainController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('مشخصات رزروکننده', style: Theme.of(Get.context!).textTheme.bodyMedium),
          const SizedBox(
            height: 25,
          ),
          FocusScope(
            child: Focus(
              autofocus: false,
              onFocusChange: (value) {
                mainController.isTextFieldSelected.value = value;
              },
              child: Obx(() => MyTextField(
                    label: 'نام و نام خانوادگی',
                    verticalScrollPadding: 15,
                    textEditingController: mainController.nameController,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9a-zA-Zا-ی ئ و ]'))],
                    maxline: 1,
                    validator: (value) {
                      final char = value?.contains(RegExp(r'[!@#<>?":-`~;[\]\\|=+)(*&^%]_'));
                      final number = value?.contains(RegExp(r'[۰۱۲۳۴۵۶۷۸۹]'));
                      if (value!.isEmpty) {
                        return 'لطفا نام و نام خانوادگی خود را وارد کنید'.tr;
                      }
                      if (char == true) {
                        return "علامت مجاز نیست".tr;
                      }
                      if (number == true) {
                        return "لطفا نام و نام خانوادگی خود را وارد کنید".tr;
                      }
                      if (value.length < 2) {
                        return "لطفا نام و نام خانوادگی خود را وارد کنید".tr;
                      }
                      return null;
                    },
                    onEditingComplete: () {
                      mainController.isTextFieldSelected.value = false;
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    keyboardType: TextInputType.name,
                    iconButton: mainController.isTextFieldSelected.value
                        ? IconButton(
                            splashRadius: 20,
                            onPressed: () {
                              mainController.nameController.clear();
                            },
                            icon: SvgPicture.asset('assets/icons/close_ic.svg'))
                        : null,
                    textInputAction: TextInputAction.next,
                  )),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
            label: 'شماره همراه',
            hintText: 'شماره همراه (اجباری)',
            length: 11,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0-9]')),
            ],
            validator: (value) {
              final something = value?.startsWith(RegExp(r"09[9,0,3,2,1]"));
              if (value!.isEmpty) {
                return 'این فیلد نباید خالی باشد'.tr;
              }
              if (value.length == 11 && something == true) {
                return null;
              }
              return "شماره معتبر نیست".tr;
            },
            textEditingController: mainController.phoneNumberController,
            maxline: 1,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
            label: 'شماره ثابت',
            length: 11,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0-9]')),
            ],
            validator: (value) {
              final something = value?.startsWith(RegExp(r"084|021|011|071|017|066|031|041|045|061|051|056|058|028|026|044|024|023|076|074|035|054"));
              if (value!.isEmpty) {
                return 'این فیلد نباید خالی باشد'.tr;
              }
              if (something == true && value.length > 8) {
                return null;
              }
              return 'لطفا شماره ثابت را وارد کنید.';
            },
            textEditingController: mainController.homeNumberController,
            maxline: 1,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
            label: 'پست الکترونیکی',
            hintText: 'پست الکترونیکی (اختیاری)',
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9@_]')),
            ],
            textEditingController: mainController.emailController,
            maxline: 1,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: 25),
          Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end, children: [
            Expanded(
              child: RichText(
                  textDirection: TextDirection.rtl,
                  text: TextSpan(text: 'با ارسال این فرم ', style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color: AppColors.grayColor), children: [
                    TextSpan(
                      text: 'قوانین یواسپیس ',
                      style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color: AppColors.mainColor, decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Single tapped.
                        },
                    ),
                    TextSpan(text: 'را میپذیرم و تایید میکنم که مدارک شناسایی و محرمیت معتبر را به همراه دارم', style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color: AppColors.grayColor)),
                  ])),
            ),
            const SizedBox(width: 5),
            InkWell(
              onTap: () {
                mainController.isAcceptTerms.toggle();
              },
              borderRadius: BorderRadius.circular(100),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
                child: Obx(() => Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: mainController.isAcceptTerms.value ? AppColors.mainColor : AppColors.grayColor.withOpacity(0.7), boxShadow: [mainController.isAcceptTerms.value ? BoxShadow(color: AppColors.mainColor.withOpacity(0.1), spreadRadius: 6, blurRadius: 0.1) : BoxShadow(color: AppColors.mainColor.withOpacity(0.1), spreadRadius: 6, blurRadius: 0.1)]),
                    )),
              ),
            ),
          ]),
          const SizedBox(height: 25),
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
                    mainController.cancelingRules.value = value;
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
                      reservationController.room.value!.data.rules.cancelTerms ?? '',
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
          reservationController.room.value!.data.rules.kidsTerms != null
              ? Container(
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
                          mainController.cancelingRules.value = value;
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
                            reservationController.room.value!.data.rules.kidsTerms ?? '',
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
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  void removeRoom(int index, RegisterReservationController mainController) {
    Get.dialog(Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              width: Get.width,
              height: Get.height / 6.5,
              clipBehavior: Clip.hardEdge,
              margin: const EdgeInsets.only(right: 10, left: 10, top: 12),
              decoration: const BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(18), topLeft: Radius.circular(18))),
              child: CachedNetworkImage(
                imageUrl: mainController.roomRegisterList[index].roomReservationModel.thumbImage,
                fit: BoxFit.fill,
                errorWidget: (context, url, error) => Container(
                  clipBehavior: Clip.none,
                  width: Get.width,
                  height: Get.height / 6.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(
                    'assets/images/image_not_available.png',
                    fit: BoxFit.scaleDown,
                  ),
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text('ایا مطمئنید، این اتاق از لیست رزرو شده ها حذف شود؟', textAlign: TextAlign.center, textDirection: TextDirection.rtl, style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(fontSize: 18, color: AppColors.redColor)),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.grayColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      )),
                  child: Text('خیر', style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(color: Colors.white)),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    mainController.roomRegisterList.removeAt(index);
                    Get.back();
                    if (mainController.roomRegisterList.isEmpty) {
                      Get.back();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.redColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      )),
                  child: Text('بله مطمئنم', style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(color: Colors.white)),
                ),
              ),
            ]),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    ));
  }

  Widget sendButton(RegisterReservationController mainController) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () {
              if (mainController.formKey.currentState!.validate()) {
                mainController.booking();
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
                'ارسال و درخواست رزرو (رایگان)',
                style: Theme.of(Get.context!).textTheme.displayMedium!.copyWith(fontSize: 16.sp, color: Colors.white),
              )),
            ),
          ),
        ],
      ),
    );
  }

  priceCalculator(
      {required int additionalGust, required int oneNightPrice ,int? gustPrice}){
    if(additionalGust != 0){
      oneNightPrice += (additionalGust * gustPrice!);
    }
    return oneNightPrice.toString().seRagham();
  }
}
