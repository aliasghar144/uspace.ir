import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/controllers/register_reservation_controller.dart';
import 'package:uspace_ir/controllers/room_reservation_controller.dart';
import 'package:uspace_ir/pages/reservation/more_room_selection_screen.dart';
import 'package:uspace_ir/widgets/facilites_dialog.dart';
import 'package:uspace_ir/widgets/textfield.dart';

class RegisterReservationScreen extends StatelessWidget {
  RegisterReservationScreen({Key? key}) : super(key: key);

  final RoomReservationController roomReservationController = Get.find();
  final RegisterReservationController registerReservationController = Get.put(RegisterReservationController());


  final RxBool isExpansion = false.obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        return FocusManager.instance.primaryFocus?.unfocus();
      },
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
        body:SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height:25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('انتخاب اتاق های بیشتر',style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(fontSize: 16,color: AppColors.mainColor,),),
                    const SizedBox(width: 4,),
                    SvgPicture.asset('assets/icons/rooms_big_ic.svg',width: 30,),
                  ],
                ),
              ),
              const SizedBox(height:15),
              SizedBox(
                  width: Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        padding:const EdgeInsets.only(right: 15,top: 5,bottom:5,left: 10),
                        decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        width:0.3,color: AppColors.grayColor,
                      )
                        ),
                        child: Row(children: [
                          const Icon(Icons.arrow_drop_down,size:20,color:AppColors.grayColor),
                          const SizedBox(width:20),
                          Text('1 شب',style:Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color:Colors.black),textDirection: TextDirection.rtl,),
                          Text('به مدت: ',style:Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color:AppColors.grayColor),textDirection: TextDirection.rtl),
                        ],),
                      ),
                      const SizedBox(width:15),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        padding:const EdgeInsets.only(right: 15,top: 5,bottom:5,left: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width:0.3,color: AppColors.grayColor,
                            )
                        ),
                        child: Row(
                          children: [
                          const Icon(Icons.arrow_drop_down,size:20,color:AppColors.grayColor),
                          const SizedBox(width:20),
                          Text('22/04/1402',style:Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color:Colors.black),textDirection: TextDirection.rtl,),
                          Text('تاریخ ورود: ',style:Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color:AppColors.grayColor),textDirection: TextDirection.rtl),
                        ],),
                      ),
                      const Spacer(),
                    ],
                  )),
              const SizedBox(height:15),
              Container(
                height: 0.5,
                color: Colors.grey,
              ),
              const SizedBox(height:15),
              roomDetails(),
              const SizedBox(height:15),
              bookerDetails(),
              const SizedBox(height:25),
              button( ),
            ],
          ),
        )
      ),
    );
  }

  Widget roomDetails(){
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration:BoxDecoration(
            borderRadius:BorderRadius.circular(24),
            color: const Color(0xffF3F3F3),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.14),
                  blurRadius: 4,
                  offset: Offset(0, 4)
              ),
            ]
        ),
        child: Theme(
          data: ThemeData(
            dividerColor: Colors.transparent,
          ),
          child: ExpansionTile(
            onExpansionChanged: (value) {
              isExpansion.toggle();
            },
            expandedCrossAxisAlignment: CrossAxisAlignment.end,
            expandedAlignment: Alignment.topRight,
            shape: Border.all(color: Colors.transparent),
            trailing: const SizedBox(),
            tilePadding: const EdgeInsets.only(left: 20),
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap:(){
                        removeRoom();
                      },
                      child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration:const BoxDecoration(
                              shape: BoxShape.circle,
                              color:Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                  blurRadius: 4,
                                  offset: Offset(0,4),
                                )
                              ]
                          ),
                          child: SvgPicture.asset('assets/icons/trash_bin_ic.svg')
                      ),
                    ),
                    Text('اتاق سه تخته پریخان خانم هتل سنتی شیران _ اصفهان',style: Theme.of(Get.context!).textTheme.bodyMedium),
                  ],
                ),
                Obx(() => Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    isExpansion.value ? const Icon(Icons.keyboard_arrow_up,color: AppColors.grayColor,size:15,) : const Icon(Icons.keyboard_arrow_down,color: AppColors.mainColor,size:15),
                    isExpansion.value ? Text('اطلاعات کمتر',style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color: AppColors.grayColor),) : Text('اطلاعات بیشتر',style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color: AppColors.mainColor),),
                    const Spacer(),
                    RichText(
                        textDirection: TextDirection.rtl,
                        text: TextSpan(
                            children: [
                              TextSpan(text: 'چهارشنبه 28 تیر / پنج شنبه 29 تیر',style: Theme.of(Get.context!).textTheme.labelSmall),
                              const TextSpan(text: '\n\n'),
                              TextSpan(text: '${'4500000'.seRagham()} تومان',style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(fontSize: 18,color:AppColors.mainColor)),
                            ]
                        )),
                    const SizedBox(width: 8,),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: Get.width/5,
                      height: Get.width/5,
                      child: CachedNetworkImage(
                        imageUrl: 'https://shiranhotel.uspace.ir/spaces/shiranhotel/images/main/shiranhotel_uspace_1638686061.jpg',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),),
                const SizedBox(height: 10,)
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
                      onTap:(){
                        Get.dialog(facilityDialog(title: 'هتل سه تخته پریخان خانم هتل سنتی شیران_اصفهان',hasBrakeFast: false, hasDinner: true, hasLunch: false));
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
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                       Flexible(
                         child: Container(
                           height: Get.width / 5.0,
                           width: Get.width,
                           padding: const EdgeInsets.only(right:15),
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
                         ),
                       ),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.end,
                         children: [
                           Row(
                             children: [
                               Text('جزئیات قیمت',style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color:AppColors.grayColor),),
                               const SizedBox(width:5),
                               const Icon(Icons.info,color: AppColors.grayColor,size: 15,),
                             ],
                           ),
                           const SizedBox(height: 10,),
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
                                   width: Get.width / 3.2,
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
                           ))
                         ],
                       ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                  ],
                ),
              )
            ],),
        ));
  }

  Widget bookerDetails(){
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
                registerReservationController.isTextFieldSelected.value = value;
              },
              child: Obx(() => MyTextField(
                label: 'نام و نام خانوادگی',
                verticalScrollPadding: 15,
                textEditingController: registerReservationController.nameController,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[ا-ی ئ و ]'))],
                maxline: 1,
                onEditingComplete: () {
                  registerReservationController.isTextFieldSelected.value = false;
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                keyboardType: TextInputType.name,
                iconButton: registerReservationController.isTextFieldSelected.value
                    ? IconButton(
                    splashRadius: 20,
                    onPressed: () {
                      registerReservationController.nameController.clear();
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
            textEditingController: registerReservationController.phoneNumberController,
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
            textEditingController: registerReservationController.homeNumberController,
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
            textEditingController: registerReservationController.emailController,
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
                          print('read form');
                          // Single tapped.
                        },
                    ),
                    TextSpan(text: 'را میپذیرم و تایید میکنم که مدارک شناسایی و محرمیت معتبر را به همراه دارم', style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color: AppColors.grayColor)),
                  ])),
            ),
            const SizedBox(width: 5),
            InkWell(
              onTap: () {
                registerReservationController.isAcceptTerms.toggle();
              },
              borderRadius: BorderRadius.circular(100),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
                child: Obx(() => Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: registerReservationController.isAcceptTerms.value ? AppColors.mainColor : AppColors.grayColor.withOpacity(0.7), boxShadow: [registerReservationController.isAcceptTerms.value ? BoxShadow(color: AppColors.mainColor.withOpacity(0.1), spreadRadius: 6, blurRadius: 0.1) : BoxShadow(color: AppColors.mainColor.withOpacity(0.1), spreadRadius: 6, blurRadius: 0.1)]),
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
                  items: registerReservationController.cancellationConditionItems
                      .map((item) => DropdownMenuItem<String>(
                    value: item,
                    alignment: Alignment.centerRight,
                    child: Text(
                      item,
                      style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: AppColors.disabledText),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
                      .toList(),
                  value: registerReservationController.cancellationConditionValue.value,
                  onChanged: (value) {
                    registerReservationController.cancellationConditionValue.value = value as String;
                  },
                  buttonStyleData: ButtonStyleData(
                    height: 50,
                    width: Get.width,
                    padding: const EdgeInsets.only(right: 15, left: 5, top: 5, bottom: 2),
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
                  items: registerReservationController.babyRoleDropDownItems
                      .map((item) => DropdownMenuItem<String>(
                    value: item,
                    alignment: Alignment.centerRight,
                    child: Text(
                      item,
                      style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: AppColors.disabledText),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
                      .toList(),
                  value: registerReservationController.babyRoleDropDownValue.value,
                  onChanged: (value) {
                    registerReservationController.babyRoleDropDownValue.value = value as String;
                  },
                  buttonStyleData: ButtonStyleData(
                    height: 50,
                    width: Get.width,
                    padding: const EdgeInsets.only(right: 15, left: 5, top: 5, bottom: 2),
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
        ],
      ),
    );
  }

  void removeRoom() {
    Get.dialog(Dialog (
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(23)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              width: Get.width,
              height: Get.height / 6.5,
              clipBehavior: Clip.hardEdge,
              margin: const EdgeInsets.only(right: 10,left: 10,top: 12),
              decoration: const BoxDecoration(color: Colors.red, borderRadius: BorderRadius.only(topRight: Radius.circular(18), topLeft: Radius.circular(18))),
              child: CachedNetworkImage(
                imageUrl: "https://shiranhotel.uspace.ir/spaces/shiranhotel/images/main/shiranhotel_uspace_1638686061.jpg",
                fit: BoxFit.fill,
                errorWidget: (context, url, error) => const Icon(Icons.broken_image_outlined),
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

  Widget button(){
    return Padding(
      padding: const EdgeInsets.only(bottom:15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: (){
              Get.to(const MoreRoomSelectionScreen());
            },
            child: Container(
              height: 55,
              width: Get.width / 1.5,
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(50),
                color: AppColors.mainColor,
              ),
              child: Center(child: Text('ارسال و پرداخت',style: Theme.of(Get.context!).textTheme.displayMedium!.copyWith(fontSize:18,color:Colors.white),)),
            ),
          ),
        ],
      ),
    );
  }

}
