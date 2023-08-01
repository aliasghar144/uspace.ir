import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/app/widgets/textfield.dart';
import 'package:uspace_ir/controllers/dropdown_controller.dart';

class RoomReservationScreen extends StatelessWidget {
  RoomReservationScreen({Key? key}) : super(key: key);
  DropDownController dropDownController = Get.find();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController homeNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  RxBool isTextFieldSelected = false.obs;
  RxBool isAcceptTerms = false.obs;

  List facilities = [
    'تخت دبل',
    'تعداد پله:بدون پله',
    'تعداد خواب:بدون خواب',
    'نوع واحد:سنتی',
    'توالت فرنگی مستقل',
    'متراژ:20متر',
    'چشم انداز:حیاط',
    'حمام مستقل',
    'توالت فرنگی',
    'صبحانه',
    'مینی بار ',
    'نور گیر',
    'شوفاژ',
    'یخچال',
    'کافی شاپ',
    'اینترنت رایگان',
    'صندوق امانات'
  ].obs;

  ///date and time picker
  ///
  RxBool isDurationSelected = false.obs;
  RxBool isDateSelected = false.obs;
  var selectedDate = DateTime.now().obs;

  ///////////////////////////////////////


  // rooms reserved
  //

  RxList roomReserved =
      [0].obs;

  RxList<RxBool> showMore =
      [false.obs, false.obs, false.obs, false.obs, false.obs].obs;
  /////////////////////////////////////////////////////////////



  var dropDownValue = 'شرایط کنسلی'.obs;
  var babyRoleDropDownValue = 'قوانین خردسالان'.obs;

  var dropDownItems = [
    'شرایط کنسلی',
    'دلیل 1',
    'دلیل 2',
    'دلیل 3',
  ];

  var babyRoleDropDownItems = [
    'قوانین خردسالان',
    '2قوانین خردسالان',
    'قوانین خردسالان3',
    'قوانین خردسالان4',
  ];

  final formKey = GlobalKey<FormState>();

  final List servicesList = [
    {
      'title': 'چشم انداز : حیاط',
      'icon': 'assets/icons/carbon_view-filled_ic.svg'
    },
    {'title': 'پرداختی برای: 2نفر', 'icon': 'assets/icons/payment_ic.svg'},
    {'title': 'متراژ: 20متر', 'icon': 'assets/icons/focus_ic.svg'},
    {'title': 'طبقه: همکف', 'icon': 'assets/icons/home_ic.svg'},
  ];
  final List servicesList2 = [
    '1 تخت دبل',
    'صبحانه',
    'حمام مستقل',
    'توالت فرنگی',
  ];

  final durationDropDownValue = 'به مدت: 1 شب'.obs;

  final List<String> durationDropDownItems = [
    'به مدت: 1 شب',
    'به مدت: 2 شب',
    'به مدت: 3 شب',
    'به مدت: 5 شب',
    'به مدت: 6 شب',
  ];


  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: GestureDetector(
        onTap: () {
          isTextFieldSelected.value = false;
          return FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Form(
          key: formKey,
          child: Scaffold(
            backgroundColor: const Color(0xffFFFFFF),
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: 15, top: 15.0),
                child: IconButton(
                  splashRadius: 20,
                  icon: SvgPicture.asset('assets/icons/bell_ic.svg'),
                  onPressed: () {},
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15, top: 15.0),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    splashRadius: 20,
                    icon: const Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: _buildBody(),
              ),
            ),
            bottomNavigationBar: Container(
              width: Get.width,
              height: 75,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(22),
                      topRight: Radius.circular(22)),
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
                  ]),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15.0),
                child: Row(children: [
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.mainColor),
                    child: Center(
                        child: Text('ارسال درخواست رزرو',
                            style: Theme.of(Get.context!)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.white))),
                  )),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: AppColors.mainColor, width: 0.5)),
                    child: Center(
                        child: Text('2,000,000 تومان / یک شب',
                            textDirection: TextDirection.rtl,
                            maxLines: 1,
                            style: Theme.of(Get.context!)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: AppColors.mainColor,
                                ))),
                  )),
                ]),
              ),
            ),
          ),
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
        Obx(
          () => roomReserved.isEmpty
              ? const SizedBox(
                  height: 30,
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SizedBox(
                    height: Get.width * 0.33,
                    child: Obx(() => ListView.separated(
                        reverse: true,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  roomReserved.removeAt(index);
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 10, bottom: 5),
                                    width: Get.width / 5.5,
                                    height: Get.width / 5.5,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl:
                                              "https://shiranhotel.uspace.ir/spaces/shiranhotel/images/main/shiranhotel_uspace_1638686061.jpg",
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                                  Icons.broken_image_outlined),
                                        ),
                                        const Icon(Icons.close_rounded,
                                            color: Colors.white, size: 40),
                                      ],
                                    )),
                              ),
                              Text('اتاق سه تخته پریخان خانم',
                                  style: Theme.of(Get.context!)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(fontSize: 8)),
                              const SizedBox(height: 20)
                            ],
                          );
                        },
                        shrinkWrap: true,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 10),
                        scrollDirection: Axis.horizontal,
                        itemCount: roomReserved.length)),
                  ),
                ),
        ),
        reserverInformation(),
      ],
    );
  }

  mainSection() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(23),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: const Color(0xff888888).withOpacity(0.1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: Get.width,
                  height: 195,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(),
                  child: Hero(
                    tag: 'hero ${Get.arguments}',
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://shiranhotel.uspace.ir/spaces/shiranhotel/images/main/shiranhotel_uspace_1638686061.jpg",
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.broken_image_outlined),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -12,
                  child: Container(
                      height: 30,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black54.withOpacity(0.05),
                              blurRadius: 5,
                              spreadRadius: 0.5,
                              offset: const Offset(0, 4))
                        ],
                        color: Colors.white,
                      ),
                      child: Center(
                          child: Text(
                              'اتاق سه تخته پریخان خانم هتل سنتی شیران_اصفهان',
                              textAlign: TextAlign.start,
                              textDirection: TextDirection.rtl,
                              style: Theme.of(Get.context!)
                                  .textTheme
                                  .labelSmall))),
                )
              ],
            ),
            const SizedBox(height: 30),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      Obx(() => Directionality(
                            textDirection: TextDirection.rtl,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                style: Theme.of(Get.context!)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(fontSize: 8),
                                items:
                                    durationDropDownItems.map((selectedType) {
                                  return DropdownMenuItem(
                                    alignment: Alignment.centerRight,
                                    value: selectedType,
                                    child: Text(
                                      selectedType,
                                      style: Theme.of(Get.context!)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(color: AppColors.grayColor),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                   durationDropDownValue.value = value!;
                                },
                                value: durationDropDownValue.value,
                                buttonStyleData: ButtonStyleData(
                                  height: 35,
                                  width: Get.width / 2.5,
                                  padding: const EdgeInsets.only(
                                      right: 10, left: 8, top: 0, bottom: 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(
                                      width: 0.3,
                                      color: AppColors.grayColor,
                                    ),
                                  ),
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.arrow_drop_down_rounded,
                                  ),
                                  iconEnabledColor: AppColors.grayColor,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                    elevation: 2,
                                    width: Get.width / 2.5,
                                    padding: EdgeInsets.zero,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(12),
                                          bottomLeft: Radius.circular(12)),
                                    ),
                                    direction: DropdownDirection.textDirection,
                                    scrollbarTheme: ScrollbarThemeData(
                                      radius: const Radius.circular(40),
                                      thickness: MaterialStateProperty.all(6),
                                      thumbVisibility:
                                          MaterialStateProperty.all(true),
                                    )),
                              ),
                            ),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () async {
                          Jalali? picked = await showPersianDatePicker(
                            context: Get.context!,
                            initialDate: Jalali.now(),
                            firstDate: Jalali.now(),
                            lastDate: Jalali(1404, 1),
                            builder: (context, child) {
                              return Theme(
                                data: ThemeData(
                                  dialogTheme: DialogTheme(
                                    contentTextStyle: Theme.of(Get.context!)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.red),
                                    titleTextStyle:
                                        TextStyle(color: Colors.red),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          var label = picked?.toDateTime();
                          print(picked);
                          if (picked != null) {
                            isDateSelected.value = true;
                          }
                        },
                        child: Container(
                            height: 35,
                            width: Get.width / 2.5,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.3, color: AppColors.grayColor),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(children: [
                                const Icon(Icons.arrow_drop_down_rounded,
                                    color: AppColors.disabledIcon),
                                const Spacer(),
                                Obx(
                                  () => isDateSelected.value
                                      ? Text(
                                          'تاریخ ورود:${selectedDate.value.toJalali().year}/${selectedDate.value.toJalali().month}/${selectedDate.value.toJalali().day}',
                                          textDirection: TextDirection.rtl,
                                          style: Theme.of(Get.context!)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(
                                                  color: AppColors.grayColor))
                                      : Text('تاریخ ورورد',
                                          style: Theme.of(Get.context!)
                                              .textTheme
                                              .labelMedium!
                                              .copyWith(
                                                  color:
                                                      AppColors.disabledText)),
                                ),
                              ]),
                            )),
                      ),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextButton.icon(
                            onPressed: () {
                              Get.dialog(removeRoom());
                            },
                            icon: SvgPicture.asset(
                              'assets/icons/trash_ic.svg',
                            ),
                            label: Text('حذف اتاق',
                                style: Theme.of(Get.context!)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(color: const Color(0xffEA213B))),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextButton.icon(
                            onPressed: () {
                              Get.bottomSheet(moreRoomSelect(),
                                  isDismissible: true,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(23),
                                          topRight: Radius.circular(23))));
                            },
                            icon: SvgPicture.asset(
                              'assets/icons/rooms_ic.svg',
                              color: AppColors.mainColor,
                            ),
                            label: Text('انتخاب اتاق های بیشتر',
                                style: Theme.of(Get.context!)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(color: AppColors.mainColor)),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
            const Divider(
              height: 20,
            ),
            roomServicesAndFacility(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  moreRoomSelect() {
    return SizedBox(
      height: Get.height * 0.9,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(right: 20.0,left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.cancel_rounded,
                      color: AppColors.grayColor,
                    )),
                const Spacer(),
                Text('انتخاب اتاق های بیشتر',
                    style: Theme.of(Get.context!)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppColors.mainColor)),
                const SizedBox(width: 5),
                SvgPicture.asset('assets/icons/rooms_big_ic.svg'),
              ],
            ),
          ),
          const Divider(thickness: 1),
          Expanded(
            child: ListView.separated(
              itemCount: 5,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 1,
                  height: 20,
                );
              },
              itemBuilder: (context, index) {
                return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                          'اتاق سه تخته پریخان خانم هتل سنتی شیران_اصفهان',
                                          softWrap: true,
                                          textDirection: TextDirection.rtl,
                                          style: Theme.of(Get.context!)
                                              .textTheme
                                              .labelSmall),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: Get.width / 4.2,
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 3.0),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: AppColors
                                                          .mainColor,
                                                      width: 0.5),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      8)),
                                              child: Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    vertical: 6.0),
                                                child: Center(
                                                    child: Text(
                                                        '2,000,000 تومان / یک شب',
                                                        softWrap: true,
                                                        textDirection:
                                                        TextDirection
                                                            .rtl,
                                                        style: Theme.of(Get
                                                            .context!)
                                                            .textTheme
                                                            .bodySmall!
                                                            .copyWith(
                                                            fontSize: 8,
                                                            color:AppColors.mainColor))),
                                              ),
                                            )
                                          ]),
                                      const SizedBox(
                                        height:5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Obx(() => TextButton.icon(
                                              onPressed: () {
                                                showMore[index].toggle();
                                              },
                                              icon: Icon(
                                                showMore[index].value
                                                    ? Icons
                                                    .keyboard_arrow_up_rounded
                                                    : Icons
                                                    .keyboard_arrow_down_rounded,
                                                size: 15,
                                              ),
                                              label: Text(
                                                  showMore[index].value
                                                      ? 'کمتر'
                                                      : 'امکانات بیشتر',
                                                  style: Theme.of(
                                                      Get.context!)
                                                      .textTheme
                                                      .titleMedium!
                                                      .copyWith(
                                                      color: Colors
                                                          .blueAccent,
                                                      fontSize: 10)))),
                                          InkWell(
                                            onTap: () {
                                              if(!roomReserved.contains(index)){
                                                roomReserved.add(index);
                                              }
                                            },
                                            child: Obx(() => Container(
                                              width: Get.width / 4.2,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    8),
                                                color: roomReserved.contains(index) ?  AppColors.grayColor : AppColors.mainColor,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    vertical: 6.0),
                                                child: Center(
                                                    child: Text(
                                                      roomReserved.contains(index) ? 'رزور شده':'رزرو اتاق',
                                                      style:
                                                      Theme.of(Get.context!)
                                                          .textTheme
                                                          .bodySmall!
                                                          .copyWith(
                                                          color: Colors
                                                              .white,
                                                          fontSize: 10),
                                                    )),
                                              ),
                                            )),
                                          )
                                        ],
                                      )
                                    ]),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  width: Get.width / 4.5,
                                  height: Get.width / 4.5,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Hero(
                                    tag: 'hero $index',
                                    child: CachedNetworkImage(
                                      imageUrl:
                                      "https://shiranhotel.uspace.ir/spaces/shiranhotel/images/main/shiranhotel_uspace_1638686061.jpg",
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                      const Icon(
                                          Icons.broken_image_outlined),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                        Obx(() =>Wrap(
                          direction: Axis.horizontal,
                          textDirection: TextDirection.rtl,
                          children: facilitiesList(
                              showMore: showMore[index].value,
                              facilitiesList: facilities)
                              .map((item) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 5.0),
                                    child: Text(item,
                                        style: Theme.of(Get.context!)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(
                                            fontSize: 10,
                                            color:
                                            AppColors.grayColor)),
                                  ),
                                  const Icon(Icons.done_all_rounded,
                                      size: 15,
                                      color: AppColors.grayColor)
                                ],
                              ),
                            );
                          }).toList(),
                        )),
                      ],
                    ));
              },
            ),
          ),
          const SizedBox(height: 15,),
          Container(
            height: Get.width * 0.33,
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
            decoration: const BoxDecoration(
                color: Color(0xffE9E9E9),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(23),
                  topLeft: Radius.circular(23),
                )),
            child: Obx(() => ListView.separated(
              physics: const BouncingScrollPhysics(),
                reverse: true,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          roomReserved.removeAt(index);
                        },
                        child: Expanded(
                          child: Container(
                              margin: const EdgeInsets.only(top: 10, bottom: 5),
                              width: Get.width / 5.5,
                              height: Get.width / 5.5,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:
                                        "https://shiranhotel.uspace.ir/spaces/shiranhotel/images/main/shiranhotel_uspace_1638686061.jpg",
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.broken_image_outlined),
                                  ),
                                  const Icon(Icons.close_rounded,
                                      color: Colors.white, size: 40),
                                ],
                              )),
                        ),
                      ),
                      Text('اتاق سه تخته پریخان خانم',
                          style: Theme.of(Get.context!)
                              .textTheme
                              .labelSmall!
                              .copyWith(fontSize: 8)),
                      const SizedBox(height: 20)
                    ],
                  );
                },
                shrinkWrap: true,
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                scrollDirection: Axis.horizontal,
                itemCount: roomReserved.length)),
          ),
        ],
      ),
    );
  }

  removeRoom() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(23),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        height: Get.height / 2.5,
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
                child: Container(
                    width: Get.width,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(18),
                            topLeft: Radius.circular(18))),
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://shiranhotel.uspace.ir/spaces/shiranhotel/images/main/shiranhotel_uspace_1638686061.jpg",
                      fit: BoxFit.fill,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.broken_image_outlined),
                    ))),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text('ایا مطمئنید، این اتاق از لیست رزرو شده ها حذف شود؟',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: Theme.of(Get.context!)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 18, color: AppColors.redColor)),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
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
                        child: Text('خیر',
                            style: Theme.of(Get.context!)
                                .textTheme
                                .labelLarge!
                                .copyWith(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          roomReserved.removeAt(0);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.redColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            )),
                        child: Text('بله مطمئنم',
                            style: Theme.of(Get.context!)
                                .textTheme
                                .labelLarge!
                                .copyWith(color: Colors.white)),
                      ),
                    ),
                  ]),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  roomServicesAndFacility() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('لیست خدمات و امکانات',
              style: Theme.of(Get.context!).textTheme.bodyMedium),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: Get.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: Get.width / 2 - 20,
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(servicesList[index]['title'],
                                  textDirection: TextDirection.rtl,
                                  style: Theme.of(Get.context!)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(color: AppColors.grayColor)),
                              const SizedBox(
                                width: 5,
                              ),
                              SvgPicture.asset(servicesList[index]['icon']),
                            ]);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: servicesList.length),
                ),
                SizedBox(
                  width: Get.width / 2 - 20,
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(servicesList2[index],
                                  style: Theme.of(Get.context!)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(color: AppColors.grayColor)),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(Icons.done_all_rounded,
                                  color: AppColors.grayColor, size: 15),
                            ]);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: servicesList2.length),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  reserverInformation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('مشخصات رزروکننده',
              style: Theme.of(Get.context!).textTheme.bodyMedium),
          const SizedBox(
            height: 25,
          ),
          FocusScope(
            child: Focus(
              onFocusChange: (value) {
                isTextFieldSelected.value = value;
              },
              child: Obx(() => MyTextField(
                    label: 'نام و نام خانوادگی',
                    textEditingController: nameController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[ا-ی ئ و ]'))
                    ],
                    maxline: 1,
                    onEditingComplete: () {
                      isTextFieldSelected.value = false;
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    keyboardType: TextInputType.name,
                    iconButton: isTextFieldSelected.value
                        ? IconButton(
                        splashRadius: 20,
                        onPressed: () {
                              nameController.clear();
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
            textEditingController: phoneNumberController,
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
            textEditingController: homeNumberController,
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
            textEditingController: emailController,
            maxline: 1,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: 25),
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: RichText(
                      textDirection: TextDirection.rtl,
                      text: TextSpan(
                          text: 'با ارسال این فرم ',
                          style: Theme.of(Get.context!)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: AppColors.grayColor),
                          children: [
                            TextSpan(
                              text: 'قوانین یواسپیس ',
                              style: Theme.of(Get.context!)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                      color: AppColors.mainColor,
                                      decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print('read form');
                                  // Single tapped.
                                },
                            ),
                            TextSpan(
                                text:
                                    'را میپذیرم و تایید میکنم که مدارک شناسایی و محرمیت معتبر را به همراه دارم',
                                style: Theme.of(Get.context!)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(color: AppColors.grayColor)),
                          ])),
                ),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    isAcceptTerms.toggle();
                  },
                  borderRadius: BorderRadius.circular(100),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10.0),
                    child: Obx(() => Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isAcceptTerms.value
                                  ? AppColors.mainColor
                                  : AppColors.grayColor.withOpacity(0.7),
                              boxShadow: [
                                isAcceptTerms.value
                                    ? BoxShadow(
                                        color: AppColors.mainColor
                                            .withOpacity(0.1),
                                        spreadRadius: 6,
                                        blurRadius: 0.1)
                                    : BoxShadow(
                                        color: AppColors.mainColor
                                            .withOpacity(0.1),
                                        spreadRadius: 6,
                                        blurRadius: 0.1)
                              ]),
                        )),
                  ),
                ),
              ]),
          const SizedBox(height: 25),
          Obx(
            () => Directionality(
              textDirection: TextDirection.rtl,
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  items: dropDownItems
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            alignment: Alignment.centerRight,
                            child: Text(
                              item,
                              style: Theme.of(Get.context!)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: AppColors.disabledText),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  value: dropDownValue.value,
                  onChanged: (value) {
                    dropDownValue.value = value as String;
                  },
                  buttonStyleData: ButtonStyleData(
                    height: 50,
                    width: Get.width,
                    padding: const EdgeInsets.only(
                        right: 15, left: 5, top: 5, bottom: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.black26,
                      ),
                    ),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                    ),
                    iconEnabledColor: AppColors.disabledIcon,
                  ),
                  dropdownStyleData: DropdownStyleData(
                      elevation: 3,
                      width: Get.width - 40,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all(6),
                        thumbVisibility: MaterialStateProperty.all(true),
                      )),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                    padding: EdgeInsets.only(left: 14, right: 14),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Obx(
            () => Directionality(
              textDirection: TextDirection.rtl,
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  items: babyRoleDropDownItems
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            alignment: Alignment.centerRight,
                            child: Text(
                              item,
                              style: Theme.of(Get.context!)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: AppColors.disabledText),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  value: babyRoleDropDownValue.value,
                  onChanged: (value) {
                    babyRoleDropDownValue.value = value as String;
                  },
                  buttonStyleData: ButtonStyleData(
                    height: 50,
                    width: Get.width,
                    padding: const EdgeInsets.only(
                        right: 15, left: 5, top: 5, bottom: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.black26,
                      ),
                    ),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                    ),
                    iconEnabledColor: AppColors.disabledIcon,
                  ),
                  dropdownStyleData: DropdownStyleData(
                      elevation: 3,
                      width: Get.width - 40,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all(6),
                        thumbVisibility: MaterialStateProperty.all(true),
                      )),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                    padding: EdgeInsets.only(left: 14, right: 14),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 35,
          ),
        ],
      ),
    );
  }

  List<dynamic> facilitiesList(
      {required bool showMore, required List facilitiesList}) {
    if (showMore) {
      return facilitiesList;
    } else {
      return facilitiesList.getRange(0, 4).toList();
    }
  }


}
