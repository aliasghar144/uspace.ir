import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/widgets/facilites_dialog.dart';
import 'package:uspace_ir/controllers/register_reservation_controller.dart';
import 'package:uspace_ir/controllers/reservation_controller.dart';

class MoreRoomSelectionScreen extends StatelessWidget {
  MoreRoomSelectionScreen({Key? key}) : super(key: key);

  final RegisterReservationController mainController = Get.find();
  final ReservationController reservationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            topScreen(),
            const SizedBox(height:10),
            rooms(),
            const SizedBox(height:20),
          ],
        ),
      ),
      bottomNavigationBar: button(),
    );
  }

  Widget topScreen(){
    return Column(
      children: [
        const SizedBox(height:25),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('انتخاب اتاق های بیشتر',style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(fontSize: 16,color: AppColors.grayColor,),),
              const SizedBox(width: 4,),
              SvgPicture.asset('assets/icons/rooms_big_ic.svg',width: 30,color: Colors.grey,),
            ],
          ),
        ),
        const SizedBox(height:15),
        Container(
          height: 0.5,
          color: Colors.grey,
        ),
        const SizedBox(height:15),
      ],
    );
  }

  Widget rooms(){
    return ListView.separated(
      itemCount: reservationController.room.value!.data.rooms.length,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10);
      },
      itemBuilder: (context, roomsIndex) {
        return Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.roomsBackground,),
            child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  reservationController.room.value!.data.rooms[roomsIndex].title,
                  style: Theme.of(Get.context!).textTheme.bodyMedium,
                  textAlign: TextAlign.end,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.dialog(facilityDialog(
                                roomFeatures:reservationController.room.value!.data.rooms[roomsIndex].features,
                                title: reservationController.room.value!.data.rooms[roomsIndex].title,
                                hasBrakeFast: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[0].value,
                                hasDinner: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[1].value,
                                hasLunch: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].features[2].value
                            ));
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColors.mainColor.withOpacity(0.8),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              child: Row(children: [
                                Text('امکانات',
                                    style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(
                                      color: Colors.white,
                                    )),
                                const SizedBox(width: 4),
                                SvgPicture.asset('assets/icons/facilities_ic.svg'),
                              ])),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'توضیحات:',
                          style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: Colors.grey),
                          textDirection: TextDirection.rtl,
                        ),
                        Text('دارای تشک برای 3 نفر', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: Colors.grey)),
                        reservationController.durationValue.value != 1 ?
                        RichText(
                          textDirection: TextDirection.rtl,
                          text: TextSpan(children: [
                            TextSpan(text: 'قیمت یک شب: ', style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.grey)),
                            TextSpan(text: (reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.totalOriginalPrice ~/ reservationController.durationValue.value).toString().seRagham(), style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.black.withOpacity(0.7))),
                            TextSpan(text: ' تومان', style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.black.withOpacity(0.7))),
                          ]),
                        ):const SizedBox(),
                        const SizedBox(height: 5),
                        reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.totalCustomerDiscount != 0
                            ? RichText(
                          textDirection: TextDirection.rtl,
                          text: TextSpan(children: [
                            TextSpan(text: 'قیمت یک شب: ', style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.grey, decoration: roomsIndex == 0 ? TextDecoration.lineThrough : null)),
                            TextSpan(text: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.totalOriginalPrice.toString().seRagham(), style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.black.withOpacity(0.7), decoration: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.totalCustomerDiscount != 0 ? TextDecoration.lineThrough : null)),
                            TextSpan(text: ' تومان', style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.black.withOpacity(0.7), decoration: roomsIndex == 0 ? TextDecoration.lineThrough : null)),
                          ]),
                        )
                            : const SizedBox(),
                        reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.totalCustomerDiscount != 0
                            ? Container(
                          margin: const EdgeInsets.only(top: 5, bottom: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: AppColors.redColor.withOpacity(0.8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          child: RichText(
                            textDirection: TextDirection.rtl,
                            text: TextSpan(children: [
                              TextSpan(text: (reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.totalOriginalPrice - reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.totalCustomerPrice).toString().seRagham(), style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: Colors.white)),
                              TextSpan(text: 'تومان تخفیف', style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: Colors.white)),
                            ]),
                          ),
                        )
                            : const SizedBox(),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.grey.withOpacity(0.12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          child: RichText(
                            textDirection: TextDirection.rtl,
                            text: TextSpan(children: [
                              TextSpan(text: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.totalCustomerPrice.toString().seRagham(), style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(color: AppColors.mainColor)),
                              TextSpan(text: ' تومان ', style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(color: AppColors.mainColor)),
                              TextSpan(text: 'برای ', style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.grey)),
                              TextSpan(text: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.durationDay.toString(), style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color: Colors.grey)),
                              TextSpan(text: ' شب', style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.grey)),
                            ]),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Hero(
                      tag: roomsIndex,
                      child: CachedNetworkImage(
                        height: Get.width / 3.5,
                        width: Get.width / 4,
                        progressIndicatorBuilder: (context, url, progress) {
                          return const Align(
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                              color: AppColors.mainColor,
                            ),
                          );
                        },
                        errorWidget: (context, url, error) {
                          return Container(
                            clipBehavior: Clip.none,
                            width: Get.width / 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset('assets/images/image_not_available.png',fit: BoxFit.scaleDown,),
                          );
                        },
                        imageUrl: reservationController.room.value!.data.rooms[roomsIndex].thumbImage,
                        fit: BoxFit.cover,
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            clipBehavior: Clip.none,
                            width: Get.width / 4,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.topRight,
                height: Get.width / 5.0,
                padding: const EdgeInsets.symmetric(horizontal:5),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: ListView.separated(
                    itemCount: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.days.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context,index) {
                      return const SizedBox(width: 10);
                    },
                    itemBuilder: (context, roomIndex) {
                      if(reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.status == 'unavailable'){
                        return Container(
                          width:Get.width/4.55,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 0.4, color: AppColors.mainColor)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width:Get.width/4.55,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.redColor.withOpacity(0.1),
                                ),
                                child: Text(reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.days[roomIndex].date.toPersianDateStr(showDayStr: true,), style: Theme.of(Get.context!).textTheme.labelSmall),
                              ),
                              const Spacer(),
                              Text( 'ناموجود', style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color: AppColors.redColor)),
                              const SizedBox(height: 3)
                            ],
                          ),
                        );
                      }else{
                        return Container(
                          width:Get.width/4.55,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 0.4, color: AppColors.mainColor)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width:Get.width/4.55,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.mainColor.withOpacity(0.1),
                                ),
                                child: Text(reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.days[roomIndex].date.toPersianDateStr(showDayStr: true,), style: Theme.of(Get.context!).textTheme.labelSmall),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                '${reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.days[roomIndex].originalPrice.toString().seRagham()} تومان',
                                style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color: AppColors.grayColor),
                                textDirection: TextDirection.rtl,
                              ),
                              const SizedBox(height: 3),
                              Text(
                                reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.days[roomIndex].additionalGustPrice == 0 ? 'نفر اضافه ندارد' :  'نفر اضافه: ${reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.days[roomIndex].additionalGustPrice.toString().seRagham()} تومان',
                                style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color: AppColors.grayColor),
                                textDirection: TextDirection.rtl,
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.days[roomIndex].availability == 'available' ?  Container(
                                      decoration: const BoxDecoration(
                                        color: AppColors.mainColor,
                                        shape: BoxShape.circle,
                                      ),
                                      padding: const EdgeInsets.all(2),
                                      child: const Icon(Icons.done_rounded, size: 6, color: Colors.white)) : const SizedBox(),
                                  reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.days[roomIndex].availability == 'available' ? const SizedBox(width: 2) : const SizedBox(),
                                  Text( reservationController.roomAvailabilityCheck(reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.days[roomIndex].availability), style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color: AppColors.mainColor)),
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
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical:5),
                  decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1), borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5))),
                  child: Get.width>350 ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Flexible(
                      flex: 3,
                      child: Obx(()=>InkWell(
                        onTap:() {
                          if(reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.reservePermission && mainController.reserveCheck(reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.idSalesPackage).value){
                            mainController.addRoom([reservationController.room.value!.data.rooms[roomsIndex]]);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.reservePermission && mainController.reserveCheck(reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.idSalesPackage).value ? AppColors.mainColor : AppColors.disabledIcon,
                          ),
                          child: Text(reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.reservePermission && mainController.reserveCheck(reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.idSalesPackage).value ? 'رزرو اتاق' : 'رزرو شده', style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(fontSize: 16, color: Colors.white)),
                        ),
                      )),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      flex: 2,
                      child: Container(
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
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      flex: 2,
                      child: Container(
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
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      flex: 2,
                      child: Container(
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
                    ),
                  ]) : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Obx(()=>InkWell(
                      onTap:() {
                        if(reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.reservePermission && mainController.reserveCheck(reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.idSalesPackage).value){
                          mainController.addRoom([reservationController.room.value!.data.rooms[roomsIndex]]);
                        }
                      },
                      child: Container(
                        width:Get.width/3,
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.reservePermission && mainController.reserveCheck(reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.idSalesPackage).value ? AppColors.mainColor : AppColors.disabledIcon,
                        ),
                        child: Text(reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.reservePermission && mainController.reserveCheck(reservationController.room.value!.data.rooms[roomsIndex].roomPackages[0].finance.priceInfo.idSalesPackage).value ? 'رزرو اتاق' : 'رزرو شده', style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(fontSize: 16, color: Colors.white)),
                      ),
                    )),
                    const SizedBox(width:10),
                    Column(
                      children: [
                        Container(
                          width:Get.width/3,
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
                        const SizedBox(height: 5),
                        Container(
                          width:Get.width/3,
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
                        const SizedBox(height: 5),
                        Container(
                          width:Get.width/3,
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
                      ],
                    ),
                  ])),
            ]));
      },
    );
  }

  Widget button(){
    return Container(
      decoration: const BoxDecoration(
          color: Colors.transparent,),
      padding: const EdgeInsets.only(bottom:10,top:10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: (){
              Get.back();
            },
            child: Container(
              height: 55,
              width: Get.width / 1.5,
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(50),
                color: AppColors.mainColor,
              ),
              child: Center(child: Text('انتخاب',style: Theme.of(Get.context!).textTheme.displayMedium!.copyWith(fontSize:18,color:Colors.white),)),
            ),
          ),
        ],
      ),
    );
  }

}
