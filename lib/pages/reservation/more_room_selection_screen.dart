import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/pages/reservation/factors_screen.dart';
import 'package:uspace_ir/pages/reservation/reserve_room_screen.dart';
import 'package:uspace_ir/widgets/facilites_dialog.dart';

class MoreRoomSelectionScreen extends StatelessWidget {
  const MoreRoomSelectionScreen({Key? key}) : super(key: key);

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
          ],
        ),
      ),
      bottomSheet: button(),
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
      ],
    );
  }

  Widget rooms(){
    return             ListView.separated(
      itemCount: 3,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10);
      },
      itemBuilder: (context, index) {
        return Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.mainColor.withOpacity(0.05),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'اتاق سه تخت پریخان خانم هتل سنتی شیران اصفهان',
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
                            Get.dialog(facilityDialog(title: 'هتل سه تخته پریخان خانم هتل سنتی شیران_اصفهان',hasBrakeFast: false, hasDinner: true, hasLunch: false));
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
                        const SizedBox(height: 5),
                        RichText(
                          textDirection: TextDirection.rtl,
                          text: TextSpan(children: [
                            TextSpan(text: 'قیمت یک شب: ', style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.grey, decoration: index == 0 ? TextDecoration.lineThrough : null)),
                            TextSpan(text: '20000000'.beToman().seRagham(), style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.black.withOpacity(0.7), decoration: index == 0 ? TextDecoration.lineThrough : null)),
                            TextSpan(text: ' تومان', style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.black.withOpacity(0.7), decoration: index == 0 ? TextDecoration.lineThrough : null)),
                          ]),
                        ),
                        index == 0
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
                              TextSpan(text: '1150000'.beToman().seRagham(), style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: Colors.white)),
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
                              TextSpan(text: '20000000'.beToman().seRagham(), style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(color: AppColors.mainColor)),
                              TextSpan(text: ' تومان ', style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(color: AppColors.mainColor)),
                              TextSpan(text: 'برای', style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.grey)),
                              TextSpan(text: ' 2 ', style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color: Colors.grey)),
                              TextSpan(text: 'شب', style: Theme.of(Get.context!).textTheme.labelMedium!.copyWith(color: Colors.grey)),
                            ]),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Hero(
                      tag:'Room$index',
                      child: CachedNetworkImage(
                        height: Get.width / 3.5,
                        width: Get.width / 3.5,
                        imageUrl: "https://www.uspace.ir/public/img/ecolodge/categories/trade-hotel2.jpg",
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
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1), borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                        Flexible(
                          flex: 3,
                          child: InkWell(
                            onTap:(){
                              Get.to(RoomReservationScreen(),arguments: index);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: AppColors.mainColor,
                              ),
                              child: Text('رزرو اتاق', style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(fontSize: 16, color: Colors.white)),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(width: 0.1),
                            ),
                            child: Row(children: [
                              Text('صبحانه دارد', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.mainColor)),
                              const SizedBox(width: 2),
                              SvgPicture.asset('assets/icons/lunch_ic.svg'),
                            ]),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(width: 0.1),
                            ),
                            child: Row(children: [
                              Text('صبحانه دارد', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.mainColor)),
                              const SizedBox(width: 2),
                              SvgPicture.asset('assets/icons/dinner_ic.svg'),
                            ]),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(width: 0.1),
                            ),
                            child: Row(children: [
                              Text('صبحانه دارد', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.mainColor)),
                              const SizedBox(width: 2),
                              SvgPicture.asset('assets/icons/breakfast_ic.svg'),
                            ]),
                          ),
                        ),
                      ]),
                      const SizedBox(
                        height: 5,
                      ),
                      ListView.separated(
                        itemCount: 3,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 5);
                        },
                        itemBuilder: (context, index) {
                          return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                            Text('امکان پیاده روی در اطراف اقامتگاه را دارد', style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: AppColors.mainColor)),
                            const SizedBox(width: 5),
                            Container(padding: const EdgeInsets.all(3), decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.mainColor), child: const Icon(Icons.done, color: Colors.white, size: 10)),
                          ]);
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )),
            ]));
      },
    );
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
              Get.to(FactorsScreen());
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
