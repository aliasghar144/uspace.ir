import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/app/widgets/textfield.dart';

class RoomReservationScreen extends StatelessWidget {
  RoomReservationScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController homeNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  RxBool isTextFieldSelected = false.obs;
  RxBool isAcceptTerms = false.obs;

  var dropDownValue = 'شرایط کنسلی'.obs;

  var dropDownItems = [
    'شرایط کنسلی',
    'دوست داشتم',
    'دلدرد',
    'سردرد',
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
                      onPressed: () {},
                      splashRadius: 20,
                      icon: Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: 15),
                      Container(
                        width: Get.width,
                        height: 195,
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                topLeft: Radius.circular(25))),
                        child: CachedNetworkImage(
                          imageUrl:
                              "http://via.placeholder.com/320x150&text=image",
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.broken_image_outlined),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                  'اتاق سه تخته پریخان خانم هتل سنتی شیران_اصفهان',
                                  style: Theme.of(context).textTheme.bodySmall),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(mainAxisSize: MainAxisSize.min, children: [
                                Container(
                                  height: 35,
                                  width: Get.width / 2 - 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.7, color: AppColors.borderColor),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(children: [
                                      const Icon(Icons.arrow_drop_down_rounded,
                                          color: AppColors.disabledIcon),
                                      const Spacer(),
                                      Text('به مدت: 1 شب',
                                          style: Theme.of(Get.context!)
                                              .textTheme
                                              .labelMedium!
                                              .copyWith(
                                                  color: AppColors.disabledText)),
                                    ]),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                    height: 35,
                                    width: Get.width / 2 - 30,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.7,
                                          color: AppColors.borderColor),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(children: [
                                        const Icon(Icons.arrow_drop_down_rounded,
                                            color: AppColors.disabledIcon),
                                        const Spacer(),
                                        Text('تاریخ ورود: 1402/04/14',
                                            style: Theme.of(Get.context!)
                                                .textTheme
                                                .labelMedium!
                                                .copyWith(
                                                    color:
                                                        AppColors.disabledText)),
                                      ]),
                                    )),
                              ]),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextButton.icon(
                                  onPressed: () {},
                                  icon: SvgPicture.asset(
                                    'assets/icons/rooms_ic.svg',
                                    color: AppColors.mainColor,
                                  ),
                                  label: Text('انتخاب اتاق های بیشتر',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(color: AppColors.mainColor)),
                                ),
                              ),
                            ],
                          )),
                      const Divider(
                        height: 30,
                      ),
                      roomServicesAndFacility(),
                      const Divider(
                        height: 30,
                      ),
                      reserverInformation(),
                    ],
                  ),
                ),
              ),
            bottomNavigationBar: Container(
              width: Get.width,
              height: 75,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(22),topRight:Radius.circular(22)),
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
                ]
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15.0),
                child: Row(
                  children:[
                    Expanded(child: Container(decoration:BoxDecoration(borderRadius:BorderRadius.circular(8),color: AppColors.mainColor),child: Center(child:Text('ارسال درخواست رزرو',style:Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(color:Colors.white))),)),
                    const SizedBox(width: 15,),
                    Expanded(child: Container(decoration:BoxDecoration(borderRadius:BorderRadius.circular(8),border:Border.all(color:AppColors.mainColor,width: 0.5)),child: Center(child:Text('2,000,000 تومان / یک شب',textDirection: TextDirection.rtl,maxLines: 1,style:Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color:AppColors.mainColor,))),)),
                  ]
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  roomServicesAndFacility(){
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
                      physics:
                      const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Row(
                            mainAxisAlignment:
                            MainAxisAlignment.end,
                            children: [
                              Text(servicesList[index]['title'],
                                  textDirection:
                                  TextDirection.rtl,
                                  style: Theme.of(Get.context!)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                      color: AppColors
                                          .grayColor)),
                              const SizedBox(
                                width: 5,
                              ),
                              SvgPicture.asset(
                                  servicesList[index]['icon']),
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
                      physics:
                      const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Row(
                            mainAxisAlignment:
                            MainAxisAlignment.end,
                            children: [
                              Text(servicesList2[index],
                                  style: Theme.of(Get.context!)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                      color: AppColors
                                          .grayColor)),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(Icons.done_all_rounded,
                                  color: AppColors.grayColor,
                                  size: 15),
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

  reserverInformation(){
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
                  FilteringTextInputFormatter.allow(
                      RegExp('[ا-ی ئ و ]'))
                ],
                maxline: 1,
                onEditingComplete: () {
                  isTextFieldSelected.value = false;
                  FocusManager.instance.primaryFocus
                      ?.unfocus();
                },
                keyboardType: TextInputType.name,
                iconButton: isTextFieldSelected.value
                    ? IconButton(
                    onPressed: () {
                      nameController.clear();
                    },
                    icon: SvgPicture.asset(
                        'assets/icons/close_ic.svg'))
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
              FilteringTextInputFormatter.allow(
                  RegExp('[0-9]')),
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
              FilteringTextInputFormatter.allow(
                  RegExp('[0-9]')),
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
              FilteringTextInputFormatter.allow(
                  RegExp('[a-zA-Z0-9@_]')),
            ],
            textEditingController: emailController,
            maxline: 1,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: 10),
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: RichText(
                      textDirection: TextDirection.rtl,
                      text: TextSpan(
                          text: 'با ارسال این فرم ',style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color:AppColors.grayColor), children: [
                        TextSpan(text:'قوانین یواسپیس ',style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color:AppColors.mainColor,decoration: TextDecoration.underline), recognizer: TapGestureRecognizer()..onTap = () {
                          print('read form');
                          // Single tapped.
                        },),
                        TextSpan(text:'را میپذیرم و تایید میکنم که مدارک شناسایی و محرمیت معتبر را به همراه دارم',style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color:AppColors.grayColor)),
                      ])),
                ),
                const SizedBox(width:5),
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
                              : AppColors.grayColor
                              .withOpacity(0.7),
                          boxShadow: [
                            isAcceptTerms.value
                                ? BoxShadow(
                                color: AppColors
                                    .mainColor
                                    .withOpacity(0.1),
                                spreadRadius: 6,
                                blurRadius: 0.1)
                                : BoxShadow(
                                color: AppColors
                                    .mainColor
                                    .withOpacity(0.1),
                                spreadRadius: 6,
                                blurRadius: 0.1)
                          ]),
                    )),
                  ),
                ),
              ]),
          const SizedBox(height: 10),
          Obx(
                () => Directionality(
              textDirection: TextDirection.rtl,
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  items: dropDownItems
                      .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: Theme.of(Get.context!)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
                          color: AppColors.disabledText),
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
                      width: 200,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      offset: const Offset(-20, 0),
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
          const SizedBox(height: 10),
          Obx(
                () => Directionality(
              textDirection: TextDirection.rtl,
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  items: dropDownItems
                      .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: Theme.of(Get.context!)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
                          color: AppColors.disabledText),
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
                      width: 200,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      offset: const Offset(-20, 0),
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
            height: 50,
          ),

        ],
      ),
    );
  }

}
